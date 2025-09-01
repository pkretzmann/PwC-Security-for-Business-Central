/// <summary>
/// Codeunit for posting trades
/// </summary>
namespace PwC.Securities.Posting;

using PwC.Base.Setup;
using PwC.Securities.Ledgers;
using PwC.Securities;
using Microsoft.Finance.GeneralLedger.Journal;
using Microsoft.Finance.GeneralLedger.Posting;
using PwC.Securities.Trade;

codeunit 79904 "Trade Posting"
{
    procedure Post(var Trade: Record "Trade")
    var
        Setup: Record "Securities Setup";
        SecLedg: Record "Security Ledger Entry";
        Sec: Record "Security";
        JnlLine: Record "Gen. Journal Line";
        JnlPostLine: Codeunit "Gen. Jnl.-Post Line";
        DocNo: Code[20];
        GrossLCY: Decimal;
        FeeLCY: Decimal;
        NetLCY: Decimal;
        GrossTCY: Decimal;
        Qty: Decimal;
        IsBuy: Boolean;
    begin
        if Trade.Posted then
            Error('Already posted.');
        Trade.TestField("Security No.");
        Trade.TestField("Posting Date");
        Trade.TestField("Quantity");
        Trade.TestField("Price (Trade Curr)");

        Trade.CalcAmounts();

        Setup.Get('SETUP');
        Setup.TestField("Investment G/L Acct");
        Setup.TestField("Bank Account No.");
        Setup.TestField("Gen. Jnl. Template");
        Setup.TestField("Gen. Jnl. Batch");
        if not Setup."Capitalize Fees" then
            Setup.TestField("Fee Account"); // påkrævet hvis fees udgiftsføres

        Sec.Get(Trade."Security No.");

        DocNo := SelectStr(1, Format(Trade."Document No.")) + Trade."No.";
        Qty := Trade."Quantity";
        GrossLCY := Trade."Amount (LCY)";
        FeeLCY := Trade."Fee Amount (LCY)";
        NetLCY := GrossLCY - FeeLCY; // salgsnetto eller købsnetto afhængigt af kontekst
        GrossTCY := Trade."Amount (Trade Curr)";

        IsBuy := Trade."Trade Type" = "Trade Type"::Buy;

        if IsBuy then begin
            // --- Ledger entry: kost = gross + fee
            SecLedg.Init();
            SecLedg.Validate("Security No.", Trade."Security No.");
            SecLedg.Validate("Posting Date", Trade."Posting Date");
            SecLedg.Validate("Document No.", Trade."Document No.");
            SecLedg.Validate("Quantity", Qty);
            SecLedg.Validate("Unit Cost (Trade Curr)",
                (GrossTCY + Trade."Fee Amount (Trade Curr)") / Qty);
            SecLedg.Validate("Amount (Trade Curr)", GrossTCY + Trade."Fee Amount (Trade Curr)");
            SecLedg.Validate("Currency Code", Trade."Currency Code");
            SecLedg.Validate("Amount (LCY)", GrossLCY + FeeLCY);
            SecLedg.Validate("Remaining Quantity", Qty);
            SecLedg.Insert();

            // --- G/L
            if Setup."Capitalize Fees" then begin
                // DR Investment = gross + fee
                PostGL(Setup, JnlLine, JnlPostLine, Trade, Setup."Investment G/L Acct", (GrossLCY + FeeLCY), true);
                // CR Bank      = -(gross + fee)
                PostBank(Setup, JnlLine, JnlPostLine, Trade, -(GrossLCY + FeeLCY));
            end else begin
                // DR Investment = gross
                PostGL(Setup, JnlLine, JnlPostLine, Trade, Setup."Investment G/L Acct", GrossLCY, true);
                // DR Fee       = fee
                if FeeLCY <> 0 then
                    PostGL(Setup, JnlLine, JnlPostLine, Trade, Setup."Fee Account", FeeLCY, true);
                // CR Bank      = -(gross + fee)
                PostBank(Setup, JnlLine, JnlPostLine, Trade, -(GrossLCY + FeeLCY));
            end;

        end else begin
            // --- SELL: forbrug FIFO og få kost i LCY
            RealizeFIFO(Trade, NetLCY, GrossLCY, FeeLCY, Setup); // beregner P/L og poster G/L (investment + P/L)

            // Bank-indbetaling
            if Setup."Capitalize Fees" then
                PostBank(Setup, JnlLine, JnlPostLine, Trade, NetLCY)      // DR Bank netto
            else begin
                PostBank(Setup, JnlLine, JnlPostLine, Trade, GrossLCY);   // DR Bank brutto
                if FeeLCY <> 0 then
                    PostGL(Setup, JnlLine, JnlPostLine, Trade, Setup."Fee Account", FeeLCY, true); // DR Fee
            end;
        end;

        Trade."Posted" := true;
        Trade.Modify(true);
    end;

    local procedure RealizeFIFO(Trade: Record "Trade"; NetProceedsLCY: Decimal; GrossProceedsLCY: Decimal; FeeLCY: Decimal; Setup: Record "Securities Setup")
    var
        Ledg: Record "Security Ledger Entry";
        JnlLine: Record "Gen. Journal Line";
        JnlPostLine: Codeunit "Gen. Jnl.-Post Line";
        QtyToSell: Decimal;
        QtyTake: Decimal;
        CostLCYTaken: Decimal;
        RealizedGL: Decimal;
    begin
        QtyToSell := Trade."Quantity";
        Ledg.Reset();
        Ledg.SetRange("Security No.", Trade."Security No.");
        Ledg.SetFilter("Remaining Quantity", '>%1', 0);
        Ledg.SetRange(Closed, false);
        Ledg.SetCurrentKey("Security No.", "Posting Date");
        if not Ledg.FindSet() then
            Error('No open lots to sell for %1.', Trade."Security No.");

        repeat
            if QtyToSell = 0 then break;
            QtyTake := Min(QtyToSell, Ledg."Remaining Quantity");
            CostLCYTaken += Round((Ledg."Amount (LCY)" / Ledg."Quantity") * QtyTake, 0.01);
            Ledg."Remaining Quantity" := Ledg."Remaining Quantity" - QtyTake;
            if Ledg."Remaining Quantity" = 0 then Ledg.Closed := true;
            Ledg.Modify(true);
            QtyToSell -= QtyTake;
        until (Ledg.Next() = 0);

        if QtyToSell <> 0 then
            Error('Not enough quantity to sell.');

        // P/L beregnes på NETTOPROVENU (brutto - fee)
        RealizedGL := NetProceedsLCY - CostLCYTaken;

        // CR Investment (ud af balancen) til kost
        PostGL(Setup, JnlLine, JnlPostLine, Trade, Setup."Investment G/L Acct", -CostLCYTaken, true);

        // +/- Realized G/L
        if RealizedGL <> 0 then
            PostGL(Setup, JnlLine, JnlPostLine, Trade,
                (RealizedGL > 0) ? Setup."Realized Gain G/L" : Setup."Realized Loss G/L",
                RealizedGL, true);
    end;

    local procedure PostGL(Setup: Record "Securities Setup"; var JnlLine: Record "Gen. Journal Line"; var JnlPostLine: Codeunit "Gen. Jnl.-Post Line"; Trade: Record "Trade"; GLNo: Code[20]; AmountLCY: Decimal; IsGL: boolean)
    begin
        Clear(JnlLine);
        JnlLine.Init();
        JnlLine.Validate("Journal Template Name", Setup."Gen. Jnl. Template");
        JnlLine.Validate("Journal Batch Name", Setup."Gen. Jnl. Batch");
        JnlLine."Posting Date" := Trade."Posting Date";
        JnlLine."Document No." := Trade."Document No.";
        JnlLine."Account Type" := JnlLine."Account Type"::"G/L Account";
        JnlLine.Validate("Account No.", GLNo);
        JnlLine.Validate(Amount, AmountLCY);
        JnlPostLine.RunWithCheck(JnlLine);
    end;

    local procedure PostBank(Setup: Record "Securities Setup"; var JnlLine: Record "Gen. Journal Line"; var JnlPostLine: Codeunit "Gen. Jnl.-Post Line"; Trade: Record "Trade"; AmountLCY: Decimal)
    begin
        Clear(JnlLine);
        JnlLine.Init();
        JnlLine.Validate("Journal Template Name", Setup."Gen. Jnl. Template");
        JnlLine.Validate("Journal Batch Name", Setup."Gen. Jnl. Batch");
        JnlLine."Posting Date" := Trade."Posting Date";
        JnlLine."Document No." := Trade."Document No.";
        JnlLine."Account Type" := JnlLine."Account Type"::"Bank Account";
        if Trade."Bank Account No." <> '' then
            JnlLine.Validate("Account No.", Trade."Bank Account No.")
        else
            JnlLine.Validate("Account No.", Setup."Bank Account No.");
        JnlLine.Validate(Amount, AmountLCY);
        JnlPostLine.RunWithCheck(JnlLine);
    end;

    local procedure Min(QtyToSell: Decimal; RemainingQuantity: Decimal): Decimal
    begin
        if QtyToSell < RemainingQuantity then
            exit(QtyToSell);
        exit(RemainingQuantity);
    end;
}
