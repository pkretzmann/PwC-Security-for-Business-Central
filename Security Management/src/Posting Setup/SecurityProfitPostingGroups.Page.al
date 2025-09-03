/// <summary>
/// List page for Security Profit Posting Groups
/// </summary>
namespace PwC.PostingSetup;

page 79913 "Security Profit Posting Groups"
{
    ApplicationArea = All;
    Caption = 'Security Profit Posting Groups';
    Editable = true;
    PageType = List;
    SourceTable = "Security Profit Posting Group";
    SourceTableView = sorting("Posting Group Code", "Realization Type", "Document Type", "Profit Type", "Tax Type", "Reversal");
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Posting Group Code"; Rec."Posting Group Code") { }
                field("Realization Type"; Rec."Realization Type") { }
                field("Document Type"; Rec."Document Type") { }
                field("Profit Type"; Rec."Profit Type") { }
                field("Tax Type"; Rec."Tax Type") { }
                field("Reversal"; Rec."Reversal") { }
                field("G/L Account"; Rec."G/L Account") { }
            }
        }
    }
}
