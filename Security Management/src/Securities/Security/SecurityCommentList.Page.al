/// <summary>
/// List page for Security Comment Lines
/// </summary>
namespace PwC.Securities.Security;

page 79914 "Security Comment List"
{
    ApplicationArea = All;
    Caption = 'Security Comment List';
    Editable = false;
    PageType = List;
    SourceTable = "Security Comment Line";
    SourceTableView = sorting("No.", "Line No.");
    UsageCategory = None;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                ShowCaption = false;

                field("No."; Rec."No.") { }
                field("Line No."; Rec."Line No.") { }
                field(Date; Rec.Date) { }
                field(Code; Rec.Code) { }
                field(Comment; Rec.Comment) { }
            }
        }
    }
}
