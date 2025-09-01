/// <summary>
/// Table for securities
/// </summary>
namespace PwC.Securities;

page 79901 "Security Card"
{
    PageType = Card;
    SourceTable = Security;
    Caption = 'Security Card';
    ApplicationArea = All;
    UsageCategory = None;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.") { }
                field(Description; Rec.Name) { }
                field(ISIN; Rec."ISIN Code") { }
                field("Trading Currency Code"; Rec."Currency Code") { }
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
                ToolTip = 'View the accounts assigned to this security.';
                Image = AccountingPeriods;
                RunObject = page "Security Accounts";
                RunPageLink = "Security No." = field("No.");
            }
        }
    }
}