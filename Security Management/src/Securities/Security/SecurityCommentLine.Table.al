/// <summary>
/// Table for security comment lines
/// </summary>
namespace PwC.Securities.Security;

table 79913 "Security Comment Line"
{
    Caption = 'Security Comment Line';
    LookupPageId = "Security Comment List";
    DrillDownPageId = "Security Comment List";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            ToolTip = 'Specifies the number of the security that the comment line belongs to.';
            TableRelation = Security."No.";
            NotBlank = true;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            ToolTip = 'Specifies the line number of the security comment line.';
        }
        field(3; Date; Date)
        {
            Caption = 'Date';
            ToolTip = 'Specifies the date of the security comment line.';
        }
        field(4; Code; Code[10])
        {
            Caption = 'Code';
            ToolTip = 'Specifies the code of the security comment line.';
        }
        field(5; Comment; Text[80])
        {
            Caption = 'Comment';
            ToolTip = 'Specifies the comment of the security comment line.';
        }
    }

    keys
    {
        key(PK; "No.", "Line No.") { Clustered = true; }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "No.", "Line No.", Date, Comment) { }
    }

    /// <summary>
    /// Set up a new line
    /// </summary>
    procedure SetUpNewLine()
    var
        SecurityCommentLine: Record "Security Comment Line";
    begin
        SecurityCommentLine.SetRange("No.", "No.");
        SecurityCommentLine.SetRange(Date, WorkDate());
        if not SecurityCommentLine.IsEmpty then
            Date := WorkDate();
    end;
}
