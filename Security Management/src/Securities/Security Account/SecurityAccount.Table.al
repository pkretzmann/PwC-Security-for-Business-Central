/// <summary>
/// Table Security Account Assignment (ID 79906).
/// </summary>
namespace PwC.Securities.SecurityAccounts;

using PwC.Securities.Accounts;
using PwC.Securities.Security;

table 79906 "Security Account"
{
    Caption = 'Security Account';
    DataClassification = CustomerContent;
    DrillDownPageId = "Security Accounts";
    LookupPageId = "Security Accounts";

    fields
    {
        field(1; "Security No."; Code[20])
        {
            Caption = 'Security No.';
            ToolTip = 'Specifies the security number.';
            TableRelation = Security;
            NotBlank = true;
        }
        field(2; "Account Code"; Code[10])
        {
            Caption = 'Account Code';
            ToolTip = 'Specifies the account code.';
            NotBlank = true;
            TableRelation = Account;
        }
        field(3; Standard; Boolean)
        {
            Caption = 'Standard';
            ToolTip = 'Specifies whether this is a standard account.';
        }
    }

    keys
    {
        key(PK; "Security No.", "Account Code") { Clustered = true; }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Security No.", "Account Code", Standard) { }
        fieldgroup(Brick; "Security No.", "Account Code") { }
    }
}
