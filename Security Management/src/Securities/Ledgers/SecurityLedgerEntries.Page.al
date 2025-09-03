/// <summary>
/// List page for Security Ledger Entries
/// </summary>
namespace PwC.Securities.Ledgers;

page 79903 "Security Ledger Entries"
{
    ApplicationArea = All;
    Caption = 'Security Ledger Entries';
    Editable = false;
    PageType = List;
    SourceTable = "Security Ledger Entry";
    SourceTableView = sorting("Entry No.") order(descending);
    UsageCategory = History;
   
    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Entry No."; Rec."Entry No.") { }
                field("Transaction No."; Rec."Transaction No.") { }
                field("Security No."; Rec."Security No.") { }
                field("Posting Date"; Rec."Posting Date") { }
                field("Trading Date"; Rec."Trading Date") { }
                field("Document Type"; Rec."Document Type") { }
                field("Document No."; Rec."Document No.") { }
                field("Description"; Rec."Description") { }
                field("Finance Description"; Rec."Finance Description") { }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code") { }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code") { }
                field("Realization Type"; Rec."Realization Type") { }
                field("Currency Code"; Rec."Currency Code") { }
                field("Transferred from Security No."; Rec."Transferred from Security No.") { }
                field("Currency Factor Reciprocal"; Rec."Currency Factor Reciprocal") { }
                field("Currency Factor"; Rec."Currency Factor") { }
                field("Open"; Rec."Open") { }
                field("Quantity"; Rec."Quantity") { }
                field("Amount B.I."; Rec."Amount B.I.") { }
                field("Amount"; Rec."Amount") { }
                field("Amount (LCY)"; Rec."Amount (LCY)") { }
                field("Account Amount"; Rec."Account Amount") { }
                field("Account Currency Code"; Rec."Account Currency Code") { }
                field("Acc. Curr. Factor Reciprocal"; Rec."Acc. Curr. Factor Reciprocal") { }
                field("Account Currency Factor"; Rec."Account Currency Factor") { }
                field("Share Size"; Rec."Share Size") { }
                field("Market-Value Principle"; Rec."Market-Value Principle") { }
                field("Reclassified"; Rec."Reclassified") { }
                field("Reclass. by Ledger Entry No."; Rec."Reclass. by Ledger Entry No.") { }
                field("External Document No."; Rec."External Document No.") { }
                field("Drawing"; Rec."Drawing") { }
                field("Bonus Share"; Rec."Bonus Share") { }
                field("Price"; Rec."Price") { }
                field("Index Price"; Rec."Index Price") { }
                field("Costs"; Rec."Costs") { }
                field("Trading Interest"; Rec."Trading Interest") { }
                field("Trading Interest (LCY)"; Rec."Trading Interest (LCY)") { }
                field("Yield Before Tax"; Rec."Yield Before Tax") { }
                field("Dividend Tax"; Rec."Dividend Tax") { }
                field("Yield Before Tax (LCY)"; Rec."Yield Before Tax (LCY)") { }
                field("Dividend Tax (LCY)"; Rec."Dividend Tax (LCY)") { }
                field("User ID"; Rec."User ID") { }
                field("Number Series"; Rec."Number Series") { }
                field("Reason Code"; Rec."Reason Code") { }
                field("Source Code"; Rec."Source Code") { }
                field("Journal Name"; Rec."Journal Name") { }
                field("Dimension Set ID"; Rec."Dimension Set ID") { }
            }
        }
    }
}
