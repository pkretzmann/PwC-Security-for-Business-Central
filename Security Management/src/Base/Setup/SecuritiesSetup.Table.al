/// <summary>
/// Table for setting up securities
/// </summary>
namespace PwC.Base.Setup;

using Microsoft.Finance.GeneralLedger.Account;
using Microsoft.Bank.BankAccount;
using Microsoft.Finance.GeneralLedger.Journal;

table 79900 "Securities Setup"
{
    Caption = 'Securities Setup';
    DataClassification = SystemMetadata;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
            ToolTip = 'Specifies the primary key of the record.';
            NotBlank = false;
            AllowInCustomizations = Never;
        }
        field(10; "Investment G/L Acct"; Code[20])
        {
            TableRelation = "G/L Account"."No.";
            Caption = 'Investment G/L Account';
            ToolTip = 'Specifies the investment G/L account.';
        }
        field(11; "Bank Account No."; Code[20])
        {
            TableRelation = "Bank Account"."No.";
            Caption = 'Bank Account';
            ToolTip = 'Specifies the bank account.';
        }
        field(12; "Realized Gain G/L"; Code[20])
        {
            TableRelation = "G/L Account"."No.";
            Caption = 'Realized Gain G/L Account';
            ToolTip = 'Specifies the realized gain G/L account.';
        }
        field(13; "Realized Loss G/L"; Code[20])
        {
            TableRelation = "G/L Account"."No.";
            Caption = 'Realized Loss G/L Account';
            ToolTip = 'Specifies the realized loss G/L account.';
        }
        field(14; "Unreal. Gain G/L"; Code[20])
        {
            TableRelation = "G/L Account"."No.";
            Caption = 'Unrealized Gain G/L Account';
            ToolTip = 'Specifies the unrealized gain G/L account.';
        }
        field(15; "Unreal. Loss G/L"; Code[20])
        {
            TableRelation = "G/L Account"."No.";
            Caption = 'Unrealized Loss G/L Account';
            ToolTip = 'Specifies the unrealized loss G/L account.';
        }
        field(16; "Gen. Jnl. Template"; Code[20])
        {
            TableRelation = "Gen. Journal Template".Name;
            Caption = 'General Journal Template';
            ToolTip = 'Specifies the general journal template.';
        }
        field(17; "Gen. Jnl. Batch"; Code[20])
        {
            TableRelation = "Gen. Journal Batch".Name WHERE("Journal Template Name" = FIELD("Gen. Jnl. Template"));
            Caption = 'General Journal Batch';
            ToolTip = 'Specifies the general journal batch.';
        }
        field(18; "Fee Account"; Code[20])
        {
            TableRelation = "G/L Account"."No.";
            Caption = 'Fee Account';
            ToolTip = 'Specifies the fee account.';
        }
        field(19; "Capitalize Fees"; Boolean)
        {
            // TRUE  = DR Investment inkl. kurtage (ingen Fee-post)
            // FALSE = DR Investment ekskl. kurtage + DR Fee; CR Bank = brutto + fee
            Caption = 'Capitalize Fees (else Expense)';
            ToolTip = 'Specifies whether to capitalize fees (TRUE) or expense them (FALSE).';
        }
    }

    keys { key(PK; "Primary Key") { Clustered = true; } }
}