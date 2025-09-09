/// <summary>
/// Table for security ledger entries
/// </summary>
namespace PwC.Securities.Ledgers;

using PwC.Securities.Security;
using PwC.Securities.Journals;

table 79902 "Security Ledger Entry"
{
    Caption = 'Security Ledger Entry';
    DataClassification = CustomerContent;
    LookupPageId = "Security Ledger Entries";
    DrillDownPageId = "Security Ledger Entries";

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            ToolTip = 'Specifies the number of the security ledger entry.';
            AutoIncrement = true;
        }
        field(2; "Transaction No."; Integer)
        {
            Caption = 'Transaction No.';
            ToolTip = 'Specifies the transaction number of the security ledger entry.';
        }
        field(3; "Security No."; Code[20])
        {
            Caption = 'Security No.';
            ToolTip = 'Specifies the security number.';
            TableRelation = "Security"."No.";
        }
        field(4; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
            ToolTip = 'Specifies the posting date of the entry.';
        }
        field(5; "Trading Date"; Date)
        {
            Caption = 'Trading Date';
            ToolTip = 'Specifies the trading date of the entry.';
        }
        field(6; "Document Type"; Enum "Document Type")
        {
            Caption = 'Document Type';
            ToolTip = 'Specifies the document type.';
        }
        field(7; "Document No."; Code[10])
        {
            Caption = 'Document No.';
            ToolTip = 'Specifies the document number.';
        }
        field(8; "Description"; Text[50])
        {
            Caption = 'Description';
            ToolTip = 'Specifies the description of the entry.';
        }
        field(9; "Finance Description"; Text[50])
        {
            Caption = 'Finance Description';
            ToolTip = 'Specifies the finance description of the entry.';
        }
        field(10; "Global Dimension 1 Code"; Code[20])
        {
            Caption = 'Global Dimension 1 Code';
            ToolTip = 'Specifies the global dimension 1 code.';
        }
        field(11; "Global Dimension 2 Code"; Code[20])
        {
            Caption = 'Global Dimension 2 Code';
            ToolTip = 'Specifies the global dimension 2 code.';
        }
        field(12; "Realization Type"; Integer)
        {
            Caption = 'Realization Type';
            ToolTip = 'Specifies the realization type.';
        }
        field(13; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            ToolTip = 'Specifies the currency code.';
        }
        field(14; "Transferred from Security No."; Code[20])
        {
            Caption = 'Transferred from Security No.';
            ToolTip = 'Specifies the security number this entry was transferred from.';
        }
        field(15; "Currency Factor Reciprocal"; Decimal)
        {
            Caption = 'Currency Factor Reciprocal';
            ToolTip = 'Specifies the reciprocal of the currency factor.';
            DecimalPlaces = 0 : 20;
        }
        field(16; "Currency Factor"; Decimal)
        {
            Caption = 'Currency Factor';
            ToolTip = 'Specifies the currency factor.';
            DecimalPlaces = 0 : 20;
        }
        field(17; "Open"; Boolean)
        {
            Caption = 'Open';
            ToolTip = 'Specifies if the entry is open.';
        }
        field(18; "Quantity"; Decimal)
        {
            Caption = 'Quantity';
            ToolTip = 'Specifies the quantity of securities.';
            DecimalPlaces = 0 : 20;
        }
        field(19; "Amount B.I."; Decimal)
        {
            Caption = 'Amount B.I.';
            ToolTip = 'Specifies the amount before interest.';
            DecimalPlaces = 0 : 20;
        }
        field(20; "Amount"; Decimal)
        {
            Caption = 'Amount';
            ToolTip = 'Specifies the amount.';
            DecimalPlaces = 0 : 20;
        }
        field(21; "Amount (LCY)"; Decimal)
        {
            Caption = 'Amount (LCY)';
            ToolTip = 'Specifies the amount in local currency.';
            DecimalPlaces = 0 : 20;
        }
        field(22; "Account Amount"; Decimal)
        {
            Caption = 'Account Amount';
            ToolTip = 'Specifies the account amount.';
            DecimalPlaces = 0 : 20;
        }
        field(23; "Account Currency Code"; Code[10])
        {
            Caption = 'Account Currency Code';
            ToolTip = 'Specifies the account currency code.';
        }
        field(24; "Acc. Curr. Factor Reciprocal"; Decimal)
        {
            Caption = 'Acc. Curr. Factor Reciprocal';
            ToolTip = 'Specifies the reciprocal of the account currency factor.';
            DecimalPlaces = 0 : 20;
        }
        field(25; "Account Currency Factor"; Decimal)
        {
            Caption = 'Account Currency Factor';
            ToolTip = 'Specifies the account currency factor.';
            DecimalPlaces = 0 : 20;
        }
        field(26; "Share Size"; Decimal)
        {
            Caption = 'Share Size';
            ToolTip = 'Specifies the share size.';
            DecimalPlaces = 0 : 20;
        }
        field(27; "Market-Value Principle"; Boolean)
        {
            Caption = 'Market-Value Principle';
            ToolTip = 'Specifies if the market-value principle is applied.';
        }
        field(28; "Reclassified"; Boolean)
        {
            Caption = 'Reclassified';
            ToolTip = 'Specifies if the entry has been reclassified.';
        }
        field(29; "Reclass. by Ledger Entry No."; Integer)
        {
            Caption = 'Reclass. by Ledger Entry No.';
            ToolTip = 'Specifies the ledger entry number that reclassified this entry.';
        }
        field(30; "External Document No."; Code[20])
        {
            Caption = 'External Document No.';
            ToolTip = 'Specifies the external document number.';
        }
        field(31; "Drawing"; Boolean)
        {
            Caption = 'Drawing';
            ToolTip = 'Specifies if this is a drawing entry.';
        }
        field(32; "Bonus Share"; Boolean)
        {
            Caption = 'Bonus Share';
            ToolTip = 'Specifies if this is a bonus share entry.';
        }
        field(33; "Price"; Decimal)
        {
            Caption = 'Price';
            ToolTip = 'Specifies the price of the security.';
            DecimalPlaces = 0 : 20;
        }
        field(34; "Index Price"; Decimal)
        {
            Caption = 'Index Price';
            ToolTip = 'Specifies the index price.';
            DecimalPlaces = 0 : 20;
        }
        field(35; "Costs"; Decimal)
        {
            Caption = 'Costs';
            ToolTip = 'Specifies the costs associated with the transaction.';
            DecimalPlaces = 0 : 20;
        }
        field(36; "Trading Interest"; Decimal)
        {
            Caption = 'Trading Interest';
            ToolTip = 'Specifies the trading interest.';
            DecimalPlaces = 0 : 20;
        }
        field(37; "Trading Interest (LCY)"; Decimal)
        {
            Caption = 'Trading Interest (LCY)';
            ToolTip = 'Specifies the trading interest in local currency.';
            DecimalPlaces = 0 : 20;
        }
        field(38; "Yield Before Tax"; Decimal)
        {
            Caption = 'Yield Before Tax';
            ToolTip = 'Specifies the yield before tax.';
            DecimalPlaces = 0 : 20;
        }
        field(39; "Dividend Tax"; Decimal)
        {
            Caption = 'Dividend Tax';
            ToolTip = 'Specifies the dividend tax amount.';
            DecimalPlaces = 0 : 20;
        }
        field(40; "Yield Before Tax (LCY)"; Decimal)
        {
            Caption = 'Yield Before Tax (LCY)';
            ToolTip = 'Specifies the yield before tax in local currency.';
            DecimalPlaces = 0 : 20;
        }
        field(41; "Dividend Tax (LCY)"; Decimal)
        {
            Caption = 'Dividend Tax (LCY)';
            ToolTip = 'Specifies the dividend tax amount in local currency.';
            DecimalPlaces = 0 : 20;
        }
        field(42; "User ID"; Code[50])
        {
            Caption = 'User ID';
            ToolTip = 'Specifies the user ID who created the entry.';
        }
        field(43; "Number Series"; Code[10])
        {
            Caption = 'Number Series';
            ToolTip = 'Specifies the number series used for the entry.';
        }
        field(44; "Reason Code"; Code[10])
        {
            Caption = 'Reason Code';
            ToolTip = 'Specifies the reason code for the entry.';
        }
        field(45; "Source Code"; Code[10])
        {
            Caption = 'Source Code';
            ToolTip = 'Specifies the source code for the entry.';
            TableRelation = Microsoft.Foundation.AuditCodes."Source Code";
        }
        field(46; "Journal Name"; Code[10])
        {
            Caption = 'Journal Name';
            ToolTip = 'Specifies the journal name used for the entry.';
        }
        field(47; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            ToolTip = 'Specifies the dimension set ID for the entry.';
        }
    }
    keys
    {
        key(PK; "Entry No.") { Clustered = true; }
        key(Key2; "Security No.", "Posting Date") { }
        key(Key3; "Transaction No.") { }
        key(Key4; "Document Type", "Document No.") { }
    }
}
