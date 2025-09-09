/// <summary>
/// Table for security journal templates
/// </summary>
namespace PwC.Securities.Journals.JournalTemplate;

using System.Reflection;
using Microsoft.Inventory.Tracking;
using PwC.Securities.Journals;

table 79917 "Security Journal Template"
{
    Caption = 'Security Journal Template';
    DrillDownPageId = "Security Journal Template List";
    LookupPageId = "Security Journal Template List";
    ReplicateData = true;
    DataClassification = CustomerContent;

    fields
    {
        field(1; Name; Code[10])
        {
            Caption = 'Name';
            NotBlank = true;
            ToolTip = 'Specifies the name of this journal template. You can enter a maximum of 10 characters, both numbers and letters.';
        }
        field(2; Description; Text[80])
        {
            Caption = 'Description';
            ToolTip = 'Specifies a description of the project journal template for easy identification.';
        }
        field(6; "Page ID"; Integer)
        {
            Caption = 'Page ID';
            TableRelation = AllObjWithCaption."Object ID" where("Object Type" = const(Page));
            ToolTip = 'Specifies the number of the page that is used to show the journal or worksheet that uses the template.';
        }
        field(10; "Source Code"; Code[10])
        {
            Caption = 'Source Code';
            ToolTip = 'Specifies the source code for the journal template. The source code is used to identify the journal template in the system.';
            TableRelation = Microsoft.Foundation.AuditCodes."Source Code";

            trigger OnValidate()
            begin
                this.SecurityJournalLine.SetRange("Journal Template Name", Name);
                this.SecurityJournalLine.ModifyAll("Source Code", "Source Code", false);
                Rec.Modify();
            end;
        }
    }

    keys
    {
        key(Key1; Name) { Clustered = true; }
        key(Key2; "Page ID") { }
    }

    trigger OnDelete()
    begin
        this.SecurityJournalLine.SetRange("Journal Template Name", Name);
        this.SecurityJournalLine.DeleteAll(true);
        this.SecurityJournalBatch.SetRange("Journal Template Name", Name);
        this.SecurityJournalBatch.DeleteAll(false);
    end;

    trigger OnInsert()
    begin
        this.Validate("Page ID");
    end;

    trigger OnRename()
    begin
        this.ReservEngineMgt.RenamePointer(Database::"Security Journal Line",
          0, xRec.Name, '', 0, 0,
          0, Name, '', 0, 0);
    end;

    var
        SecurityJournalBatch: Record "Security Journal Batch";
        SecurityJournalLine: Record "Security Journal Line";
        ReservEngineMgt: Codeunit "Reservation Engine Mgt.";
}