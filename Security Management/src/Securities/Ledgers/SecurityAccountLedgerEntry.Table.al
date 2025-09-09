/// <summary>
/// Table for security account ledger entries
/// </summary>
namespace PwC.Securities.Ledgers;

using PwC.Securities.Security;
using PwC.Securities.SecurityAccounts;
using PwC.Securities.Journals;
using Microsoft.Finance.GeneralLedger.Journal;
using Microsoft.Finance.GeneralLedger.Account;
using Microsoft.Sales.Customer;
using Microsoft.Purchases.Vendor;
using Microsoft.Bank.BankAccount;
using Microsoft.FixedAssets.FixedAsset;
using Microsoft.Intercompany.Partner;
using Microsoft.Finance.AllocationAccount;
using Microsoft.HumanResources.Employee;

table 79910 "Security Account Ledger Entry"
{
    Caption = 'Security Account Ledger Entry';
    DataClassification = CustomerContent;
    LookupPageId = "Security Acc. Ledger Entries";
    DrillDownPageId = "Security Acc. Ledger Entries";

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            ToolTip = 'Specifies the number of the security account ledger entry.';
            AutoIncrement = true;
        }
        field(2; "Security Ledger Entry No."; Integer)
        {
            Caption = 'Security Ledger Entry No.';
            ToolTip = 'Specifies the security ledger entry number.';
            TableRelation = "Security Ledger Entry"."Entry No.";
        }
        field(3; "Security No."; Code[20])
        {
            Caption = 'Security No.';
            ToolTip = 'Specifies the security number.';
            TableRelation = "Security"."No.";
        }
        field(4; "Security Account Code"; Code[10])
        {
            Caption = 'Security Account Code';
            ToolTip = 'Specifies the security account code.';
            TableRelation = "Security Account"."Account Code" where("Security No." = field("Security No."));
        }
        field(5; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
            ToolTip = 'Specifies the posting date of the entry.';
        }
        field(6; "Trading Date"; Date)
        {
            Caption = 'Trading Date';
            ToolTip = 'Specifies the trading date of the entry.';
        }
        field(7; "Quantity"; Decimal)
        {
            Caption = 'Quantity';
            ToolTip = 'Specifies the quantity of securities.';
            DecimalPlaces = 0 : 20;
        }
        field(8; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            ToolTip = 'Specifies the document number.';
        }
        field(9; "Document Type"; Enum "Document Type")
        {
            Caption = 'Document Type';
            ToolTip = 'Specifies the document type.';
        }
        field(10; "Description"; Text[50])
        {
            Caption = 'Description';
            ToolTip = 'Specifies the description of the entry.';
        }
        field(11; "User ID"; Code[50])
        {
            Caption = 'User ID';
            ToolTip = 'Specifies the user ID who created the entry.';
        }
        field(12; "Bal. Account Type"; Enum "Gen. Journal Account Type")
        {
            Caption = 'Bal. Account Type';
            ValuesAllowed = "G/L Account", "Bank Account";
            ToolTip = 'Specifies the balance account type.';
        }
        field(13; "Bal. Account No."; Code[20])
        {
            Caption = 'Bal. Account No.';
            ToolTip = 'Specifies the balance account number.';
            TableRelation = if ("Bal. Account Type" = const("G/L Account")) "G/L Account" where("Account Type" = const(Posting),
                                                                                               Blocked = const(false))
            else
            if ("Bal. Account Type" = const(Customer)) Customer
            else
            if ("Bal. Account Type" = const(Vendor)) Vendor
            else
            if ("Bal. Account Type" = const("Bank Account")) "Bank Account"
            else
            if ("Bal. Account Type" = const("Fixed Asset")) "Fixed Asset"
            else
            if ("Bal. Account Type" = const("IC Partner")) "IC Partner"
            else
            if ("Bal. Account Type" = const("Allocation Account")) "Allocation Account"
            else
            if ("Bal. Account Type" = const(Employee)) Employee;
        }
        field(14; "Reclassification"; Boolean)
        {
            Caption = 'Reclassification';
            ToolTip = 'Specifies if this is a reclassification entry.';
        }
        field(15; "Rounding Difference"; Boolean)
        {
            Caption = 'Rounding Difference';
            ToolTip = 'Specifies if this entry represents a rounding difference.';
        }
    }

    keys
    {
        key(PK; "Entry No.") { Clustered = true; }
        key(Key2; "Security Ledger Entry No.") { }
        key(Key3; "Security No.", "Posting Date") { }
        key(Key4; "Security Account Code", "Posting Date") { }
        key(Key5; "Document Type", "Document No.") { }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Entry No.", "Security No.", "Security Account Code", "Posting Date", "Quantity") { }
    }
}
