/// <summary>
/// Table for security journal lines
/// </summary>
namespace PwC.Securities.Journals;

using PwC.Securities.Security;
using PwC.Securities.Journals.JournalTemplate;
using Microsoft.Foundation.NoSeries;
using PwC.Securities.Accounts;
using Microsoft.Finance.GeneralLedger.Journal;
using Microsoft.Finance.GeneralLedger.Account;
using Microsoft.Sales.Customer;
using Microsoft.Purchases.Vendor;
using Microsoft.Bank.BankAccount;
using Microsoft.FixedAssets.FixedAsset;
using Microsoft.Intercompany.Partner;
using Microsoft.Finance.AllocationAccount;
using Microsoft.HumanResources.Employee;
using Microsoft.Finance.Currency;

table 79918 "Security Journal Line"
{
    Caption = 'Security Journal Line';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Journal Template Name"; Code[10])
        {
            Caption = 'Journal Template Name';
            ToolTip = 'Specifies the journal template name.';
            TableRelation = "Security Journal Template";
            NotBlank = true;
        }
        field(2; "Journal Batch Name"; Code[10])
        {
            Caption = 'Journal Batch Name';
            ToolTip = 'Specifies the journal batch name.';
            TableRelation = "Security Journal Batch".Name where("Journal Template Name" = field("Journal Template Name"));
            NotBlank = true;
        }
        field(3; "Line No."; Integer)
        {
            Caption = 'Line No.';
            ToolTip = 'Specifies the line number of the journal line.';
        }
        field(4; "Security No."; Code[20])
        {
            Caption = 'Security No.';
            ToolTip = 'Specifies the security number.';
            TableRelation = "Security"."No.";

            trigger OnValidate()
            var
                Security: Record "Security";
                PostingDescriptionLbl: Label '%1: %2', Comment = '%1: Document Type, %2: Security No.', Locked = true;
            begin
                case true of
                    Rec."Security No." = '':
                        begin
                            Rec.Description := '';
                            Rec.Validate("Currency Code", '');
                        end;
                    Rec."Security No." <> '':
                        if Security.Get(Rec."Security No.") then begin
                            Rec.Description := CopyStr(StrSubstNo(PostingDescriptionLbl, Format(Rec."Document Type"), Security.Name), 1, MaxStrLen(Rec.Description));
                            Rec.Validate("Currency Code", Security."Currency Code");
                        end;
                end;
            end;
        }
        field(5; "Posting Date"; DateTime)
        {
            Caption = 'Posting Date';
            ToolTip = 'Specifies the posting date of the journal line.';
        }
        field(6; "Document Type"; Enum "Document Type")
        {
            Caption = 'Document Type';
            ToolTip = 'Specifies the document type.';
        }
        field(7; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            ToolTip = 'Specifies the document number.';
        }
        field(8; "Description"; Text[100])
        {
            Caption = 'Description';
            ToolTip = 'Specifies the description of the journal line.';
        }
        field(9; "Realization Type"; Integer)
        {
            Caption = 'Realization Type';
            ToolTip = 'Specifies the realization type.';
        }
        field(10; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            ToolTip = 'Specifies the currency code.';
            TableRelation = Currency;
        }
        field(11; Amount; Decimal)
        {
            Caption = 'Amount';
            ToolTip = 'Specifies the amount.';
            DecimalPlaces = 0 : 20;
            BlankZero = true;
        }
        field(12; "Amount B.I."; Decimal)
        {
            Caption = 'Amount B.I.';
            ToolTip = 'Specifies the amount before interest.';
            DecimalPlaces = 0 : 20;
            BlankZero = true;
        }
        field(13; "Amount (LCY)"; Decimal)
        {
            Caption = 'Amount (LCY)';
            ToolTip = 'Specifies the amount in local currency.';
            DecimalPlaces = 0 : 20;
            BlankZero = true;
        }
        field(14; "Account Amount"; Decimal)
        {
            Caption = 'Account Amount';
            ToolTip = 'Specifies the account amount.';
            DecimalPlaces = 0 : 20;
            BlankZero = true;
        }
        field(15; "Currency Factor Reciprocal"; Decimal)
        {
            Caption = 'Currency Factor Reciprocal';
            ToolTip = 'Specifies the reciprocal of the currency factor.';
            DecimalPlaces = 0 : 20;
            BlankZero = true;
        }
        field(16; "Currency Factor"; Decimal)
        {
            Caption = 'Currency Factor';
            ToolTip = 'Specifies the currency factor.';
            DecimalPlaces = 0 : 20;
            BlankZero = true;
        }
        field(17; "Acc. Curr. Factor Reciprocal"; Decimal)
        {
            Caption = 'Acc. Curr. Factor Reciprocal';
            ToolTip = 'Specifies the reciprocal of the account currency factor.';
            DecimalPlaces = 0 : 20;
            BlankZero = true;
        }
        field(18; "Account Currency Factor"; Decimal)
        {
            Caption = 'Account Currency Factor';
            ToolTip = 'Specifies the account currency factor.';
            DecimalPlaces = 0 : 20;
            BlankZero = true;
        }
        field(19; "Shortcut Dimension 1 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 1 Code';
            ToolTip = 'Specifies the shortcut dimension 1 code.';
        }
        field(20; "Shortcut Dimension 2 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 2 Code';
            ToolTip = 'Specifies the shortcut dimension 2 code.';
        }
        field(21; "Source Code"; Code[10])
        {
            Caption = 'Source Code';
            ToolTip = 'Specifies the source code for the journal line.';
            TableRelation = Microsoft.Foundation.AuditCodes."Source Code";
        }
        field(22; "Transferred from Security No."; Code[20])
        {
            Caption = 'Transferred from Security No.';
            ToolTip = 'Specifies the security number this line was transferred from.';
        }
        field(23; "Apply Entry No."; Integer)
        {
            Caption = 'Apply Entry No.';
            ToolTip = 'Specifies the entry number to apply.';
        }
        field(24; "Security Account Code"; Code[10])
        {
            Caption = 'Security Account Code';
            ToolTip = 'Specifies the security account code.';
            TableRelation = Account.Code;
        }
        field(25; "Account Currency Code"; Code[10])
        {
            Caption = 'Account Currency Code';
            ToolTip = 'Specifies the account currency code.';
        }
        field(26; "Market-Value Principle"; Boolean)
        {
            Caption = 'Market-Value Principle';
            ToolTip = 'Specifies if the market-value principle is applied.';
        }
        field(27; Quantity; Decimal)
        {
            Caption = 'Quantity';
            ToolTip = 'Specifies the quantity of securities.';
            DecimalPlaces = 0 : 20;
            BlankZero = true;
        }
        field(28; "Bal. Account Type"; Enum "Gen. Journal Account Type")
        {
            Caption = 'Bal. Account Type';
            ValuesAllowed = "G/L Account", "Bank Account";
            ToolTip = 'Specifies the balance account type.';
        }
        field(29; "Bal. Account No."; Code[20])
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
        field(30; "Reason Code"; Code[10])
        {
            Caption = 'Reason Code';
            ToolTip = 'Specifies the reason code for the journal line.';
        }
        field(31; "Trading Date"; DateTime)
        {
            Caption = 'Trading Date';
            ToolTip = 'Specifies the trading date of the journal line.';

            trigger OnValidate()
            begin
                "Posting Date" := "Trading Date";
            end;
        }
        field(32; "External Document No."; Code[20])
        {
            Caption = 'External Document No.';
            ToolTip = 'Specifies the external document number.';
        }
        field(33; "Posting Number Series"; Code[10])
        {
            Caption = 'Posting Number Series';
            ToolTip = 'Specifies the posting number series.';
        }
        field(34; Price; Decimal)
        {
            Caption = 'Price';
            ToolTip = 'Specifies the price of the security.';
            DecimalPlaces = 0 : 20;
            BlankZero = true;
        }
        field(35; "Index Price"; Decimal)
        {
            Caption = 'Index Price';
            ToolTip = 'Specifies the index price.';
            DecimalPlaces = 0 : 20;
            BlankZero = true;
        }
        field(36; Costs; Decimal)
        {
            Caption = 'Costs';
            ToolTip = 'Specifies the costs associated with the transaction.';
            DecimalPlaces = 0 : 20;
            BlankZero = true;
        }
        field(37; "Trading Interest"; Decimal)
        {
            Caption = 'Trading Interest';
            ToolTip = 'Specifies the trading interest.';
            DecimalPlaces = 0 : 20;
            BlankZero = true;
        }
        field(38; "Trading Interest (LCY)"; Decimal)
        {
            Caption = 'Trading Interest (LCY)';
            ToolTip = 'Specifies the trading interest in local currency.';
            DecimalPlaces = 0 : 20;
            BlankZero = true;
        }
        field(39; "Yield Before Tax"; Decimal)
        {
            Caption = 'Yield Before Tax';
            ToolTip = 'Specifies the yield before tax.';
            DecimalPlaces = 0 : 20;
            BlankZero = true;
        }
        field(40; "Dividend Tax"; Decimal)
        {
            Caption = 'Dividend Tax';
            ToolTip = 'Specifies the dividend tax amount.';
            DecimalPlaces = 0 : 20;
            BlankZero = true;
        }
        field(41; "Dividend Tax Pct."; Decimal)
        {
            Caption = 'Dividend Tax Pct.';
            ToolTip = 'Specifies the dividend tax percentage.';
            DecimalPlaces = 0 : 5;
            BlankZero = true;
        }
        field(42; "Yield Before Tax (LCY)"; Decimal)
        {
            Caption = 'Yield Before Tax (LCY)';
            ToolTip = 'Specifies the yield before tax in local currency.';
            DecimalPlaces = 0 : 20;
            BlankZero = true;
        }
        field(43; "Dividend Tax (LCY)"; Decimal)
        {
            Caption = 'Dividend Tax (LCY)';
            ToolTip = 'Specifies the dividend tax amount in local currency.';
            DecimalPlaces = 0 : 20;
            BlankZero = true;
        }
        field(44; Drawing; Boolean)
        {
            Caption = 'Drawing';
            ToolTip = 'Specifies if this is a drawing entry.';

            trigger OnValidate()
            var
                Security: Record "Security";
            begin
                if Drawing then begin
                    Security.Get(Rec."Security No.");
                    Security.TestField("Security Type", "Security Type"::Bond);
                end;
            end;
        }
        field(45; "Bonus Share"; Boolean)
        {
            Caption = 'Bonus Share';
            ToolTip = 'Specifies if this is a bonus share entry.';
        }
        field(46; Free; Boolean)
        {
            Caption = 'Free';
            ToolTip = 'Specifies if this is a free entry.';
        }
        field(47; "New Security Account Code"; Code[10])
        {
            Caption = 'New Security Account Code';
            ToolTip = 'Specifies the new security account code.';
        }
        field(48; "Current Market Value"; Decimal)
        {
            Caption = 'Current Market Value';
            ToolTip = 'Specifies the current market value.';
            DecimalPlaces = 0 : 20;
            BlankZero = true;
        }
        field(49; "Current Market Value (LCY)"; Decimal)
        {
            Caption = 'Current Market Value (LCY)';
            ToolTip = 'Specifies the current market value in local currency.';
            DecimalPlaces = 0 : 20;
            BlankZero = true;
        }
        field(50; "Current Market Value B.I."; Decimal)
        {
            Caption = 'Current Market Value B.I.';
            ToolTip = 'Specifies the current market value before interest.';
            DecimalPlaces = 0 : 20;
            BlankZero = true;
        }
        field(51; "Current Quantity"; Decimal)
        {
            Caption = 'Current Quantity';
            ToolTip = 'Specifies the current quantity.';
            DecimalPlaces = 0 : 20;
            BlankZero = true;
        }
        field(52; "Current Share Size"; Decimal)
        {
            Caption = 'Current Share Size';
            ToolTip = 'Specifies the current share size.';
            DecimalPlaces = 0 : 20;
            BlankZero = true;
        }
        field(53; "New Share Size"; Decimal)
        {
            Caption = 'New Share Size';
            ToolTip = 'Specifies the new share size.';
            DecimalPlaces = 0 : 20;
            BlankZero = true;
        }
        field(54; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            ToolTip = 'Specifies the dimension set ID for the journal line.';
        }
        field(65; "Posting No. Series"; Code[20])
        {
            Caption = 'Posting No. Series';
            TableRelation = "No. Series";
        }
    }

    keys
    {
        key(PK; "Journal Template Name", "Journal Batch Name", "Line No.") { Clustered = true; }
        key(Key2; "Security No.", "Posting Date") { }
        key(Key3; "Document Type", "Document No.") { }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Journal Template Name", "Journal Batch Name", "Line No.", "Security No.") { }
    }

    /// <summary>
    /// Check if the journal line is opened from a batch.
    /// </summary>
    /// <returns></returns>
    procedure IsOpenedFromBatch(): Boolean
    var
        SecurityJournalBatch: Record "Security Journal Batch";
        NotFoundErr: Label 'The %1 %2 is not valid.', Comment = '%1: TableCaption for Toggl Journal Batch. %2: Name of the batch.';
        TemplateFilter: Text;
        BatchFilter: Text;
        ErrorInfo: ErrorInfo;
    begin
        BatchFilter := GetFilter("Journal Batch Name");
        if BatchFilter <> '' then begin
            TemplateFilter := GetFilter("Journal Template Name");
            if TemplateFilter <> '' then
                SecurityJournalBatch.SetFilter("Journal Template Name", TemplateFilter);
            SecurityJournalBatch.SetFilter(Name, BatchFilter);
            if not SecurityJournalBatch.FindFirst() then begin
                ErrorInfo.ErrorType := ErrorInfo.ErrorType::Client;
                ErrorInfo.Message := StrSubstNo(NotFoundErr, SecurityJournalBatch.TableCaption, SecurityJournalBatch.Name);
                Error(ErrorInfo);
            end;
        end;

        exit((("Journal Batch Name" <> '') and ("Journal Template Name" = '')) or (BatchFilter <> ''));
    end;
}
