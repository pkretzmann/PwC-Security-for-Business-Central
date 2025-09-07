/// <summary>
/// Table for security profit posting group setup
/// </summary>
namespace PwC.PostingSetup;

using Microsoft.Finance.GeneralLedger.Account;
using PwC.Securities.Journals;

table 79912 "Security Profit Posting Group"
{
    Caption = 'Security Profit Posting Group';
    LookupPageId = "Security Profit Posting Groups";
    DrillDownPageId = "Security Profit Posting Groups";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Posting Group Code"; Code[10])
        {
            Caption = 'Posting Group Code';
            ToolTip = 'Specifies the posting group code of the security profit posting group.';
            TableRelation = "Security Posting Group";
            NotBlank = true;
        }
        field(2; "Realization Type"; Integer)
        {
            Caption = 'Realization Type';
            ToolTip = 'Specifies the realization type of the security profit posting group.';
        }
        field(3; "Document Type"; Enum "Document Type")
        {
            Caption = 'Document Type';
            ToolTip = 'Specifies the document type of the security profit posting group.';
        }
        field(4; "Profit Type"; Integer)
        {
            Caption = 'Profit Type';
            ToolTip = 'Specifies the profit type of the security profit posting group.';
        }
        field(5; "Tax Type"; Integer)
        {
            Caption = 'Tax Type';
            ToolTip = 'Specifies the tax type of the security profit posting group.';
        }
        field(6; "Reversal"; Boolean)
        {
            Caption = 'Reversal';
            ToolTip = 'Specifies whether this is a reversal entry for the security profit posting group.';
        }
        field(7; "G/L Account"; Code[20])
        {
            Caption = 'G/L Account';
            ToolTip = 'Specifies the G/L account of the security profit posting group.';
            TableRelation = "G/L Account";
        }
    }

    keys
    {
        key(PK; "Posting Group Code", "Realization Type", "Document Type", "Profit Type", "Tax Type", "Reversal") { Clustered = true; }
        key(Key2; "G/L Account") { }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Posting Group Code", "Realization Type", "Document Type", "Profit Type") { }
    }
}
