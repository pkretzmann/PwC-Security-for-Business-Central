/// <summary>
/// Table for security ledger entries
/// </summary>
namespace PwC.Securities.Ledgers;

using PwC.Securities;

table 79902 "Security Ledger Entry"
{
    Caption = 'Security Ledger Entry';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No."; Integer) { AutoIncrement = true; }
        field(2; "Security No."; Code[20]) { TableRelation = "Security"."No."; }
        field(3; "Posting Date"; Date) { }
        field(4; "Document No."; Code[20]) { }
        field(5; "Quantity"; Decimal) { }
        field(6; "Unit Cost (Trade Curr)"; Decimal) { }
        field(7; "Amount (Trade Curr)"; Decimal) { }
        field(8; "Currency Code"; Code[10]) { }
        field(9; "Amount (LCY)"; Decimal) { }
        field(10; "Remaining Quantity"; Decimal) { }
        field(11; "Closed"; Boolean) { }
        field(12; "Realized G/L (LCY)"; Decimal) { }
        field(13; "Unrealized G/L (LCY)"; Decimal) { }
    }
    keys
    {
        key(PK; "Entry No.") { Clustered = true; }
        key(Key2; "Security No.", "Posting Date") { }
    }

    trigger OnDelete()
    var
        ClosedErr: Label 'You cannot delete a closed security ledger entry.';
    begin
        if "Closed" then
            Error(ClosedErr);
    end;
}
