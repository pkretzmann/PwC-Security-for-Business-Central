/// <summary>
/// Enum for trade types
/// </summary>
namespace PwC.Securities.Trade;

enum 79900 "Trade Type"
{
    Extensible = true;
    value(0; Buy) { Caption = 'Buy'; }
    value(1; Sell) { Caption = 'Sell'; }
}
