/// <summary>
/// Permissionset for securities
/// </summary>
namespace PwC.Base.Permissions;

using PwC.Base.Setup;
using PwC.Securities.Ledgers;
using PwC.Securities.Accounts;
using PwC.Securities.Security.ISIN.Price;
using PwC.Base.RoleCenters;
using PwC.Securities.Security;
using PwC.Securities.SecurityAccounts;
using PwC.Securities.ISIN;
using PwC.PostingSetup;
using PwC.Securities.Journals;
using PwC.Securities.Journals.JournalTemplate;

permissionset 79900 Securities
{
    Assignable = true;
    Permissions = tabledata "Securities Setup" = RIMD,
        table "Securities Setup" = X,
        page "Securities Setup" = X,
        tabledata Security = RIMD,
        table Security = X,
        tabledata "Security Ledger Entry" = RIMD,
        table "Security Ledger Entry" = X,
        page "Security Card" = X,
        page Securities = X,
        tabledata ISIN = RIMD,
        table ISIN = X,
        tabledata "Security Account" = RIMD,
        table "Security Account" = X,
        page ISINs = X,
        tabledata Account = RIMD,
        table Account = X,
        page Accounts = X,
        page "Security Accounts" = X,
        tabledata "Investment Fund Price" = RIMD,
        table "Investment Fund Price" = X,
        page "Investment Fund Prices" = X,
        tabledata "Treasury Cue" = RIMD,
        table "Treasury Cue" = X,
        page "Treasury Activities" = X,
        tabledata "Security Register" = RIMD,
        table "Security Register" = X,
        tabledata "Security Account Ledger Entry" = RIMD,
        table "Security Account Ledger Entry" = X,
        tabledata "Security Posting Group" = RIMD,
        table "Security Posting Group" = X,
        page "Security Posting Groups" = X,
        tabledata "Security Profit Posting Group" = RIMD,
        table "Security Profit Posting Group" = X,
        page "Security Profit Posting Groups" = X,
        tabledata "Security Comment Line" = RIMD,
        table "Security Comment Line" = X,
        page "Security Comment List" = X,
        tabledata "Detailed Value Ledger Entry" = RIMD,
        table "Detailed Value Ledger Entry" = X,
        page "Detailed Value Ledger Entries" = X,
        tabledata "Detailed Profit Ledger Entry" = RIMD,
        table "Detailed Profit Ledger Entry" = X,
        page "Detailed Profit Ledger Entries" = X,
        tabledata "Security Journal Line" = RIMD,
        table "Security Journal Line" = X,
        tabledata "Security Journal Batch" = RIMD,
        tabledata "Security Journal Template" = RIMD,
        table "Security Journal Batch" = X,
        table "Security Journal Template" = X,
        codeunit "Security Journal Management" = X,
        page "Security Acc. Ledger Entries" = X,
        page "Security Comment Sheet" = X,
        page "Security Journal" = X,
        page "Security Journal Batches" = X,
        page "Security Journal Template List" = X,
        page "Security Journal Templates" = X,
        page "Security Ledger Entries" = X,
        page "Security Register" = X;
}