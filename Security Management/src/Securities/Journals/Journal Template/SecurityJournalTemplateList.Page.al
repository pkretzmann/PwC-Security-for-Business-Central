/// <summary>
/// List page for security journal templates
/// </summary>
namespace PwC.Securities.Journals.JournalTemplate;

page 79919 "Security Journal Template List"
{
    Caption = 'Security Journal Template List';
    Editable = false;
    PageType = List;
    SourceTable = "Security Journal Template";
    UsageCategory = None;

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
}

