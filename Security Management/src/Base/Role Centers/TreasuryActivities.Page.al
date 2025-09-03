/// <summary>
/// Page Treasury Activities.
/// </summary>
namespace PwC.Base.RoleCenters;

using PwC.Securities;

page 79907 "Treasury Activities"
{
    Caption = 'Treasury Activities';
    PageType = CardPart;
    SourceTable = "Treasury Cue";
    RefreshOnActivate = true;
    ShowFilter = false;
    ApplicationArea = All;
    AboutTitle = '', Locked = true;
    AboutText = '', Locked = true;

    layout
    {
        area(Content)
        {
            cuegroup(Treasury)
            {
                Caption = 'Treasury';
                field("No. of Accounts"; Rec."No. of Accounts") { }
                field("No. of Securities"; Rec."No. of Securities") { }
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.Reset();
        if not Rec.Get() then begin
            Rec.Init();
            Rec.Insert(false);
        end;
    end;
}