/// <summary>
/// List page for securities
/// </summary>
namespace PwC.Securities.Security;

using PwC.Securities.Security.ISIN.Price;
using PwC.Securities.SecurityAccounts;

page 79902 Securities
{
    Caption = 'Securities';
    CardPageId = "Security Card";
    Editable = false;
    PageType = List;
    QueryCategory = 'Security List';
    SourceTable = Security;
    UsageCategory = Lists;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Security Type"; Rec."Security Type") { }
                field(No; Rec."No.") { }
                field(ISINCode; Rec."ISIN Code") { }
                field(Name; Rec.Name) { }
                field(Currency; Rec."Currency Code") { }
                field("Report Grouping Code"; Rec."Report Grouping Code") { }
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
