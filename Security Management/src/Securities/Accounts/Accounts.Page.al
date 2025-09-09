/// <summary>
/// Page Accounts (ID 79904).
/// </summary>
namespace PwC.Securities.Accounts;

using PwC.Securities.SecurityAccounts;

page 79904 Accounts
{
    ApplicationArea = All;
    Caption = 'Accounts';
    PageType = List;
    SourceTable = Account;
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Code; Rec.Code) { }
                field(Name; Rec.Name) { }
                field("Security Account No."; Rec."Security Account No.") { }
                field("Bal. Account Type"; Rec."Bal. Account Type") { }
                field("Bal. Account No."; Rec."Bal. Account No.") { }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code") { }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code") { }
            }
        }
    }
    actions
    {
        area(Promoted)
        {
            actionref(SecurityAccounts_Promoted; "Security Accounts") { }
        }
        area(navigation)
        {
            action("Security Accounts")
            {
                Caption = 'Security Accounts';
                ToolTip = 'View the security accounts for this account.';
                Image = Inventory;
                RunObject = page "Security Accounts";
                RunPageLink = "Account Code" = field(Code);
            }
        }
    }
}
