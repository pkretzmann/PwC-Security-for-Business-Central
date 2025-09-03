/// <summary>
/// Table for ISIN codes
/// </summary>
namespace PwC.Securities.ISIN;

table 79905 ISIN
{
    Caption = 'ISIN';
    DataClassification = CustomerContent;
    DataCaptionFields = Code;
    LookupPageId = ISINs;
    DrillDownPageId = ISINs;

    fields
    {
        field(1; Code; Code[20])
        {
            Caption = 'Code';
            ToolTip = 'Specifies the ISIN code.';
            NotBlank = true;
        }
    }

    keys
    {
        key(PK; Code) { Clustered = true; }
    }
}
