/// <summary>
/// Table for security posting group setup
/// </summary>
namespace PwC.PostingSetup;

table 79911 "Security Posting Group"
{
    Caption = 'Security Posting Group';
    LookupPageId = "Security Posting Groups";
    DrillDownPageId = "Security Posting Groups";
    DataClassification = CustomerContent;

    fields
    {
        field(1; Code; Code[10])
        {
            Caption = 'Code';
            ToolTip = 'Specifies the code of the security posting group.';
            NotBlank = true;
        }
        field(2; Description; Text[50])
        {
            Caption = 'Description';
            ToolTip = 'Specifies the description of the security posting group.';
        }
        field(3; "Tax Type Profit"; Integer)
        {
            Caption = 'Tax Type Profit';
            ToolTip = 'Specifies the tax type for profit of the security posting group.';
        }
        field(4; "Tax Method Yield"; Integer)
        {
            Caption = 'Tax Method Yield';
            ToolTip = 'Specifies the tax method for yield of the security posting group.';
        }
        field(5; "Chag Metd T.D.O (Year)"; Integer)
        {
            Caption = 'Chag Metd T.D.O (Year)';
            ToolTip = 'Specifies the change method T.D.O (Year) of the security posting group.';
        }
        field(6; "Profit Method"; Integer)
        {
            Caption = 'Profit Method';
            ToolTip = 'Specifies the profit method of the security posting group.';
        }
        field(7; "Dividend Tax Pct."; Decimal)
        {
            Caption = 'Dividend Tax Pct.';
            ToolTip = 'Specifies the dividend tax percentage of the security posting group.';
            DecimalPlaces = 0 : 5;
        }
        field(8; "Accounting Principle"; Integer)
        {
            Caption = 'Accounting Principle';
            ToolTip = 'Specifies the accounting principle of the security posting group.';
        }
    }

    keys
    {
        key(PK; Code) { Clustered = true; }
    }

    fieldgroups
    {
        fieldgroup(DropDown; Code, Description) { }
    }
}
