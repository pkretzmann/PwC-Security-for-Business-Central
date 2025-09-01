/// <summary>
/// Page for trade card
/// </summary>
namespace PwC.Securities.Trade;

using PwC.Securities.Posting;

page 79903 "Trade Card"
{
    PageType = Card;
    SourceTable = Trade;
    Caption = 'Trade Card';
    ApplicationArea = All;
    UsageCategory = None;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.") { }
                field("Posting Date"; Rec."Posting Date") { }
                field("Document No."; Rec."Document No.") { }
                field("Trade Type"; Rec."Trade Type") { }
            }
            group(Security)
            {
                field("Security No."; Rec."Security No.") { }
                field("Quantity"; Rec."Quantity")
                {
                    trigger OnValidate()
                    begin
                        Rec.CalcAmounts();
                        CurrPage.Update(false);
                    end;
                }
                field("Price (Trade Curr)"; Rec."Price (Trade Curr)")
                {
                    trigger OnValidate()
                    begin
                        Rec.CalcAmounts();
                        CurrPage.Update(false);
                    end;
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    trigger OnValidate()
                    begin
                        Rec.CalcAmounts();
                        CurrPage.Update(false);
                    end;
                }
                group(Fees)
                {
                    Caption = 'Fees';
                    field("Fee Amount (Trade Curr)"; Rec."Fee Amount (Trade Curr)")
                    {
                        trigger OnValidate()
                        begin
                            Rec.CalcAmounts();
                            CurrPage.Update(false);
                        end;
                    }
                    field("Fee Amount (LCY)"; Rec."Fee Amount (LCY)") { Editable = false; }
                }
            }
            group(Amounts)
            {
                field("Amount (Trade Curr)"; Rec."Amount (Trade Curr)") { }
                field("Exchange Rate"; Rec."Exchange Rate") { }
                field("Amount (LCY)"; Rec."Amount (LCY)") { }
            }
            group(Banking)
            {
                field("Bank Account No."; Rec."Bank Account No.") { }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(Post)
            {
                Caption = 'Post';
                ToolTip = 'Post the trade';
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    Poster: Codeunit "Trade Posting";
                begin
                    Rec.CalcAmounts();
                    Poster.Post(Rec);
                    Message('Trade %1 posted.', Rec."No.");
                end;
            }
        }
    }
}
