/// <summary>
/// List page for Security Register entries
/// </summary>
namespace PwC.Securities.Ledgers;

page 79909 "Security Register"
{
    ApplicationArea = All;
    Caption = 'Security Register';
    Editable = false;
    PageType = List;
    SourceTable = "Security Register";
    SourceTableView = sorting("No.") order(descending);
    UsageCategory = History;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.") { }
                field("From Entry No."; Rec."From Entry No.") { }
                field("To Entry No."; Rec."To Entry No.") { }
                field("Issuing Date"; Rec."Issuing Date") { }
                field("Source Code"; Rec."Source Code") { }
                field("User ID"; Rec."User ID") { }
                field("Journal Batch Name"; Rec."Journal Batch Name") { }
                field("From Security Acc. Entry No."; Rec."From Security Acc. Entry No.") { }
                field("To Security Acc. Entry No."; Rec."To Security Acc. Entry No.") { }
            }
        }
    }

    actions
    {
        area(Navigation)
        {
            group("&Register")
            {
                Caption = '&Register';
                Image = Register;

                action("Security Ledger Entries")
                {
                    ApplicationArea = All;
                    Caption = 'Security Ledger Entries';
                    Image = Ledger;
                    ToolTip = 'View the security ledger entries for this register.';

                    trigger OnAction()
                    var
                        SecurityLedgerEntry: Record "Security Ledger Entry";
                    begin
                        SecurityLedgerEntry.SetRange("Entry No.", Rec."From Entry No.", Rec."To Entry No.");
                        //Page.Run(Page::"Security Ledger Entries", SecurityLedgerEntry);
                    end;
                }
                action("Security Account Ledger Entries")
                {
                    ApplicationArea = All;
                    Caption = 'Security Account Ledger Entries';
                    Image = Ledger;
                    ToolTip = 'View the security account ledger entries for this register.';

                    trigger OnAction()
                    begin
                        // Navigate to Security Account Ledger Entries filtered by entry number range
                        // Implementation would require the Security Account Ledger Entries page to exist
                    end;
                }
            }
        }
    }
}
