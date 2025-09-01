/// <summary>
/// List page for securities
/// </summary>
namespace PwC.Securities;

page 79902 Securities
{
    PageType = List;
    SourceTable = Security;
    Caption = 'Securities';
    ApplicationArea = All;
    UsageCategory = Lists;
    CardPageId = "Security Card";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(No; Rec."No.") { }
                field(Description; Rec.Name) { }
                field(ISINCode; Rec."ISIN Code") { }
                field(Currency; Rec."Currency Code") { }
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
