/// <summary>
/// List page for investment fund prices
/// </summary>
namespace PwC.Securities.Security.ISIN.Price;

page 79908 "Investment Fund Prices"
{
    PageType = List;
    SourceTable = "Investment Fund Price";
    Caption = 'Investment Fund Prices';
    ApplicationArea = All;
    UsageCategory = Lists;
    Editable = true;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("ISIN Code"; Rec."ISIN Code") { }
                field(Date; Rec.Date) { }
                field(Price; Rec.Price) { }
                field(Name; Rec.Name) { }
                field("Nominal Interest Rate Pct."; Rec."Nominal Interest Rate Pct.") { }
                field(Issuer; Rec.Issuer) { }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Import Prices")
            {
                Caption = 'Import Prices';
                ToolTip = 'Import investment fund prices from external source.';
                Image = Import;

                trigger OnAction()
                begin
                    // TODO: Implement price import functionality
                    Message('Price import functionality to be implemented.');
                end;
            }
            action("Export Prices")
            {
                Caption = 'Export Prices';
                ToolTip = 'Export investment fund prices to external file.';
                Image = Export;

                trigger OnAction()
                begin
                    // TODO: Implement price export functionality
                    Message('Price export functionality to be implemented.');
                end;
            }
        }
        area(Promoted)
        {
            group("Price Management")
            {
                Caption = 'Price Management';
                actionref("Import Prices_Promoted"; "Import Prices") { }
                actionref("Export Prices_Promoted"; "Export Prices") { }
            }
        }
    }
}
