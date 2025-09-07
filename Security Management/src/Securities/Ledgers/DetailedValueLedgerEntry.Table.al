/// <summary>
/// Table for detailed value ledger entries
/// </summary>
namespace PwC.Securities.Ledgers;

using PwC.Securities.Security;
using PwC.Securities.Journals;

table 79914 "Detailed Value Ledger Entry"
{
    Caption = 'Detailed Value Ledger Entry';
    LookupPageId = "Detailed Value Ledger Entries";
    DrillDownPageId = "Detailed Value Ledger Entries";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            ToolTip = 'Specifies the number of the detailed value ledger entry.';
            AutoIncrement = true;
        }
        field(2; "Security Ledger Entry No."; Integer)
        {
            Caption = 'Security Ledger Entry No.';
            ToolTip = 'Specifies the security ledger entry number.';
            TableRelation = "Security Ledger Entry"."Entry No.";
        }
        field(3; "Purchase Ledger Entry No."; Integer)
        {
            Caption = 'Purchase Ledger Entry No.';
            ToolTip = 'Specifies the purchase ledger entry number.';
            TableRelation = "Security Ledger Entry"."Entry No.";
        }
        field(4; "Posting Date"; DateTime)
        {
            Caption = 'Posting Date';
            ToolTip = 'Specifies the posting date of the entry.';
        }
        field(5; "Trading Date"; DateTime)
        {
            Caption = 'Trading Date';
            ToolTip = 'Specifies the trading date of the entry.';
        }
        field(6; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            ToolTip = 'Specifies the document number.';
        }
        field(7; "Document Type"; Enum "Document Type")
        {
            Caption = 'Document Type';
            ToolTip = 'Specifies the document type.';
        }
        field(8; "Purchase Date"; DateTime)
        {
            Caption = 'Purchase Date';
            ToolTip = 'Specifies the purchase date.';
        }
        field(9; "Reversal"; Boolean)
        {
            Caption = 'Reversal';
            ToolTip = 'Specifies whether this is a reversal entry.';
        }
        field(10; "Security No."; Code[20])
        {
            Caption = 'Security No.';
            ToolTip = 'Specifies the security number.';
            TableRelation = "Security"."No.";
        }
        field(11; "Quantity"; Decimal)
        {
            Caption = 'Quantity';
            ToolTip = 'Specifies the quantity of securities.';
            DecimalPlaces = 0 : 20;
        }
        field(12; "Amount B.I."; Decimal)
        {
            Caption = 'Amount B.I.';
            ToolTip = 'Specifies the amount before interest.';
            DecimalPlaces = 0 : 20;
        }
        field(13; "Amount"; Decimal)
        {
            Caption = 'Amount';
            ToolTip = 'Specifies the amount.';
            DecimalPlaces = 0 : 20;
        }
        field(14; "Amount (LCY)"; Decimal)
        {
            Caption = 'Amount (LCY)';
            ToolTip = 'Specifies the amount in local currency.';
            DecimalPlaces = 0 : 20;
        }
        field(15; "Profit Type Price"; Integer)
        {
            Caption = 'Profit Type Price';
            ToolTip = 'Specifies the profit type price.';
        }
        field(16; "Profit Type C. E. Rate"; Integer)
        {
            Caption = 'Profit Type C. E. Rate';
            ToolTip = 'Specifies the profit type currency exchange rate.';
        }
        field(17; "Tax Type"; Integer)
        {
            Caption = 'Tax Type';
            ToolTip = 'Specifies the tax type.';
        }
        field(18; "Profit Method"; Integer)
        {
            Caption = 'Profit Method';
            ToolTip = 'Specifies the profit method.';
        }
        field(19; "Market-Value Principle"; Boolean)
        {
            Caption = 'Market-Value Principle';
            ToolTip = 'Specifies if the market-value principle is applied.';
        }
        field(20; "Reclassification"; Boolean)
        {
            Caption = 'Reclassification';
            ToolTip = 'Specifies if this is a reclassification entry.';
        }
        field(21; "Realization Type"; Integer)
        {
            Caption = 'Realization Type';
            ToolTip = 'Specifies the realization type.';
        }
        field(22; "Positive"; Boolean)
        {
            Caption = 'Positive';
            ToolTip = 'Specifies if this is a positive entry.';
        }
        field(23; "Incl. In Purchase Value"; Boolean)
        {
            Caption = 'Incl. In Purchase Value';
            ToolTip = 'Specifies if this entry is included in purchase value.';
        }
        field(24; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            ToolTip = 'Specifies the currency code.';
        }
        field(25; "User ID"; Code[50])
        {
            Caption = 'User ID';
            ToolTip = 'Specifies the user ID who created the entry.';
        }
        field(26; "Source Code"; Code[10])
        {
            Caption = 'Source Code';
            ToolTip = 'Specifies the source code for the entry.';
        }
        field(27; "Journal Name"; Code[10])
        {
            Caption = 'Journal Name';
            ToolTip = 'Specifies the journal name used for the entry.';
        }
        field(28; "Reason Code"; Code[10])
        {
            Caption = 'Reason Code';
            ToolTip = 'Specifies the reason code for the entry.';
        }
        field(29; "Rounding Difference"; Boolean)
        {
            Caption = 'Rounding Difference';
            ToolTip = 'Specifies if this entry represents a rounding difference.';
        }
        field(30; "Entry No. Formatted"; Integer)
        {
            Caption = 'Entry No. Formatted';
            ToolTip = 'Specifies the formatted entry number.';
        }
        field(31; "Entry No. Filter"; Code[20])
        {
            Caption = 'Entry No. Filter';
            ToolTip = 'Specifies the entry number filter.';
        }
    }

    keys
    {
        key(PK; "Entry No.") { Clustered = true; }
        key(Key2; "Security Ledger Entry No.") { }
        key(Key3; "Security No.", "Posting Date") { }
        key(Key4; "Document Type", "Document No.") { }
        key(Key5; "Purchase Ledger Entry No.") { }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Entry No.", "Security No.", "Posting Date", "Amount") { }
    }
}
