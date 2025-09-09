/// <summary>
/// Table Account (ID 79904).
/// </summary>
namespace PwC.Securities.Accounts;

using Microsoft.Finance.GeneralLedger.Account;
using Microsoft.Finance.GeneralLedger.Journal;
using Microsoft.Sales.Customer;
using Microsoft.Purchases.Vendor;
using Microsoft.Bank.BankAccount;
using Microsoft.FixedAssets.FixedAsset;
using Microsoft.Intercompany.Partner;
using Microsoft.Finance.AllocationAccount;
using Microsoft.HumanResources.Employee;
using Microsoft.Finance.Dimension;

table 79904 Account
{
    Caption = 'Account';
    DataClassification = CustomerContent;
    LookupPageId = Accounts;
    DrillDownPageId = Accounts;

    fields
    {
        field(1; Code; Code[20])
        {
            Caption = 'Code';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the code of the account.';
        }
        field(2; Name; Text[60])
        {
            Caption = 'Name';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the name of the account.';
        }
        field(3; "Security Account No."; Code[40])
        {
            Caption = 'Security Account No.';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the security account number.';
        }
        field(4; "Bal. Account Type"; Enum "Gen. Journal Account Type")
        {
            Caption = 'Bal. Account Type';
            ValuesAllowed = "G/L Account", "Bank Account";
            ToolTip = 'Specifies the balance account type.';
        }
        field(5; "Bal. Account No."; Code[20]) // "Balance Account"; Code[40]) TODO: Delete comment
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
        field(6; "Global Dimension 1 Code"; Code[40])
        {
            CaptionClass = '1,2,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1), Blocked = const(false));
            ToolTip = 'Specifies the global dimension 1 code.';
        }
        field(7; "Global Dimension 2 Code"; Code[40])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2), Blocked = const(false));
            ToolTip = 'Specifies the global dimension 2 code.';
        }
    }

    keys
    {
        key(PK; Code) { Clustered = true; }
    }

    fieldgroups
    {
        fieldgroup(DropDown; Code, Name) { }
    }
}
