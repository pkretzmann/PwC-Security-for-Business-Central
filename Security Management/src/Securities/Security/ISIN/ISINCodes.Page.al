/// <summary>
/// List page for ISIN codes
/// </summary>
namespace PwC.Securities;

page 79905 "ISIN Codes"
{
    Caption = 'ISIN Codes';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = None;
    SourceTable = "ISIN Code";

    layout
    {
        area(Content)
        {
            repeater(ISINCodes)
            {
                field(Code; Rec.Code) { }
            }
        }
    }
}
