/// <summary>
/// Table for securities
/// </summary>
namespace PwC.Securities.Security;

using Microsoft.Finance.Currency;
using Microsoft.Foundation.Address;
using PwC.Securities;
using PwC.Securities.ISIN;

table 79901 Security
{
    Caption = 'Security';
    DataClassification = CustomerContent;
    DataCaptionFields = "No.", Name;
    DrillDownPageId = Securities;
    LookupPageId = "Security Card";

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            ToolTip = 'Specifies the number of the security.';
            NotBlank = true;
        }
        field(2; "ISIN Code"; Code[20])
        {
            Caption = 'ISIN Code';
            ToolTip = 'Specifies the ISIN of the security.';
            TableRelation = ISIN;
        }
        field(3; Name; Text[100])
        {
            Caption = 'Name';
            ToolTip = 'Specifies the name of the security.';
        }
        field(4; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            ToolTip = 'Specifies the trading currency code.';
            TableRelation = Currency;
        }
        field(5; "Search Name"; Text[50])
        {
            Caption = 'Search Name';
            ToolTip = 'Specifies the search name of the security.';
            NotBlank = true;
        }
        field(6; "Security Type"; Enum "Security Type")
        {
            Caption = 'Security Type';
            ToolTip = 'Specifies the type of the security.';
        }
        field(7; "Country Code"; Code[10])
        {
            Caption = 'Country Code';
            ToolTip = 'Specifies the country code of the security.';
            NotBlank = true;
            TableRelation = "Country/Region";
        }
        field(8; "Posting Group"; Code[10])
        {
            Caption = 'Posting Group';
            ToolTip = 'Specifies the posting group of the security.';
            NotBlank = true;
        }
        field(9; "Global Dimension 1 Code"; Code[20])
        {
            Caption = 'Global Dimension 1 Code';
            ToolTip = 'Specifies the global dimension 1 code.';
            NotBlank = true;
        }
        field(10; "Global Dimension 2 Code"; Code[20])
        {
            Caption = 'Global Dimension 2 Code';
            ToolTip = 'Specifies the global dimension 2 code.';
            NotBlank = true;
        }
        field(11; "Number Series"; Code[10])
        {
            Caption = 'Number Series';
            ToolTip = 'Specifies the number series code.';
            NotBlank = true;
        }
        field(12; "Home Page"; Text[120])
        {
            Caption = 'Home Page';
            ToolTip = 'Specifies the home page URL.';
            NotBlank = true;
        }
        field(13; Blocked; Boolean)
        {
            Caption = 'Blocked';
            ToolTip = 'Specifies whether the security is blocked.';
        }
        field(14; "Last Date Modified"; DateTime)
        {
            Caption = 'Last Date Modified';
            ToolTip = 'Specifies when the security was last modified.';
        }
        field(15; "Nom. Interest Rate Pct."; Decimal)
        {
            Caption = 'Nominal Interest Rate %';
            ToolTip = 'Specifies the nominal interest rate percentage.';
            DecimalPlaces = 2 : 20;
        }
        field(16; "Excl. Interest Calculation"; Boolean)
        {
            Caption = 'Exclude Interest Calculation';
            ToolTip = 'Specifies whether to exclude interest calculation.';
        }
        field(17; "F. Coup. Payment Date"; Date)
        {
            Caption = 'First Coupon Payment Date';
            ToolTip = 'Specifies the first coupon payment date.';
        }
        field(18; "L. Coup. Payment Date"; Date)
        {
            Caption = 'Last Coupon Payment Date';
            ToolTip = 'Specifies the last coupon payment date.';
        }
        field(19; "Index Bond"; Boolean)
        {
            Caption = 'Index Bond';
            ToolTip = 'Specifies whether this is an index bond.';
        }
        field(20; "Issuer Code"; Code[100])
        {
            Caption = 'Issuer Code';
            ToolTip = 'Specifies the issuer code.';
            NotBlank = true;
        }
        field(21; "Payment Code"; Code[10])
        {
            Caption = 'Payment Code';
            ToolTip = 'Specifies the payment code.';
            NotBlank = true;
        }
        field(22; "Share Size"; Decimal)
        {
            Caption = 'Share Size';
            ToolTip = 'Specifies the share size.';
            DecimalPlaces = 2 : 20;
        }
        field(23; "Report Grouping Method"; Integer)
        {
            Caption = 'Report Grouping Method';
            ToolTip = 'Specifies the report grouping method.';
        }
        field(24; "Report Grouping Code"; Code[20])
        {
            Caption = 'Report Grouping Code';
            ToolTip = 'Specifies the report grouping code.';
            // TODO tableRelation to report group?
        }
        // TODO: Security: Add flow fields
    }

    keys
    {
        key(PK; "No.") { Clustered = true; }
    }

    /// <summary>
    /// Opens a page to show comments for the security.
    /// </summary>
    procedure ShowLineComments()
    var
        SecurityCommentLine: Record "Security Comment Line";
        SecurityCommentSheet: Page "Security Comment Sheet";
    begin
        this.TestField("No.");
        SecurityCommentLine.SetRange("No.", "No.");
        SecurityCommentSheet.SetTableView(SecurityCommentLine);
        SecurityCommentSheet.RunModal();
    end;
}
