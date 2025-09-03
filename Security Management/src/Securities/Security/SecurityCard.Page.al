/// <summary>
/// Table for securities
/// </summary>
namespace PwC.Securities.Security;

using PwC.Securities.Security.ISIN.Price;
using PwC.Securities.SecurityAccounts;

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
                field(Name; Rec.Name) { }
                field(ISIN; Rec."ISIN Code") { }
                field("Trading Currency Code"; Rec."Currency Code") { }
            }
        }
    }
    actions
    {
        area(Promoted)
        {
            actionref(InvestmentFundPrices_Promoted; "Investment Fund Prices") { }
            actionref(SecurityAccounts_Promoted; "Security Accounts") { }
        }
        area(navigation)
        {
            action("Investment Fund Prices")
            {
                Caption = 'Investment Fund Prices';
                ToolTip = 'View the investment fund prices for this security.';
                Image = Price;
                RunObject = page "Investment Fund Prices";
                RunPageLink = "ISIN Code" = field("ISIN Code");
            }
            action("Security Accounts")
            {
                Caption = 'Security Accounts';
                ToolTip = 'View the accounts assigned to this security.';
                Image = Inventory;
                RunObject = page "Security Accounts";
                RunPageLink = "Security No." = field("No.");
            }
            action("Co&mments")
            {
                ApplicationArea = Comments;
                Caption = 'Co&mments';
                Image = ViewComments;
                ToolTip = 'View or add comments for the record.';

                trigger OnAction()
                begin
                    Rec.ShowLineComments();
                end;
            }
        }
    }
}