/// <summary>
/// Table for detailed profit ledger entries
/// </summary>
namespace PwC.Securities.Ledgers;

using PwC.Securities.Security;
using PwC.Securities.Journals;

table 79915 "Detailed Profit Ledger Entry"
{
    Caption = 'Detailed Profit Ledger Entry';
    LookupPageId = "Detailed Profit Ledger Entries";
    DrillDownPageId = "Detailed Profit Ledger Entries";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            ToolTip = 'Specifies the number of the detailed profit ledger entry.';
            AutoIncrement = true;
        }
        field(2; "Security Ledger Entry No."; Integer)
        {
            Caption = 'Security Ledger Entry No.';
            ToolTip = 'Specifies the security ledger entry number.';
            TableRelation = "Security Ledger Entry"."Entry No.";
        }
        field(3; "Posting Date"; DateTime)
        {
            Caption = 'Posting Date';
            ToolTip = 'Specifies the posting date of the entry.';
        }
        field(4; "Trading Date"; DateTime)
        {
            Caption = 'Trading Date';
            ToolTip = 'Specifies the trading date of the entry.';
        }
        field(5; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            ToolTip = 'Specifies the document number.';
        }
        field(6; "Document Type"; Enum "Document Type")
        {
            Caption = 'Document Type';
            ToolTip = 'Specifies the document type.';
        }
        field(7; "Sales Amount"; Boolean)
        {
            Caption = 'Sales Amount';
            ToolTip = 'Specifies whether this is a sales amount entry.';
        }
        field(8; "Security No."; Code[20])
        {
            Caption = 'Security No.';
            ToolTip = 'Specifies the security number.';
            TableRelation = "Security"."No.";
        }
        field(9; "Quantity"; Decimal)
        {
            Caption = 'Quantity';
            ToolTip = 'Specifies the quantity of securities.';
            DecimalPlaces = 0 : 20;
        }
        field(10; "Amount B.I."; Decimal)
        {
            Caption = 'Amount B.I.';
            ToolTip = 'Specifies the amount before interest.';
            DecimalPlaces = 0 : 20;
        }
        field(11; "Amount"; Decimal)
        {
            Caption = 'Amount';
            ToolTip = 'Specifies the amount.';
            DecimalPlaces = 0 : 20;
        }
        field(12; "Amount LCY"; Decimal)
        {
            Caption = 'Amount LCY';
            ToolTip = 'Specifies the amount in local currency.';
            DecimalPlaces = 0 : 20;
        }
        field(13; "Realization Type"; Integer)
        {
            Caption = 'Realization Type';
            ToolTip = 'Specifies the realization type.';
        }
        field(14; "Profit Type"; Integer)
        {
            Caption = 'Profit Type';
            ToolTip = 'Specifies the profit type.';
        }
        field(15; "Tax Type"; Integer)
        {
            Caption = 'Tax Type';
            ToolTip = 'Specifies the tax type.';
        }
        field(16; "Profit Method"; Integer)
        {
            Caption = 'Profit Method';
            ToolTip = 'Specifies the profit method.';
        }
        field(17; "Reversal"; Boolean)
        {
            Caption = 'Reversal';
            ToolTip = 'Specifies whether this is a reversal entry.';
        }
        field(18; "Market-Value Principle"; Boolean)
        {
            Caption = 'Market-Value Principle';
            ToolTip = 'Specifies if the market-value principle is applied.';
        }
        field(19; "Reclassification"; Boolean)
        {
            Caption = 'Reclassification';
            ToolTip = 'Specifies if this is a reclassification entry.';
        }
        field(20; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            ToolTip = 'Specifies the currency code.';
        }
        field(21; "User ID"; Code[50])
        {
            Caption = 'User ID';
            ToolTip = 'Specifies the user ID who created the entry.';
        }
        field(22; "Source Code"; Code[10])
        {
            Caption = 'Source Code';
            ToolTip = 'Specifies the source code for the entry.';
            TableRelation = Microsoft.Foundation.AuditCodes."Source Code";
        }
        field(23; "Journal Name"; Code[10])
        {
            Caption = 'Journal Name';
            ToolTip = 'Specifies the journal name used for the entry.';
        }
        field(24; "Reason Code"; Code[10])
        {
            Caption = 'Reason Code';
            ToolTip = 'Specifies the reason code for the entry.';
        }
        field(25; "Rounding Difference"; Boolean)
        {
            Caption = 'Rounding Difference';
            ToolTip = 'Specifies if this entry represents a rounding difference.';
        }
    }

    keys
    {
        key(PK; "Entry No.") { Clustered = true; }
        key(Key2; "Security Ledger Entry No.") { }
        key(Key3; "Security No.", "Posting Date") { }
        key(Key4; "Document Type", "Document No.") { }
        key(Key5; "Realization Type", "Profit Type") { }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Entry No.", "Security No.", "Posting Date", "Amount") { }
    }
}
