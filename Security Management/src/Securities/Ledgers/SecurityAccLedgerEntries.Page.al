/// <summary>
/// List page for Security Account Ledger Entries
/// </summary>
namespace PwC.Securities.Ledgers;

page 79910 "Security Acc. Ledger Entries"
{
    ApplicationArea = All;
    Caption = 'Security Account Ledger Entries';
    Editable = false;
    PageType = List;
    SourceTable = "Security Account Ledger Entry";
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
                field("Security No."; Rec."Security No.") { }
                field("Security Account Code"; Rec."Security Account Code") { }
                field("Posting Date"; Rec."Posting Date") { }
                field("Trading Date"; Rec."Trading Date") { }
                field("Quantity"; Rec."Quantity") { }
                field("Document No."; Rec."Document No.") { }
                field("Document Type"; Rec."Document Type") { }
                field("Description"; Rec."Description") { }
                field("User ID"; Rec."User ID") { }
                field("Bal. Account Type"; Rec."Bal. Account Type") { }
                field("Bal. Account No."; Rec."Bal. Account No.") { }
                field("Reclassification"; Rec."Reclassification") { }
                field("Rounding Difference"; Rec."Rounding Difference") { }
            }
        }
    }
}
