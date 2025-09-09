/// <summary>
/// Codeunit for posting security trades from journal lines
/// Similar structure to Codeunit 12 "Gen. Jnl.-Post Line"
/// </summary>
namespace PwC.Securities.Posting;

using PwC.Securities.Journals;
using PwC.Securities.Ledgers;
using PwC.Securities.Security;
using PwC.PostingSetup;
using Microsoft.Finance.GeneralLedger.Journal;
using Microsoft.Finance.GeneralLedger.Posting;
using Microsoft.Finance.GeneralLedger.Ledger;

codeunit 79920 "Trade Posting"
{
    TableNo = "Security Journal Line";

    trigger OnRun()
    begin
        RunWithCheck(Rec);
    end;

    var
        Security: Record Security;
        SecurityPostingGroup: Record "Security Posting Group";
        SecurityLedgerEntry: Record "Security Ledger Entry";
        SecurityAccountLedgerEntry: Record "Security Account Ledger Entry";
        SecurityRegister: Record "Security Register";
        GenJnlLine: Record "Gen. Journal Line";
        GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
        NextTransactionNo: Integer;
        NextSecurityLedgerEntryNo: Integer;
        NextSecurityAccountLedgerEntryNo: Integer;
        RegisterFromSecurityLedgerEntryNo: Integer;
        RegisterFromSecurityAccountLedgerEntryNo: Integer;

    /// <summary>
    /// Main posting procedure - similar to RunWithCheck in Gen. Jnl.-Post Line
    /// </summary>
    /// <param name="SecurityJournalLine">The security journal line to post</param>
    procedure RunWithCheck(var SecurityJournalLine: Record "Security Journal Line")
    begin
        this.OnBeforeRunWithCheck(SecurityJournalLine);

        this.CheckLine(SecurityJournalLine);
        this.InitializeGlobals();
        this.FindNextTransactionNo();
        this.InitRegister();

        this.PostSecurityJnlLine(SecurityJournalLine);
        this.FinishRegister();

        this.OnAfterRunWithCheck(SecurityJournalLine);
    end;

    local procedure CheckLine(var SecurityJournalLine: Record "Security Journal Line")
    begin
        this.OnBeforeCheckLine(SecurityJournalLine);

        SecurityJournalLine.TestField("Security No.");
        SecurityJournalLine.TestField("Posting Date");
        SecurityJournalLine.TestField("Document No.");
        SecurityJournalLine.TestField(Quantity);
        if SecurityJournalLine."Security Account Code" = '' then
            SecurityJournalLine.FieldError("Security Account Code");

        this.OnAfterCheckLine(SecurityJournalLine);
    end;

    local procedure InitializeGlobals()
    begin
        Clear(SecurityLedgerEntry);
        Clear(SecurityAccountLedgerEntry);
        Clear(SecurityRegister);
        Clear(GenJnlLine);
    end;

    local procedure FindNextTransactionNo()
    var
        GLEntry: Record "G/L Entry";
    begin
        GLEntry.LockTable();
        if GLEntry.FindLast() then
            NextTransactionNo := GLEntry."Transaction No." + 1
        else
            NextTransactionNo := 1;
    end;

    local procedure InitRegister()
    begin
        SecurityLedgerEntry.LockTable();
        if SecurityLedgerEntry.FindLast() then begin
            RegisterFromSecurityLedgerEntryNo := SecurityLedgerEntry."Entry No." + 1;
            NextSecurityLedgerEntryNo := SecurityLedgerEntry."Entry No." + 1;
        end else begin
            RegisterFromSecurityLedgerEntryNo := 1;
            NextSecurityLedgerEntryNo := 1;
        end;

        SecurityAccountLedgerEntry.LockTable();
        if SecurityAccountLedgerEntry.FindLast() then begin
            RegisterFromSecurityAccountLedgerEntryNo := SecurityAccountLedgerEntry."Entry No." + 1;
            NextSecurityAccountLedgerEntryNo := SecurityAccountLedgerEntry."Entry No." + 1;
        end else begin
            RegisterFromSecurityAccountLedgerEntryNo := 1;
            NextSecurityAccountLedgerEntryNo := 1;
        end;
    end;

    local procedure PostSecurityJnlLine(var SecurityJournalLine: Record "Security Journal Line")
    begin
        this.OnBeforePostSecurityJnlLine(SecurityJournalLine);

        GetSecurity(SecurityJournalLine."Security No.");

        InsertSecurityLedgerEntry(SecurityJournalLine);
        InsertSecurityAccountLedgerEntry(SecurityJournalLine);
        PostToGL(SecurityJournalLine);

        this.OnAfterPostSecurityJnlLine(SecurityJournalLine);
    end;

    local procedure GetSecurity(SecurityNo: Code[20])
    begin
        if Security."No." <> SecurityNo then begin
            Security.Get(SecurityNo);
            GetSecurityPostingGroup(Security."Posting Group");
        end;
    end;

    local procedure GetSecurityPostingGroup(PostingGroupCode: Code[10])
    begin
        if SecurityPostingGroup.Code <> PostingGroupCode then
            SecurityPostingGroup.Get(PostingGroupCode);
    end;

    local procedure InsertSecurityLedgerEntry(var SecurityJournalLine: Record "Security Journal Line")
    begin
        this.OnBeforeInsertSecurityLedgerEntry(SecurityJournalLine, SecurityLedgerEntry);

        SecurityLedgerEntry.Init();
        SecurityLedgerEntry."Entry No." := NextSecurityLedgerEntryNo;

        // Primary fields
        SecurityLedgerEntry."Transaction No." := NextTransactionNo;
        SecurityLedgerEntry."Security No." := SecurityJournalLine."Security No.";
        SecurityLedgerEntry."Posting Date" := DT2Date(SecurityJournalLine."Posting Date");
        SecurityLedgerEntry."Trading Date" := DT2Date(SecurityJournalLine."Trading Date");
        SecurityLedgerEntry."Document Type" := SecurityJournalLine."Document Type";
        SecurityLedgerEntry."Document No." := CopyStr(SecurityJournalLine."Document No.", 1, 10);
        SecurityLedgerEntry."Description" := SecurityJournalLine."Description";
        SecurityLedgerEntry."Finance Description" := SecurityJournalLine."Description";

        // Dimensions
        SecurityLedgerEntry."Global Dimension 1 Code" := SecurityJournalLine."Shortcut Dimension 1 Code";
        SecurityLedgerEntry."Global Dimension 2 Code" := SecurityJournalLine."Shortcut Dimension 2 Code";
        SecurityLedgerEntry."Dimension Set ID" := SecurityJournalLine."Dimension Set ID";

        // Transaction details
        SecurityLedgerEntry."Realization Type" := SecurityJournalLine."Realization Type";
        SecurityLedgerEntry."Currency Code" := SecurityJournalLine."Currency Code";
        SecurityLedgerEntry."Currency Factor Reciprocal" := SecurityJournalLine."Currency Factor Reciprocal";
        SecurityLedgerEntry."Currency Factor" := SecurityJournalLine."Currency Factor";
        SecurityLedgerEntry."Open" := true;

        // Amounts and quantities
        SecurityLedgerEntry."Quantity" := SecurityJournalLine.Quantity;
        SecurityLedgerEntry."Amount B.I." := SecurityJournalLine."Amount B.I.";
        SecurityLedgerEntry."Amount" := SecurityJournalLine.Amount;
        SecurityLedgerEntry."Amount (LCY)" := SecurityJournalLine."Amount (LCY)";
        SecurityLedgerEntry."Account Amount" := SecurityJournalLine."Account Amount";
        SecurityLedgerEntry."Account Currency Code" := SecurityJournalLine."Account Currency Code";
        SecurityLedgerEntry."Acc. Curr. Factor Reciprocal" := SecurityJournalLine."Acc. Curr. Factor Reciprocal";
        SecurityLedgerEntry."Account Currency Factor" := SecurityJournalLine."Account Currency Factor";

        // Security details
        SecurityLedgerEntry."Share Size" := Security."Share Size";
        SecurityLedgerEntry."Market-Value Principle" := SecurityJournalLine."Market-Value Principle";

        // Trading details
        SecurityLedgerEntry."Price" := SecurityJournalLine.Price;
        SecurityLedgerEntry."Index Price" := SecurityJournalLine."Index Price";
        SecurityLedgerEntry."Costs" := SecurityJournalLine.Costs;
        SecurityLedgerEntry."Trading Interest" := SecurityJournalLine."Trading Interest";
        SecurityLedgerEntry."Trading Interest (LCY)" := SecurityJournalLine."Trading Interest (LCY)";
        SecurityLedgerEntry."Yield Before Tax" := SecurityJournalLine."Yield Before Tax";
        SecurityLedgerEntry."Dividend Tax" := SecurityJournalLine."Dividend Tax";
        SecurityLedgerEntry."Yield Before Tax (LCY)" := SecurityJournalLine."Yield Before Tax (LCY)";
        SecurityLedgerEntry."Dividend Tax (LCY)" := SecurityJournalLine."Dividend Tax (LCY)";

        // Special flags
        SecurityLedgerEntry."Drawing" := SecurityJournalLine.Drawing;
        SecurityLedgerEntry."Bonus Share" := SecurityJournalLine."Bonus Share";

        // System fields
        SecurityLedgerEntry."External Document No." := SecurityJournalLine."External Document No.";
        SecurityLedgerEntry."User ID" := CopyStr(UserId, 1, 50);
        SecurityLedgerEntry."Source Code" := SecurityJournalLine."Source Code";
        SecurityLedgerEntry."Reason Code" := SecurityJournalLine."Reason Code";
        SecurityLedgerEntry."Journal Name" := SecurityJournalLine."Journal Batch Name";

        this.OnBeforeSecurityLedgerEntryInsert(SecurityLedgerEntry, SecurityJournalLine);
        SecurityLedgerEntry.Insert(true);
        this.OnAfterSecurityLedgerEntryInsert(SecurityLedgerEntry, SecurityJournalLine);

        NextSecurityLedgerEntryNo += 1;
    end;

    local procedure InsertSecurityAccountLedgerEntry(var SecurityJournalLine: Record "Security Journal Line")
    begin
        this.OnBeforeInsertSecurityAccountLedgerEntry(SecurityJournalLine, SecurityAccountLedgerEntry);

        SecurityAccountLedgerEntry.Init();
        SecurityAccountLedgerEntry."Entry No." := NextSecurityAccountLedgerEntryNo;
        SecurityAccountLedgerEntry."Security Ledger Entry No." := NextSecurityLedgerEntryNo - 1; // Previous entry
        SecurityAccountLedgerEntry."Security No." := SecurityJournalLine."Security No.";
        SecurityAccountLedgerEntry."Security Account Code" := SecurityJournalLine."Security Account Code";
        SecurityAccountLedgerEntry."Posting Date" := DT2Date(SecurityJournalLine."Posting Date");
        SecurityAccountLedgerEntry."Trading Date" := DT2Date(SecurityJournalLine."Trading Date");
        SecurityAccountLedgerEntry."Quantity" := SecurityJournalLine.Quantity;
        SecurityAccountLedgerEntry."Document No." := SecurityJournalLine."Document No.";
        SecurityAccountLedgerEntry."Document Type" := SecurityJournalLine."Document Type";
        SecurityAccountLedgerEntry."Description" := SecurityJournalLine."Description";
        SecurityAccountLedgerEntry."User ID" := CopyStr(UserId, 1, 50);
        SecurityAccountLedgerEntry."Bal. Account Type" := SecurityJournalLine."Bal. Account Type";
        SecurityAccountLedgerEntry."Bal. Account No." := SecurityJournalLine."Bal. Account No.";
        SecurityAccountLedgerEntry."Reclassification" := false;
        SecurityAccountLedgerEntry."Rounding Difference" := false;

        this.OnBeforeSecurityAccountLedgerEntryInsert(SecurityAccountLedgerEntry, SecurityJournalLine);
        SecurityAccountLedgerEntry.Insert(true);
        this.OnAfterSecurityAccountLedgerEntryInsert(SecurityAccountLedgerEntry, SecurityJournalLine);

        NextSecurityAccountLedgerEntryNo += 1;
    end;

    local procedure PostToGL(var SecurityJournalLine: Record "Security Journal Line")
    begin
        this.OnBeforePostToGL(SecurityJournalLine);

        PostSecurityAccount(SecurityJournalLine);
        PostBalanceAccount(SecurityJournalLine);

        this.OnAfterPostToGL(SecurityJournalLine);
    end;

    local procedure PostSecurityAccount(var SecurityJournalLine: Record "Security Journal Line")
    var
        SecurityAccountNo: Code[20];
    begin
        SecurityAccountNo := GetSecurityGLAccount(Security."Posting Group");

        PrepareGenJnlLine(SecurityJournalLine, SecurityAccountNo, -SecurityJournalLine."Amount (LCY)");
        GenJnlPostLine.RunWithCheck(GenJnlLine);
    end;

    local procedure PostBalanceAccount(var SecurityJournalLine: Record "Security Journal Line")
    var
        BalanceAccountNo: Code[20];
    begin
        BalanceAccountNo := GetBalanceGLAccount(SecurityJournalLine."Bal. Account Type", SecurityJournalLine."Bal. Account No.");

        PrepareGenJnlLine(SecurityJournalLine, BalanceAccountNo, SecurityJournalLine."Amount (LCY)");
        GenJnlPostLine.RunWithCheck(GenJnlLine);
    end;

    local procedure PrepareGenJnlLine(var SecurityJournalLine: Record "Security Journal Line"; AccountNo: Code[20]; Amount: Decimal)
    begin
        this.OnBeforePrepareGenJnlLine(GenJnlLine, SecurityJournalLine);

        GenJnlLine.Init();
        GenJnlLine."Account Type" := GenJnlLine."Account Type"::"G/L Account";
        GenJnlLine."Account No." := AccountNo;
        GenJnlLine."Posting Date" := DT2Date(SecurityJournalLine."Posting Date");
        GenJnlLine."Document Type" := GenJnlLine."Document Type"::" ";
        GenJnlLine."Document No." := SecurityJournalLine."Document No.";
        GenJnlLine.Description := SecurityJournalLine."Description";
        GenJnlLine.Amount := Amount;
        GenJnlLine."Source Code" := SecurityJournalLine."Source Code";
        GenJnlLine."Reason Code" := SecurityJournalLine."Reason Code";
        GenJnlLine."Shortcut Dimension 1 Code" := SecurityJournalLine."Shortcut Dimension 1 Code";
        GenJnlLine."Shortcut Dimension 2 Code" := SecurityJournalLine."Shortcut Dimension 2 Code";
        GenJnlLine."Dimension Set ID" := SecurityJournalLine."Dimension Set ID";
        GenJnlLine."External Document No." := SecurityJournalLine."External Document No.";

        this.OnAfterPrepareGenJnlLine(GenJnlLine, SecurityJournalLine);
    end;

    local procedure FinishRegister()
    begin
        OnBeforeFinishRegister(SecurityRegister);

        SecurityRegister.Init();
        SecurityRegister."From Entry No." := RegisterFromSecurityLedgerEntryNo;
        SecurityRegister."To Entry No." := NextSecurityLedgerEntryNo - 1;
        SecurityRegister."From Security Acc. Entry No." := RegisterFromSecurityAccountLedgerEntryNo;
        SecurityRegister."To Security Acc. Entry No." := NextSecurityAccountLedgerEntryNo - 1;
        SecurityRegister."Issuing Date" := CurrentDateTime;
        SecurityRegister."Source Code" := SecurityLedgerEntry."Source Code";
        SecurityRegister."User ID" := CopyStr(UserId, 1, 50);
        SecurityRegister."Journal Batch Name" := SecurityLedgerEntry."Journal Name";

        OnBeforeSecurityRegisterInsert(SecurityRegister);
        SecurityRegister.Insert(true);
        OnAfterSecurityRegisterInsert(SecurityRegister);
    end;

    // Account determination procedures
    local procedure GetSecurityGLAccount(PostingGroupCode: Code[10]): Code[20]
    begin
        GetSecurityPostingGroup(PostingGroupCode);
        // This should be implemented based on your posting group setup
        // For now, returning a placeholder based on your example
        exit('2640'); // Based on your example, this seems to be the security account
    end;

    local procedure GetBalanceGLAccount(BalanceAccountType: Integer; BalanceAccount: Code[20]): Code[20]
    begin
        // This should handle different balance account types (Bank, G/L Account, etc.)
        case BalanceAccountType of
            0: // G/L Account
                exit(BalanceAccount);
            2: // Bank Account - return a default G/L account for bank
                exit('2620'); // Based on your example, this seems to be the balance account
            else
                exit('2620');
        end;
    end;

    // Integration Events - similar to Gen. Jnl.-Post Line pattern
    [IntegrationEvent(false, false)]
    local procedure OnBeforeRunWithCheck(var SecurityJournalLine: Record "Security Journal Line")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterRunWithCheck(var SecurityJournalLine: Record "Security Journal Line")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeCheckLine(var SecurityJournalLine: Record "Security Journal Line")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterCheckLine(var SecurityJournalLine: Record "Security Journal Line")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforePostSecurityJnlLine(var SecurityJournalLine: Record "Security Journal Line")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterPostSecurityJnlLine(var SecurityJournalLine: Record "Security Journal Line")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeInsertSecurityLedgerEntry(var SecurityJournalLine: Record "Security Journal Line"; var SecurityLedgerEntry: Record "Security Ledger Entry")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeSecurityLedgerEntryInsert(var SecurityLedgerEntry: Record "Security Ledger Entry"; var SecurityJournalLine: Record "Security Journal Line")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterSecurityLedgerEntryInsert(var SecurityLedgerEntry: Record "Security Ledger Entry"; var SecurityJournalLine: Record "Security Journal Line")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeInsertSecurityAccountLedgerEntry(var SecurityJournalLine: Record "Security Journal Line"; var SecurityAccountLedgerEntry: Record "Security Account Ledger Entry")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeSecurityAccountLedgerEntryInsert(var SecurityAccountLedgerEntry: Record "Security Account Ledger Entry"; var SecurityJournalLine: Record "Security Journal Line")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterSecurityAccountLedgerEntryInsert(var SecurityAccountLedgerEntry: Record "Security Account Ledger Entry"; var SecurityJournalLine: Record "Security Journal Line")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforePostToGL(var SecurityJournalLine: Record "Security Journal Line")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterPostToGL(var SecurityJournalLine: Record "Security Journal Line")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforePrepareGenJnlLine(var GenJournalLine: Record "Gen. Journal Line"; var SecurityJournalLine: Record "Security Journal Line")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterPrepareGenJnlLine(var GenJournalLine: Record "Gen. Journal Line"; var SecurityJournalLine: Record "Security Journal Line")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeFinishRegister(var SecurityRegister: Record "Security Register")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeSecurityRegisterInsert(var SecurityRegister: Record "Security Register")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterSecurityRegisterInsert(var SecurityRegister: Record "Security Register")
    begin
    end;
}
