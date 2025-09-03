/// <summary>
/// Codeunit for security journal management
/// </summary>
namespace PwC.Securities.Journals.JournalTemplate;

using PwC.Securities.Security;
using PwC.Securities.Journals;

codeunit 79917 "Security Journal Management"
{
    trigger OnRun()
    begin
    end;

    var
        LastSecurityJnlLine: Record "Security Journal Line";
        OpenFromBatch: Boolean;
        SecurityTemplateTok: Label 'SECURITY', Locked = true;
        SecurityTemplateDescrLbl: Label 'Security Time Journal';
        SecurityBatchLbl: Label 'DEFAULT';
        SecurityBatchDescrLbl: Label 'Default Journal';

    /// <summary>
    /// Template selection
    /// </summary>
    /// <param name="PageID">Page ID</param>
    /// <param name="SecurityJournalLine">Security journal line</param>
    /// <param name="JnlSelected">Journal selected</param>
    procedure TemplateSelection(PageID: Integer; var SecurityJournalLine: Record "Security Journal Line"; var JnlSelected: Boolean)
    var
        SecurityJournalTemplate: Record "Security Journal Template";
    begin
        JnlSelected := true;

        SecurityJournalTemplate.Reset();
        SecurityJournalTemplate.SetRange("Page ID", PageID);
        this.OnTemplateSelectionOnAfterSecurityJnlTemplateSetFilters(PageID, SecurityJournalLine, SecurityJournalTemplate);
        case SecurityJournalTemplate.Count of
            0:
                begin
                    SecurityJournalTemplate.Init();
                    SecurityJournalTemplate.Name := this.SecurityTemplateTok;
                    SecurityJournalTemplate.Description := this.SecurityTemplateDescrLbl;
                    SecurityJournalTemplate.Validate("Page ID", PageID);
                    SecurityJournalTemplate.Insert(false);
                    Commit(); // Copied from MS
                end;
            1:
                SecurityJournalTemplate.FindFirst();
            else
                JnlSelected := Page.RunModal(0, SecurityJournalTemplate) = Action::LookupOK;
        end;
        if JnlSelected then begin
            SecurityJournalLine.FilterGroup := 2;
            SecurityJournalLine.SetRange("Journal Template Name", SecurityJournalTemplate.Name);
            SecurityJournalLine.FilterGroup := 0;
            if OpenFromBatch then begin
                SecurityJournalLine."Journal Template Name" := '';
                Page.Run(SecurityJournalTemplate."Page ID", SecurityJournalLine);
            end;
        end;
    end;

    /// <summary>
    /// Template selection from batch
    /// </summary>
    /// <param name="SecurityJournalBatch">Security journal batch</param>
    procedure TemplateSelectionFromBatch(var SecurityJournalBatch: Record "Security Journal Batch")
    var
        SecurityJournalLine: Record "Security Journal Line";
        SecurityJournalTemplate: Record "Security Journal Template";
        IsHandled: Boolean;
    begin
        IsHandled := false;
        this.OnBeforeTemplateSelectionFromBatch(SecurityJournalBatch, OpenFromBatch, IsHandled);
        if IsHandled then
            exit;

        OpenFromBatch := true;
        SecurityJournalTemplate.Get(SecurityJournalBatch."Journal Template Name");
        SecurityJournalTemplate.TestField("Page ID");
        SecurityJournalBatch.TestField(Name);

        SecurityJournalLine.FilterGroup := 2;
        SecurityJournalLine.SetRange("Journal Template Name", SecurityJournalTemplate.Name);
        SecurityJournalLine.FilterGroup := 0;

        SecurityJournalLine."Journal Template Name" := '';
        SecurityJournalLine."Journal Batch Name" := SecurityJournalBatch.Name;
        Page.Run(SecurityJournalTemplate."Page ID", SecurityJournalLine);
    end;

    /// <summary>
    /// Open journal
    /// </summary>
    /// <param name="CurrentJnlBatchName">Current journal batch name</param>
    /// <param name="SecurityJournalLine">Security journal line</param>
    procedure OpenJnl(var CurrentJnlBatchName: Code[10]; var SecurityJournalLine: Record "Security Journal Line")
    begin
        this.OnBeforeOpenJnl(CurrentJnlBatchName, SecurityJournalLine);

        this.CheckTemplateName(SecurityJournalLine.GetRangeMax("Journal Template Name"), CurrentJnlBatchName);
        SecurityJournalLine.FilterGroup := 2;
        SecurityJournalLine.SetRange("Journal Batch Name", CurrentJnlBatchName);
        SecurityJournalLine.FilterGroup := 0;
    end;

    /// <summary>
    /// Open journal batch
    /// </summary>
    /// <param name="SecurityJournalBatch">Security journal batch</param>
    procedure OpenJnlBatch(var SecurityJournalBatch: Record "Security Journal Batch")
    var
        SecurityJournalTemplate: Record "Security Journal Template";
        SecurityJournalLine: Record "Security Journal Line";
        JnlSelected: Boolean;
        IsHandled: Boolean;
    begin
        IsHandled := false;
        this.OnBeforeOpenJnlBatch(SecurityJournalBatch, IsHandled);
        if IsHandled then
            exit;

        if SecurityJournalBatch.GetFilter("Journal Template Name") <> '' then
            exit;
        SecurityJournalBatch.FilterGroup(2);
        if SecurityJournalBatch.GetFilter("Journal Template Name") <> '' then begin
            SecurityJournalBatch.FilterGroup(0);
            exit;
        end;
        SecurityJournalBatch.FilterGroup(0);

        if not SecurityJournalBatch.Find('-') then begin
            if not SecurityJournalTemplate.FindFirst() then
                this.TemplateSelection(0, SecurityJournalLine, JnlSelected);
            if SecurityJournalTemplate.FindFirst() then
                this.CheckTemplateName(SecurityJournalTemplate.Name, SecurityJournalBatch.Name);
            if SecurityJournalTemplate.FindFirst() then
                this.CheckTemplateName(SecurityJournalTemplate.Name, SecurityJournalBatch.Name);
        end;
        SecurityJournalBatch.Find('-');
        JnlSelected := true;
        if SecurityJournalBatch.GetFilter("Journal Template Name") <> '' then
            SecurityJournalTemplate.SetRange(Name, SecurityJournalBatch.GetFilter("Journal Template Name"));
        case SecurityJournalTemplate.Count of
            1:
                SecurityJournalTemplate.FindFirst();
            else
                JnlSelected := Page.RunModal(0, SecurityJournalTemplate) = Action::LookupOK;
        end;
        if not JnlSelected then
            Error('');

        SecurityJournalBatch.FilterGroup(0);
        SecurityJournalBatch.SetRange("Journal Template Name", SecurityJournalTemplate.Name);
        SecurityJournalBatch.FilterGroup(2);
    end;

    local procedure CheckTemplateName(CurrentJnlTemplateName: Code[10]; var CurrentJnlBatchName: Code[10])
    var
        SecurityJournalBatch: Record "Security Journal Batch";
    begin
        SecurityJournalBatch.SetRange("Journal Template Name", CurrentJnlTemplateName);
        if not SecurityJournalBatch.Get(CurrentJnlTemplateName, CurrentJnlBatchName) then begin
            if not SecurityJournalBatch.FindFirst() then begin
                SecurityJournalBatch.Init();
                SecurityJournalBatch."Journal Template Name" := CurrentJnlTemplateName;
                SecurityJournalBatch.Name := this.SecurityBatchLbl;
                SecurityJournalBatch.Description := this.SecurityBatchDescrLbl;
                if SecurityJournalBatch.Insert(true) then;
                Commit();  // Copied from MS
            end;
            CurrentJnlBatchName := SecurityJournalBatch.Name;
        end;
    end;

    /// <summary>
    /// Check name
    /// </summary>
    /// <param name="CurrentJnlBatchName">Current journal batch name</param>
    /// <param name="SecurityJournalLine">Security journal line</param>
    procedure CheckName(CurrentJnlBatchName: Code[10]; var SecurityJournalLine: Record "Security Journal Line")
    var
        SecurityJournalBatch: Record "Security Journal Batch";
    begin
        SecurityJournalBatch.Get(SecurityJournalLine.GetRangeMax("Journal Template Name"), CurrentJnlBatchName);
    end;

    /// <summary>
    /// Set name
    /// </summary>
    /// <param name="CurrentJnlBatchName">Current journal batch name</param>
    /// <param name="SecurityJournalLine">Security journal line</param>
    procedure SetName(CurrentJnlBatchName: Code[10]; var SecurityJournalLine: Record "Security Journal Line")
    begin
        SecurityJournalLine.FilterGroup := 2;
        SecurityJournalLine.SetRange("Journal Batch Name", CurrentJnlBatchName);
        SecurityJournalLine.FilterGroup := 0;
        if SecurityJournalLine.Find('-') then;
    end;

    /// <summary>
    /// Lookup name
    /// </summary>
    /// <param name="CurrentJnlBatchName">Current journal batch name</param>
    /// <param name="SecurityJournalLine">Security journal line</param>
    procedure LookupName(var CurrentJnlBatchName: Code[10]; var SecurityJournalLine: Record "Security Journal Line")
    var
        SecurityJournalBatch: Record "Security Journal Batch";
    begin
        Commit();  // Copied from MS
        SecurityJournalBatch."Journal Template Name" := SecurityJournalLine.GetRangeMax("Journal Template Name");
        SecurityJournalBatch.Name := SecurityJournalLine.GetRangeMax("Journal Batch Name");
        SecurityJournalBatch.FilterGroup(2);
        SecurityJournalBatch.SetRange("Journal Template Name", SecurityJournalBatch."Journal Template Name");
        this.OnLookupNameOnAfterSetFilters(SecurityJournalBatch);
        SecurityJournalBatch.FilterGroup(0);
        if Page.RunModal(0, SecurityJournalBatch) = Action::LookupOK then begin
            CurrentJnlBatchName := SecurityJournalBatch.Name;
            this.SetName(CurrentJnlBatchName, SecurityJournalLine);
        end;
    end;

    /// <summary>
    /// Get names
    /// </summary>
    /// <param name="SecurityJournalLine">Security journal line</param>
    /// <param name="SecurityName">Security name</param>
    procedure GetNames(var SecurityJournalLine: Record "Security Journal Line"; var SecurityName: Text[100])
    begin
        SecurityName := this.GetSecurityName(SecurityJournalLine);

        this.LastSecurityJnlLine := SecurityJournalLine;
    end;

    local procedure GetSecurityName(SecurityJournalLine: Record "Security Journal Line") SecurityName: Text[100]
    var
        Security: Record Security;
        IsHandled: Boolean;
    begin
        IsHandled := false;
        this.OnBeforeGetSecurityName(SecurityJournalLine, this.LastSecurityJnlLine, SecurityName, IsHandled);
        if IsHandled then
            exit(SecurityName);

        if (SecurityJournalLine."Security No." = '') or
           (SecurityJournalLine."Security No." <> this.LastSecurityJnlLine."Security No.")
        then begin
            SecurityName := '';
            if Security.Get(SecurityJournalLine."Security No.") then
                SecurityName := CopyStr(Security.Name, 1, MaxStrLen(SecurityName));
        end;
    end;

    [IntegrationEvent(false, false)]
    local procedure OnLookupNameOnAfterSetFilters(var TogglJournalBatch: Record "Security Journal Batch")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeOpenJnlBatch(var TogglJournalBatch: Record "Security Journal Batch"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeGetSecurityName(SecurityJnlLine: Record "Security Journal Line"; LastSecurityJournalLine: Record "Security Journal Line"; var SecurityDescription: Text[100]; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeOpenJnl(var CurrentJnlBatchName: Code[10]; var SecurityJournalLine: Record "Security Journal Line")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeTemplateSelectionFromBatch(var SecurityJournalBatch: Record "Security Journal Batch"; var OpenFromBatch: Boolean; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnTemplateSelectionOnAfterSecurityJnlTemplateSetFilters(var PageID: Integer; var SecurityJournalLine: Record "Security Journal Line"; var SecurityJournalTemplate: Record "Security Journal Template")
    begin
    end;
}

