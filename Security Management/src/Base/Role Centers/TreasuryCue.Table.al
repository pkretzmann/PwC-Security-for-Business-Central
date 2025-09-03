/// <summary>
/// Table Treasury Cue (ID 67805).
/// </summary>
namespace PwC.Base.RoleCenters;

using PwC.Securities.Accounts;
using PwC.Securities.Security;

table 79908 "Treasury Cue"
{
    Caption = 'Treasury Cue', Locked = true;
    DataClassification = SystemMetadata;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
            NotBlank = false;
            AllowInCustomizations = Never;
        }
        field(2; "No. of Accounts"; Integer)
        {
            CalcFormula = count(Account);
            Caption = 'No. of Accounts';
            FieldClass = FlowField;
            Editable = false;
            ToolTip = 'Specifies the number of accounts.';
        }
        field(3; "No. of Securities"; Integer)
        {
            CalcFormula = count("Security");
            Caption = 'No. of Securities';
            FieldClass = FlowField;
            Editable = false;
            ToolTip = 'Specifies the number of securities.';
        }
    }

    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }
}