/// <summary>
/// List page for Detailed Value Ledger Entries
/// </summary>
namespace PwC.Securities.Ledgers;

page 79917 "Detailed Value Ledger Entries"
{
    ApplicationArea = All;
    Caption = 'Detailed Value Ledger Entries';
    Editable = false;
    PageType = List;
    SourceTable = "Detailed Value Ledger Entry";
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
                field("Purchase Ledger Entry No."; Rec."Purchase Ledger Entry No.") { }
                field("Posting Date"; Rec."Posting Date") { }
                field("Trading Date"; Rec."Trading Date") { }
                field("Document No."; Rec."Document No.") { }
                field("Document Type"; Rec."Document Type") { }
                field("Purchase Date"; Rec."Purchase Date") { }
                field("Reversal"; Rec."Reversal") { }
                field("Security No."; Rec."Security No.") { }
                field("Quantity"; Rec."Quantity") { }
                field("Amount B.I."; Rec."Amount B.I.") { }
                field("Amount"; Rec."Amount") { }
                field("Amount (LCY)"; Rec."Amount (LCY)") { }
                field("Profit Type Price"; Rec."Profit Type Price") { }
                field("Profit Type C. E. Rate"; Rec."Profit Type C. E. Rate") { }
                field("Tax Type"; Rec."Tax Type") { }
                field("Profit Method"; Rec."Profit Method") { }
                field("Market-Value Principle"; Rec."Market-Value Principle") { }
                field("Reclassification"; Rec."Reclassification") { }
                field("Realization Type"; Rec."Realization Type") { }
                field("Positive"; Rec."Positive") { }
                field("Incl. In Purchase Value"; Rec."Incl. In Purchase Value") { }
                field("Currency Code"; Rec."Currency Code") { }
                field("User ID"; Rec."User ID") { }
                field("Source Code"; Rec."Source Code") { }
                field("Journal Name"; Rec."Journal Name") { }
                field("Reason Code"; Rec."Reason Code") { }
                field("Rounding Difference"; Rec."Rounding Difference") { }
                field("Entry No. Formatted"; Rec."Entry No. Formatted") { }
                field("Entry No. Filter"; Rec."Entry No. Filter") { }
            }
        }
    }
}
