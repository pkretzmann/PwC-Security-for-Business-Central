/// <summary>
/// List page for Security Comment Lines
/// </summary>
namespace PwC.Securities.Security;

page 79911 "Security Comment Sheet"
{
    AutoSplitKey = true;
    Caption = 'Comment';
    DataCaptionFields = "No.";
    DelayedInsert = true;
    LinksAllowed = false;
    MultipleNewLines = true;
    PageType = List;
    SourceTable = "Security Comment Line";
    UsageCategory = None;
    ApplicationArea = All;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                ShowCaption = false;

                field("Line No."; Rec."Line No.") { }
                field(Date; Rec.Date) { }
                field(Code; Rec.Code) { }
                field(Comment; Rec.Comment) { }
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.SetUpNewLine();
    end;
}
