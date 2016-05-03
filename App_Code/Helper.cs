using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for Helper
/// </summary>
public static class StringHelper
{
	public const string Delimiter = "...";
    public static string ToTruncatedString(this string s, int limit)
	{
        return (!string.IsNullOrEmpty(s) && s.Length > limit) ? s.Substring(0, limit) + Delimiter : string.Empty;
	}

    public static bool StockDisplayClass(int stock)
    {
        return stock <= 0 ? false : true;
    }

    public partial class VatRateHelper
    {
        public decimal ReturnItemTotal(decimal Total)
        {
            //var cartTotal = 0.00;
            var Vat = decimal.Parse(ConfigurationManager.AppSettings["VatRate"]);
            //cartTotal = Total * Vat + Total;
            return (Total * Vat + Total);
        }

        public decimal ReturnItemVatTotal(decimal Total)
        {
            var Vat = decimal.Parse(ConfigurationManager.AppSettings["VatRate"]);

            return (Total * Vat);
        }
    }
    /*The accepted payment methods for installation 295654:
        • MasterCard Debit
        • Maestro
        • VISA Debit
        • VISA Electron
     */
     public enum DebitCard
    {
        DMC,
        MAES,
        VISA,
        VIED
    };
 
    /*Credit cards installation 1043836:
        • Mastercard Credit
        • JCB
        • VISA Credit
    */
    public enum CreditCard
    {
        MSCD,
        JCB,
        VISD
    };
}