/// <summary>
/// Enum for document type
/// </summary>
namespace PwC.Securities.Journals;

enum 79902 "Document Type"
{
    // TODO name the document types 2..4
    value(0; Purchase)
    {
        Caption = 'Purchase';
    }
    value(1; Sale)
    {
        Caption = 'Sale';
    }
    value(2; "2")
    {
        Caption = '2';
    }
    value(3; "3")
    {
        Caption = '3';
    }
    value(4; "4")
    {
        Caption = '4';
    }
    value(5; "5")
    {
        Caption = '5';
    }
}
