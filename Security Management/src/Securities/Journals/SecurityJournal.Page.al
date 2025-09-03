/// <summary>
/// Page for security journal
/// </summary>
namespace PwC.Securities.Journals;

using PwC.Securities.Security;
using System.Environment;
using PwC.Securities.Journals.JournalTemplate;

page 79918 "Security Journal"
{
    ApplicationArea = Jobs;
    AutoSplitKey = true;
    Caption = 'Security Journals';
    DataCaptionFields = "Journal Batch Name";
    DelayedInsert = true;
    PageType = Worksheet;
    SaveValues = true;
    SourceTable = "Security Journal Line";
    UsageCategory = Tasks;

    layout
    {
        area(Content)
        {
            field(CurrentJnlBatchName; this.CurrentJnlBatchName)
            {
                Caption = 'Batch Name';
                Lookup = true;
                ToolTip = 'Specifies the name of the journal batch, a personalized journal layout, that the journal is based on.';

                trigger OnLookup(var Text: Text): Boolean
                begin
                    CurrPage.SaveRecord();
                    this.SecurityJournalManagement.LookupName(CurrentJnlBatchName, Rec);
                    this.SetControlAppearanceFromBatch();
                    CurrPage.Update(false);
                end;

                trigger OnValidate()
                begin
                    this.SecurityJournalManagement.CheckName(CurrentJnlBatchName, Rec);
                    this.CurrentJnlBatchNameOnAfterValidate();
                end;
            }
            repeater(Control1)
            {
                ShowCaption = false;
                field("Security No."; Rec."Security No.") { }
                field("Posting Date"; Rec."Posting Date") { }

            }
            group(Control73)
            {
                ShowCaption = false;
                fixed(Control1902114901)
                {
                    ShowCaption = false;

                    group("Security Description")
                    {
                        Caption = 'Security Description';
                        field(SecurityDescription; this.SecurityDescription)
                        {
                            Editable = false;
                            ShowCaption = false;
                            ToolTip = 'Specifies a description of the security.';
                        }
                    }
                    group("Security Amount")
                    {
                        Caption = 'Security Amount';
                        field(SecurityAmount; this.SecurityAmount)
                        {
                            ApplicationArea = All;
                            AutoFormatType = 1;
                            ShowCaption = false;
                            Editable = false;
                            ToolTip = 'Specifies the value of the security in the current journal batch.';
                        }
                    }
                }
            }
        }
        area(FactBoxes)
        {
            systempart(Control1900383207; Links)
            {
                ApplicationArea = RecordLinks;
                Visible = false;
            }
            systempart(Control1905767507; Notes)
            {
                ApplicationArea = Notes;
                Visible = false;
            }
        }
    }

    actions
    {
        area(Promoted)
        {
            actionref(Security_Promoted; Security) { }
        }
        area(Navigation)
        {
            action(Security)
            {
                ApplicationArea = Jobs;
                Caption = 'Security';
                Image = ViewJob;
                RunObject = page "Security Card";
                RunPageLink = "No." = field("Security No.");
                ToolTip = 'View the detailed information about the Security.';
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        this.SecurityJournalManagement.GetNames(Rec, SecurityDescription);
        if not (this.ClientTypeManagement.GetCurrentClientType() in [ClientType::SOAP, ClientType::OData, ClientType::ODataV4, ClientType::Api]) then
            this.UpdateTotals();
    end;

    trigger OnOpenPage()
    begin
        this.OnBeforeOpenPage(Rec, this.CurrentJnlBatchName);

        if this.ClientTypeManagement.GetCurrentClientType() = ClientType::ODataV4 then
            exit;

        this.OpenJournal();
    end;

    var
        SecurityJournalManagement: Codeunit "Security Journal Management";
        ClientTypeManagement: Codeunit "Client Type Management";
        SecurityAmount, TotalAmount : Decimal;
        SecurityDescription: Text[100];
        CurrentJnlBatchName: Code[10];

    local procedure CurrentJnlBatchNameOnAfterValidate()
    begin
        CurrPage.SaveRecord();
        this.SecurityJournalManagement.SetName(this.CurrentJnlBatchName, Rec);
        this.SetControlAppearanceFromBatch();
        CurrPage.Update(false);
    end;

    local procedure OpenJournal()
    var
        JnlSelected: Boolean;
        IsHandled: Boolean;
    begin
        IsHandled := false;
        this.OnBeforeOpenJournal(Rec, this.SecurityJournalManagement, this.CurrentJnlBatchName, IsHandled);
        if IsHandled then
            exit;

        if Rec.IsOpenedFromBatch() then begin
            this.CurrentJnlBatchName := Rec."Journal Batch Name";
            this.SecurityJournalManagement.OpenJnl(this.CurrentJnlBatchName, Rec);
            this.SetControlAppearanceFromBatch();
            exit;
        end;
        this.SecurityJournalManagement.TemplateSelection(Page::"Security Journal", Rec, JnlSelected);
        if not JnlSelected then
            Error('');
        this.SecurityJournalManagement.OpenJnl(this.CurrentJnlBatchName, Rec);
        this.SetControlAppearanceFromBatch();
    end;

    local procedure SetControlAppearanceFromBatch()
    var
        SecurityJournalBatch: Record "Security Journal Batch";
    begin
        if not SecurityJournalBatch.Get(Rec.GetRangeMax("Journal Template Name"), this.CurrentJnlBatchName) then
            exit;
    end;

    local procedure UpdateTotals()
    var
        SecurityJournalLine: Record "Security Journal Line";
    begin
        // TODO: Implement this
        Clear(this.SecurityAmount);
        Clear(this.TotalAmount);

        SecurityJournalLine.SetRange("Journal Template Name", Rec."Journal Template Name");
        SecurityJournalLine.SetRange("Journal Batch Name", Rec."Journal Batch Name");
        SecurityJournalLine.SetRange("Security No.", Rec."Security No.");
        if SecurityJournalLine.FindSet() then
            repeat
            //this.SecurityAmount += ;
            until SecurityJournalLine.Next() = 0;

        // Calculate total amount across all securities in the batch
        SecurityJournalLine.SetRange("Security No.");  // Clear project filter
        if SecurityJournalLine.FindSet() then
            repeat
            //  this.TotalAmount += ;
            until SecurityJournalLine.Next() = 0;
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeOpenPage(var SecurityJournalLine: Record "Security Journal Line"; var CurrentJnlBatchName: Code[10])
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeOpenJournal(var SecurityJournalLine: Record "Security Journal Line"; var SecurityJournalManagement: Codeunit "Security Journal Management"; CurrentJnlBatchName: Code[10]; var IsHandled: Boolean)
    begin
    end;
}

