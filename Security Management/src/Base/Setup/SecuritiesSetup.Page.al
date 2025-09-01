/// <summary>
/// Page for setting up securities
/// </summary>
namespace PwC.Base.Setup;

page 79900 "Securities Setup"
{
    PageType = Card;
    SourceTable = "Securities Setup";
    Caption = 'Securities Setup';
    UsageCategory = Administration;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Investment G/L Acct"; Rec."Investment G/L Acct") { }
                field("Bank Account No."; Rec."Bank Account No.") { }
            }
            group(Realized)
            {
                Caption = 'Realized';
                field("Realized Gain G/L"; Rec."Realized Gain G/L") { }
                field("Realized Loss G/L"; Rec."Realized Loss G/L") { }
            }
            group(Unrealized)
            {
                Caption = 'Unrealized';
                field("Unreal. Gain G/L"; Rec."Unreal. Gain G/L") { }
                field("Unreal. Loss G/L"; Rec."Unreal. Loss G/L") { }
            }
            group(Journal)
            {
                Caption = 'Journal';
                field("Gen. Jnl. Template"; Rec."Gen. Jnl. Template") { }
                field("Gen. Jnl. Batch"; Rec."Gen. Jnl. Batch") { }
            }
            group(Fees)
            {
                Caption = 'Fees';
                field("Capitalize Fees"; Rec."Capitalize Fees") { }
                field("Fee Account"; Rec."Fee Account")
                {
                    Visible = not Rec."Capitalize Fees";
                }
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
