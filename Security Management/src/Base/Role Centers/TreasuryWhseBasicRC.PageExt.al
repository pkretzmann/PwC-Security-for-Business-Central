/// <summary>
/// PageExtension Treasury Business Manager RC extends Record Business Manager Role Center.
/// </summary>
namespace PwC.Base.RoleCenters;

using Microsoft.Warehouse.RoleCenters;
using PwC.Base.Setup;
using PwC.Securities.SecurityAccounts;
using PwC.Securities.Security;
using PwC.Securities.ISIN;
using PwC.Securities.Journals;

pageextension 79905 "Treasury Whse. Basic RC" extends "Whse. Basic Role Center"
{
    layout
    {
        addafter(ApprovalsActivities)
        {
            part(TreasuryActivities; "Treasury Activities") { ApplicationArea = All; }
        }
    }
    actions
    {
        addlast(Sections)
        {
            group(Treasury)
            {
                Caption = 'Treasury', Locked = true;
                ToolTip = 'Manage securities from Treasury.';

                group("Security Management")
                {
                    Caption = 'Security Management', Locked = true;
                    ToolTip = 'Manage securities from Treasury.';

                    action(SecurityAccounts)
                    {
                        ApplicationArea = All;
                        Caption = 'Security Accounts';
                        Image = Inventory;
                        RunObject = page "Security Accounts";
                        ToolTip = 'Manage the security accounts.';
                    }
                    action(Securities)
                    {
                        ApplicationArea = All;
                        Caption = 'Securities';
                        Image = GeneralLedger;
                        RunObject = page "Securities";
                        ToolTip = 'Manage the securities.';
                    }
                    action(ISINs)
                    {
                        ApplicationArea = All;
                        Caption = 'ISINs';
                        Image = Bin;
                        RunObject = page ISINs;
                        ToolTip = 'Manage the ISINs.';
                    }
                    action(SecurityJournals)
                    {
                        ApplicationArea = All;
                        Caption = 'Security Journals';
                        Image = Journal;
                        RunObject = page "Security Journal";
                        ToolTip = 'Manage the journals.';
                    }
                }

                group(TreasurySetup)
                {
                    Caption = 'Treasury Setup', Locked = true;
                    ToolTip = 'Manage setup of Treasury.';

                    action(Setup)
                    {
                        ApplicationArea = All;
                        Caption = 'Setup';
                        Image = Setup;
                        RunObject = page "Securities Setup";
                        ToolTip = 'Manage setup of Securities.';
                    }
                }
            }
        }
    }
}