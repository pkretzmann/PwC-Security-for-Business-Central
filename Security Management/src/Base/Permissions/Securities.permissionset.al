/// <summary>
/// Permissionset for securities
/// </summary>
namespace PwC.Base.Permissions;

using PwC.Base.Setup;
using PwC.Securities;
using PwC.Securities.Ledgers;
using PwC.Securities.Trade;
using PwC.Securities.Currency;
using PwC.Securities.Posting;
using PwC.Securities.Accounts;

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
        tabledata Trade = RIMD,
        table Trade = X,
        codeunit "Trade Posting" = X,
        page "Trade Card" = X,
        report "Security FX Revaluation" = X,
        tabledata "ISIN Code" = RIMD,
        table "ISIN Code" = X,
        tabledata "Security Account" = RIMD,
        table "Security Account" = X,
        page "ISIN Codes" = X,
        tabledata Account = RIMD,
        table Account = X,
        page Accounts = X,
        page "Security Accounts" = X;
}