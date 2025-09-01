/// <summary>
/// Report for security FX revaluation
/// </summary>
namespace PwC.Securities.Currency;

using Microsoft.Finance.GeneralLedger.Journal;
using Microsoft.Finance.GeneralLedger.Posting;
using Microsoft.Finance.Currency;
using PwC.Securities.Ledgers;
using PwC.Securities;
using Microsoft.Finance.GeneralLedger.Setup;
using PwC.Base.Setup;

report 79905 "Security FX Revaluation"
{
    UsageCategory = Tasks;
    ApplicationArea = All;
    Caption = 'Security FX Revaluation';
    ProcessingOnly = true;

    dataset { }

    requestpage
    {
        layout
        {
            area(content)
            {
                group(Options)
                {
                    field("As of Date"; AsOfDate) { ApplicationArea = All; }
                    field("Post Entries"; DoPost) { ApplicationArea = All; }
                }
            }
        }
    }

    var
        AsOfDate: Date;
        DoPost: Boolean;
        Ledg: Record "Security Ledger Entry";
        Sec: Record "Security";
        Setup: Record "Securities Setup";
        CurrExchRate: Record "Currency Exchange Rate";
        JnlLine: Record "Gen. Journal Line";
        JnlPostLine: Codeunit "Gen. Jnl.-Post Line";
        NewLCY: Decimal;
        Diff: Decimal;
        Rate: Decimal;

    trigger OnPreReport()
    begin
        if AsOfDate = 0D then
            AsOfDate := Today();
        Setup.Get();
        Setup.TestField("Unreal. Gain G/L");
        Setup.TestField("Unreal. Loss G/L");
        Setup.TestField("Gen. Jnl. Template");
        Setup.TestField("Gen. Jnl. Batch");

        Ledg.Reset();
        Ledg.SetFilter("Remaining Quantity", '>%1', 0);
        if Ledg.FindSet(true) then
            repeat
                Sec.Get(Ledg."Security No.");
                if (Sec."Currency Code" = '') or (Sec."Currency Code" = GLSetupLCY()) then
                    continue;

                Rate := CurrExchRate.ExchangeRate(AsOfDate, Sec."Currency Code");
                // TODO PK: use currency factor
                //if Rate = 0 then
                //    Rate := CurrExchRate.GetCurrentFactor(Sec."Trading Currency Code", AsOfDate);
                if Rate = 0 then
                    Error('No exchange rate for %1 on %2', Sec."Currency Code", AsOfDate);

                // Revalue remaining quantity's cost from trade currency -> LCY at new rate
                NewLCY := Round((Ledg."Unit Cost (Trade Curr)" * Ledg."Remaining Quantity") * Rate, 0.01);
                Diff := NewLCY - CurrentLCYValue(Ledg);

                if Diff <> 0 then begin
                    Ledg."Unrealized G/L (LCY)" := Diff;
                    Ledg.Modify(true);

                    if DoPost then
                        PostUnrealized(Diff, Ledg."Document No.");
                end;
            until Ledg.Next() = 0;
    end;

    local procedure GLSetupLCY(): Code[10]
    var
        GL: Record "General Ledger Setup";
    begin
        GL.Get();
        exit(GL."LCY Code");
    end;

    local procedure CurrentLCYValue(Ledg: Record "Security Ledger Entry"): Decimal
    begin
        exit(Round((Ledg."Amount (LCY)" / Ledg.Quantity) * Ledg."Remaining Quantity", 0.01));
    end;

    local procedure PostUnrealized(Diff: Decimal; DocNo: Code[20])
    begin
        Clear(JnlLine);
        JnlLine.Init();
        JnlLine.Validate("Journal Template Name", Setup."Gen. Jnl. Template");
        JnlLine.Validate("Journal Batch Name", Setup."Gen. Jnl. Batch");
        JnlLine."Posting Date" := AsOfDate;
        JnlLine."Document No." := CopyStr('FXREV-' + DocNo, 1, 20);
        JnlLine."Account Type" := JnlLine."Account Type"::"G/L Account";
        if Diff > 0 then
            JnlLine.Validate("Account No.", Setup."Unreal. Gain G/L")
        else
            JnlLine.Validate("Account No.", Setup."Unreal. Loss G/L");
        JnlLine.Validate(Amount, Diff);
        JnlPostLine.RunWithCheck(JnlLine);
    end;
}
