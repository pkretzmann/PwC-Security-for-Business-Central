/// <summary>
/// Table for security register entries
/// </summary>
namespace PwC.Securities.Journals;

using PwC.Securities.Ledgers;

table 79909 "Security Register"
{
    Caption = 'Security Register';
    LookupPageId = "Security Register";
    DrillDownPageId = "Security Register";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "No."; Integer)
        {
            Caption = 'No.';
            ToolTip = 'Specifies the number of the security register.';
        }
        field(2; "From Entry No."; Integer)
        {
            Caption = 'From Entry No.';
            ToolTip = 'Specifies the from entry number of the security register.';
            TableRelation = "Security Ledger Entry";
        }
        field(3; "To Entry No."; Integer)
        {
            Caption = 'To Entry No.';
            ToolTip = 'Specifies the to entry number of the security register.';
            TableRelation = "Security Ledger Entry";
        }
        field(4; "Issuing Date"; DateTime)
        {
            Caption = 'Issuing Date';
            ToolTip = 'Specifies the issuing date of the security register.';
        }
        field(5; "Source Code"; Code[10])
        {
            Caption = 'Source Code';
            ToolTip = 'Specifies the source code of the security register.';
            TableRelation = Microsoft.Foundation.AuditCodes."Source Code";
        }
        field(6; "User ID"; Code[50])
        {
            Caption = 'User ID';
            ToolTip = 'Specifies the user ID of the security register.';
        }
        field(7; "Journal Batch Name"; Code[10])
        {
            Caption = 'Journal Batch Name';
            ToolTip = 'Specifies the journal batch name of the security register.';
        }
        field(8; "From Security Acc. Entry No."; Integer)
        {
            Caption = 'From Security Acc. Entry No.';
            ToolTip = 'Specifies the from security account entry number of the security register.';
            TableRelation = "Security Account Ledger Entry";
        }
        field(9; "To Security Acc. Entry No."; Integer)
        {
            Caption = 'To Security Acc. Entry No.';
            ToolTip = 'Specifies the to security account entry number of the security register.';
            TableRelation = "Security Account Ledger Entry";
        }
    }

    keys
    {
        key(PK; "No.") { Clustered = true; }
        key(Key2; "From Entry No.", "To Entry No.") { }
        key(Key3; "Issuing Date") { }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "No.", "From Entry No.", "To Entry No.", "Issuing Date") { }
    }
}
