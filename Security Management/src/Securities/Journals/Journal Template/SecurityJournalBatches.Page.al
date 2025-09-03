/// <summary>
/// List page for security journal batches
/// </summary>
namespace PwC.Securities.Journals.JournalTemplate;

page 79915 "Security Journal Batches"
{
    Caption = 'Security Journal Batches';
    DataCaptionExpression = this.DataCaption();
    Editable = true;
    PageType = List;
    RefreshOnActivate = true;
    SourceTable = "Security Journal Batch";
    UsageCategory = Lists;
    ApplicationArea = All;

    layout
    {
        area(Content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field(Name; Rec.Name) { }
                field(Description; Rec.Description) { }
                field("Reason Code"; Rec."Reason Code") { }
            }
        }
        area(FactBoxes)
        {
            systempart(Control1900383207; Links)
            {
                ApplicationArea = RecordLinks;
                Visible = false;
            }
            systempart(Control1905767507; Notes)
            {
                ApplicationArea = Notes;
                Visible = false;
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Edit Journal")
            {
                ApplicationArea = Jobs;
                Caption = 'Edit Journal';
                Image = OpenJournal;
                ShortcutKey = 'Return';
                ToolTip = 'Open a journal based on the journal batch.';

                trigger OnAction()
                var
                    SecurityJournalManagement: Codeunit "Security Journal Management";
                begin
                    SecurityJournalManagement.TemplateSelectionFromBatch(Rec);
                end;
            }
        }
    }

    trigger OnInit()
    begin
        Rec.SetRange("Journal Template Name");
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.SetupNewBatch();
    end;

    trigger OnOpenPage()
    var
        SecurityJournalManagement: Codeunit "Security Journal Management";
    begin
        SecurityJournalManagement.OpenJnlBatch(Rec);
    end;

    local procedure DataCaption(): Text[250]
    var
        SecurityJournalTemplate: Record "Security Journal Template";
    begin
        if not CurrPage.LookupMode then
            if Rec.GetFilter("Journal Template Name") <> '' then
                if Rec.GetRangeMin("Journal Template Name") = Rec.GetRangeMax("Journal Template Name") then
                    if SecurityJournalTemplate.Get(Rec.GetRangeMin("Journal Template Name")) then
                        exit(SecurityJournalTemplate.Name + ' ' + SecurityJournalTemplate.Description);
    end;
}

