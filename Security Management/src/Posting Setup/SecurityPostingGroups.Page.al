/// <summary>
/// List page for Security Posting Groups
/// </summary>
namespace PwC.PostingSetup;

page 79912 "Security Posting Groups"
{
    ApplicationArea = All;
    Caption = 'Security Posting Groups';
    Editable = true;
    PageType = List;
    SourceTable = "Security Posting Group";
    SourceTableView = sorting(Code);
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code) { }
                field("Description"; Rec.Description) { }
                field("Tax Type Profit"; Rec."Tax Type Profit") { }
                field("Tax Method Yield"; Rec."Tax Method Yield") { }
                field("Chag Metd T.D.O (Year)"; Rec."Chag Metd T.D.O (Year)") { }
                field("Profit Method"; Rec."Profit Method") { }
                field("Dividend Tax Pct."; Rec."Dividend Tax Pct.") { }
                field("Accounting Principle"; Rec."Accounting Principle") { }
            }
        }
    }
}
