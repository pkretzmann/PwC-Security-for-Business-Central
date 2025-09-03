/// <summary>
/// Table for security journal batches
/// </summary>
namespace PwC.Securities.Journals.JournalTemplate;

using Microsoft.Foundation.AuditCodes;
using Microsoft.Foundation.NoSeries;
using PwC.Securities.Journals;

table 79916 "Security Journal Batch"
{
    Caption = 'Security Journal Batch';
    DataCaptionFields = Name, Description;
    LookupPageId = "Security Journal Batches";
    DrillDownPageId = "Security Journal Batches";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Journal Template Name"; Code[10])
        {
            Caption = 'Journal Template Name';
            NotBlank = true;
            TableRelation = "Security Journal Template";
            AllowInCustomizations = Never;
        }
        field(2; Name; Code[10])
        {
            Caption = 'Name';
            NotBlank = true;
            ToolTip = 'Specifies the name of this project journal. You can enter a maximum of 10 characters, both numbers and letters.';
        }
        field(3; Description; Text[100])
        {
            Caption = 'Description';
            ToolTip = 'Specifies a description of this journal.';
        }
        field(4; "Reason Code"; Code[10])
        {
            Caption = 'Reason Code';
            ToolTip = 'Specifies the reason code for this journal.';
            TableRelation = "Reason Code";

            trigger OnValidate()
            var
                SecurityJnlLine: Record "Security Journal Line";
            begin
                if "Reason Code" <> xRec."Reason Code" then begin
                    SecurityJnlLine.SetRange("Journal Template Name", "Journal Template Name");
                    SecurityJnlLine.SetRange("Journal Batch Name", Name);
                    SecurityJnlLine.ModifyAll("Reason Code", "Reason Code", false);
                    Modify();
                end;
            end;
        }
        field(5; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            ToolTip = 'Specifies the number series that is used for the journal.';
            TableRelation = "No. Series";

            trigger OnValidate()
            var
                SecurityJournalTemplate: Record "Security Journal Template";
            begin
                if Rec."No. Series" <> '' then begin
                    SecurityJournalTemplate.Get(Rec."Journal Template Name");
                    if "No. Series" = "Posting No. Series" then
                        Validate("Posting No. Series", '');
                end;
            end;
        }
        field(6; "Posting No. Series"; Code[20])
        {
            Caption = 'Posting No. Series';
            ToolTip = 'Specifies the number series that is used for the journal.';
            TableRelation = "No. Series";

            trigger OnValidate()
            var
                SecurityJnlLine: Record "Security Journal Line";
                PostingNoSeriesErr: Label 'must not be %1', Comment = '%1: Posting No. Series FieldCaption';
            begin
                if ("Posting No. Series" = "No. Series") and ("Posting No. Series" <> '') then
                    Rec.FieldError("Posting No. Series", StrSubstNo(PostingNoSeriesErr, "Posting No. Series"));
                SecurityJnlLine.SetRange("Journal Template Name", "Journal Template Name");
                SecurityJnlLine.SetRange("Journal Batch Name", Name);
                SecurityJnlLine.ModifyAll("Posting No. Series", "Posting No. Series", false);
                Rec.Modify();
            end;
        }
    }

    keys
    {
        key(Key1; "Journal Template Name", Name) { Clustered = true; }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        this.SecurityJournalLine.SetRange("Journal Template Name", "Journal Template Name");
        this.SecurityJournalLine.SetRange("Journal Batch Name", Name);
        this.SecurityJournalLine.DeleteAll(true);
    end;

    trigger OnInsert()
    begin
        Rec.ReadIsolation := Rec.ReadIsolation::UpdLock;
        this.SecurityJournalTemplate.Get("Journal Template Name");
    end;

    trigger OnRename()
    begin
        this.SecurityJournalLine.SetRange("Journal Template Name", xRec."Journal Template Name");
        this.SecurityJournalLine.SetRange("Journal Batch Name", xRec.Name);
        while this.SecurityJournalLine.FindFirst() do
            this.SecurityJournalLine.Rename("Journal Template Name", Name, this.SecurityJournalLine."Line No.");
    end;

    /// <summary>
    /// Setup new batch
    /// </summary>
    procedure SetupNewBatch()
    begin
        this.SecurityJournalTemplate.Get("Journal Template Name");
    end;

    var
        SecurityJournalTemplate: Record "Security Journal Template";
        SecurityJournalLine: Record "Security Journal Line";
}
