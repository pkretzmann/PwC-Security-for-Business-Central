/// <summary>
/// List page for ISIN codes
/// </summary>
namespace PwC.Securities.ISIN;

page 79905 ISINs
{
    Caption = 'ISINs';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = None;
    SourceTable = ISIN;

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
