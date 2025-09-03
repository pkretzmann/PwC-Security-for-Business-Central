/// <summary>
/// List page for security journal templates
/// </summary>
namespace PwC.Securities.Journals.JournalTemplate;

using System.Reflection;

page 79920 "Security Journal Templates"
{
    Caption = 'Security Journal Templates';
    PageType = List;
    SourceTable = "Security Journal Template";
    ApplicationArea = All;
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field(Name; Rec.Name)
                {
                    ApplicationArea = Jobs;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Jobs;
                }
                field("Page ID"; Rec."Page ID")
                {
                    ApplicationArea = Jobs;
                    LookupPageId = Objects;
                    Visible = false;
                }
                field("Source Code"; Rec."Source Code")
                {
                    ApplicationArea = Jobs;
                }
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
        area(Promoted)
        {
            actionref("Batches_Promoted"; Batches) { }
        }
        area(Navigation)
        {
            group("Te&mplate")
            {
                Caption = 'Te&mplate';
                Image = Template;
                action(Batches)
                {
                    ApplicationArea = Jobs;
                    Caption = 'Batches';
                    Image = Description;
                    RunObject = page "Security Journal Batches";
                    RunPageLink = "Journal Template Name" = field(Name);
                    ToolTip = 'View or edit multiple journals for a specific template. You can use batches when you need multiple journals of a certain type.';
                    Scope = Repeater;
                }
            }
        }
    }
}