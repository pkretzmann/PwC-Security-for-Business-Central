/// <summary>
/// Page Security Accounts (ID 79906).
/// </summary>
namespace PwC.Securities;

page 79906 "Security Accounts"
{
    Caption = 'Security Accounts';
    PageType = List;
    SourceTable = "Security Account";
    UsageCategory = None;
    ApplicationArea = All;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Security No."; Rec."Security No.") { Editable = false; Visible = false; }
                field("Account Code"; Rec."Account Code") { }
                field(Standard; Rec.Standard) { }
            }
        }
    }
}
