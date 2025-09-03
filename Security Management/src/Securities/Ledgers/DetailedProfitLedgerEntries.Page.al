/// <summary>
/// List page for Detailed Profit Ledger Entries
/// </summary>
namespace PwC.Securities.Ledgers;

page 79916 "Detailed Profit Ledger Entries"
{
    ApplicationArea = All;
    Caption = 'Detailed Profit Ledger Entries';
    Editable = false;
    PageType = List;
    SourceTable = "Detailed Profit Ledger Entry";
    SourceTableView = sorting("Entry No.") order(descending);
    UsageCategory = History;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Entry No."; Rec."Entry No.") { }
                field("Security Ledger Entry No."; Rec."Security Ledger Entry No.") { }
                field("Posting Date"; Rec."Posting Date") { }
                field("Trading Date"; Rec."Trading Date") { }
                field("Document No."; Rec."Document No.") { }
                field("Document Type"; Rec."Document Type") { }
                field("Sales Amount"; Rec."Sales Amount") { }
                field("Security No."; Rec."Security No.") { }
                field("Quantity"; Rec."Quantity") { }
                field("Amount B.I."; Rec."Amount B.I.") { }
                field("Amount"; Rec."Amount") { }
                field("Amount LCY"; Rec."Amount LCY") { }
                field("Realization Type"; Rec."Realization Type") { }
                field("Profit Type"; Rec."Profit Type") { }
                field("Tax Type"; Rec."Tax Type") { }
                field("Profit Method"; Rec."Profit Method") { }
                field("Reversal"; Rec."Reversal") { }
                field("Market-Value Principle"; Rec."Market-Value Principle") { }
                field("Reclassification"; Rec."Reclassification") { }
                field("Currency Code"; Rec."Currency Code") { }
                field("User ID"; Rec."User ID") { }
                field("Source Code"; Rec."Source Code") { }
                field("Journal Name"; Rec."Journal Name") { }
                field("Reason Code"; Rec."Reason Code") { }
                field("Rounding Difference"; Rec."Rounding Difference") { }
            }
        }
    }
}
