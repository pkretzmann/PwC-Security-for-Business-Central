/// <summary>
/// Table for investment fund prices
/// </summary>
namespace PwC.Securities.Security.ISIN.Price;

using PwC.Securities.Security;
using PwC.Securities.ISIN;

table 79907 "Investment Fund Price"
{
    Caption = 'Investment Fund Price';
    DataClassification = CustomerContent;
    DataCaptionFields = "ISIN Code", Name, Date;

    fields
    {
        field(1; "ISIN Code"; Code[20])
        {
            Caption = 'ISIN Code';
            ToolTip = 'Specifies the ISIN code of the investment fund.';
            NotBlank = true;
            TableRelation = "ISIN Code";
        }
        field(2; Date; Date)
        {
            Caption = 'Date';
            ToolTip = 'Specifies the date of the price.';
            NotBlank = true;
        }
        field(3; Name; Text[100])
        {
            Caption = 'Name';
            ToolTip = 'Specifies the name of the investment fund.';
            FieldClass = FlowField;
            CalcFormula = lookup(Security.Name where("ISIN Code" = field("ISIN Code")));
            Editable = false;
        }
        field(4; Price; Decimal)
        {
            Caption = 'Price';
            ToolTip = 'Specifies the price of the investment fund.';
            DecimalPlaces = 2 : 20;
        }
        field(5; "Nominal Interest Rate Pct."; Decimal)
        {
            Caption = 'Nominal Interest Rate %';
            ToolTip = 'Specifies the nominal interest rate percentage.';
            BlankZero = true;
            DecimalPlaces = 2 : 20;
        }
        field(6; Issuer; Text[100])
        {
            Caption = 'Issuer';
            ToolTip = 'Specifies the issuer of the investment fund.';
        }
    }

    keys
    {
        key(PK; "ISIN Code", Date) { Clustered = true; }
    }
}
