/// <summary>
/// Table for trades
/// </summary>
namespace PwC.Securities.Trade;

using PwC.Securities;
using Microsoft.Finance.Currency;
using Microsoft.Bank.BankAccount;
using Microsoft.Finance.GeneralLedger.Setup;

table 79903 Trade
{
    Caption = 'Trade';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "No."; Code[20])
        {
            ToolTip = 'Specifies the unique identifier for the trade transaction.';
        }
        field(2; "Security No."; Code[20])
        {
            TableRelation = "Security"."No.";
            ToolTip = 'Specifies the security that is being traded in this transaction.';
        }
        field(3; "Trade Type"; Enum "Trade Type")
        {
            ToolTip = 'Specifies whether this is a buy or sell transaction.';
        }
        field(4; "Quantity"; Decimal)
        {
            ToolTip = 'Specifies the number of shares or units being traded.';
        }
        field(5; "Price (Trade Curr)"; Decimal)
        {
            ToolTip = 'Specifies the price per unit in the trade currency.';
        }
        field(6; "Currency Code"; Code[10])
        {
            TableRelation = Currency.Code;
            ToolTip = 'Specifies the currency code for the trade. If blank, the local currency is used.';
        }
        field(7; "Posting Date"; Date)
        {
            ToolTip = 'Specifies the date when the trade transaction occurred.';
        }
        field(8; "Document No."; Code[20])
        {
            ToolTip = 'Specifies the document number associated with this trade transaction.';
        }
        field(9; "Bank Account No."; Code[20])
        {
            TableRelation = "Bank Account"."No.";
            ToolTip = 'Specifies the bank account used for settlement of this trade.';
        }
        field(10; "Posted"; Boolean)
        {
            Editable = false;
            ToolTip = 'Indicates whether this trade has been posted. Posted trades cannot be modified.';
        }
        field(11; "Amount (Trade Curr)"; Decimal)
        {
            Editable = false;
            ToolTip = 'Shows the total trade amount in the trade currency (calculated as Quantity × Price).';
        }
        field(12; "Amount (LCY)"; Decimal)
        {
            Editable = false;
            ToolTip = 'Shows the total trade amount converted to the local currency using the exchange rate.';
        }
        field(13; "Exchange Rate"; Decimal)
        {
            Editable = false;
            Caption = 'Curr. Factor (LCY per unit)';
            ToolTip = 'Shows the exchange rate used to convert the trade currency amount to local currency.';
        }
        field(14; "Fee Amount (Trade Curr)"; Decimal)
        {
            Caption = 'Fee Amount (Trade Currency)';
            ToolTip = 'Specifies the fee amount in the trade currency.';
        }

        field(15; "Fee Amount (LCY)"; Decimal)
        {
            Caption = 'Fee Amount (LCY)';
            Editable = false;
            ToolTip = 'Specifies the fee amount converted to the local currency using the exchange rate.';
        }
    }

    keys { key(PK; "No.") { Clustered = true; } }

    trigger OnModify()
    begin
        // lock posted records
        if Posted then
            Error('Trade %1 is posted.', "No.");
    end;

    procedure CalcAmounts()
    var
        CurrExchRate: Record "Currency Exchange Rate";
        GLSetup: Record "General Ledger Setup";
        Amount: Decimal;
        Rate: Decimal;
    begin
        Amount := Round("Quantity" * "Price (Trade Curr)", 0.01);
        "Amount (Trade Curr)" := Amount;

        GLSetup.Get();
        if "Currency Code" = '' then begin
            "Exchange Rate" := 1;
            "Amount (LCY)" := Amount + "Fee Amount (Trade Curr)";
            "Fee Amount (LCY)" := "Fee Amount (Trade Curr)";
            exit;
        end;

        Rate := CurrExchRate.ExchangeRate("Posting Date", "Currency Code");
        // TODO PK: use currency factor
        // if Rate = 0 then
        //    Rate := CurrExchRate.GetCurrentFactor("Currency Code", "Posting Date");
        if Rate = 0 then
            Error('No exchange rate for %1 on %2', "Currency Code", "Posting Date");

        "Exchange Rate" := Rate;
        "Fee Amount (LCY)" := Round("Fee Amount (Trade Curr)" * Rate, 0.01);

        // nettobeløb inkl. kurtage
        "Amount (LCY)" := Round(Amount * Rate, 0.01) + "Fee Amount (LCY)";
    end;
}
