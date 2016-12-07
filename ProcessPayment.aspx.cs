using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Configuration;
using WorldPayDotNet.Common;
using WorldPayDotNet.Hosted;
using System.Web.Services;
using System.Web.Script.Services;

public partial class Payment : System.Web.UI.Page
{
    #region -- Global Properties --
    private static int _installationId;

    private decimal _FeeTotal;

    #endregion --

    protected void Page_Load(object sender, EventArgs e)
    {
        ViewState["InstalationID"] = _installationId;

        ReturnItemDesc();
        ReturnCartTotal();
    }

    protected string ReturnItemDesc()
    {
        var Items = ShoppingCart.GetInstance().Items; //.Instance.Items;
        var cartItemDesc = string.Empty;
        foreach (CartItem item in Items)
        {
            cartItemDesc += item.Name + " x " + item.Quantity + " " + (string.IsNullOrEmpty(item.Size) ? string.Empty : "size: " + item.Size) + Environment.NewLine + ", ";
        }
        return cartItemDesc;
    }

    protected void paymentType_SelectedIndexChanged(object sender, EventArgs e)
    {
        string payment = paymentType.SelectedValue;
        var credit = Enum.IsDefined(typeof(StringHelper.CreditCard), payment);
        if (credit)
        {
            //Cart total before handling fee added
            var CartTotal = ShoppingCart.GetInstance().ReturnItemTotal();
            //Handling fee amount
            var fee = 0.02;
            //Credit card add a 2% fee onto their order
            _FeeTotal = CartTotal + (CartTotal * (decimal)fee);

            //Credit cards on installation: 1043836
            _installationId = 1043836;
        }
        else
        {
            //Debit cards on installation: 295654
            _installationId = 295654;
            //No fee applied
        }
    }

    //[WebMethod]
    //[ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    //public static string CardHandlingFee(string payment)
    //{
    //var CardHandlingTotal = ShoppingCart.GetInstance().ReturnItemTotal();
    //var bob = 0.00;
    //if (paymentType == "JCB")
    //{
    //bob = 0.02;
    //CardHandlingTotal += (decimal)bob;
    //debit cards on installation: 295654
    //Credit cards on installation: 1043836
    //installationID = 1043836;
    //}
    //Convert.ToInt32(WebConfigurationManager.AppSettings["InstallationID"]);
    //0.00;
    //return payment;
    //}

    protected decimal ReturnCartTotal()
    {
        var CartTotal = _FeeTotal > 0 ? _FeeTotal : ShoppingCart.GetInstance().ReturnItemTotal();
        //var CartTotal = ShoppingCart.GetInstance().ReturnItemTotal(); //Instance.ReturnItemTotal();
        return CartTotal;
    }


    protected void ProcessTransaction_Click(object sender, EventArgs e)
    {
        //Retrieve the InstallationID, MD5SecretKey and SiteBaseURL values from the web.config
        int installationID = _installationId; //Convert.ToInt32(WebConfigurationManager.AppSettings["InstallationID"]);
        string MD5secretKey = WebConfigurationManager.AppSettings["MD5secretKey"];
        string WebsiteURL = WebConfigurationManager.AppSettings["WebsiteURL"];

        HostedTransactionRequest PRequest = new HostedTransactionRequest();
        PRequest.instId = _installationId == 0 ? Convert.ToInt32(WebConfigurationManager.AppSettings["InstallationID"]) : _installationId;
        //amount - A decimal number giving the cost of the purchase in terms of the major currency unit e.g. 12.56
        PRequest.amount = (double)ReturnCartTotal();  //450.00;
        //cartId - If your system has created a unique order/cart ID, enter it here.
        PRequest.cartId = Guid.NewGuid().ToString();
        //desc - enter the description for this order.
        PRequest.desc = ReturnItemDesc(); //"Test Order from my .net site word";
        //currency - 3 letter ISO code for the currency of this payment.
        PRequest.currency = "GBP";
        //name, address1/2/3, town, region, postcode & country - Billing address fields
        PRequest.name = TxtCustomerName.Text;
        PRequest.address1 = TxtAddress1.Text;
        PRequest.address2 = TxtAddress2.Text;
        PRequest.address3 = TxtAddress3.Text;
        PRequest.town = TxtTown.Text;
        PRequest.region = TxtRegion.Text;
        PRequest.postcode = TxtPostcode.Text;
        PRequest.country = DdlCountry.SelectedValue;
        //tel - Shopper's telephone number
        PRequest.tel = TxtTelephone.Text;
        //fax - Shopper's fax number
        PRequest.fax = TxtFax.Text;
        //email - Shopper's email address
        PRequest.email = TxtEmail.Text;
        //If passing delivery details, set withDelivery = true.
        PRequest.withDelivery = true;
        //delvName, delvAddress1/2/3, delvTown, delvRegion, delvPostcode & delvCountry - Delivery address fields (NOTE: do not need to be passed/set if "withDelivery" set to false.
        PRequest.delvName = TxtdelvName.Text;
        PRequest.delvAddress1 = TxtdelvAddress1.Text;
        PRequest.delvAddress2 = TxtdelvAddress2.Text;
        PRequest.delvAddress3 = TxtdelvAddress3.Text;
        PRequest.delvTown = TxtdelvTown.Text;
        PRequest.delvRegion = TxtdelvRegion.Text;
        PRequest.delvPostcode = TxtdelvPostcode.Text;
        PRequest.delvCountry = DdldelvCountry.SelectedValue;
        //authMode - set to TransactionType.A for Authorise & Capture, set to TransactionType.E for Pre-Auth Only.
        PRequest.authMode = TransactionType.A;
        //testMode - set to 0 for Live Mode, set to 100 for Test Mode.
        PRequest.testMode = 0;
        //hideCurrency - Set to true to hide currency drop down on the hosted payment page.
        PRequest.hideCurrency = true;
        //fixContact - Set to true to stop a shopper from changing their billing/shipping addresses on the hosted payment page.
        PRequest.fixContact = true;
        //hideContact - set to true to hide the billing/shipping address fields on the hosted payment page.
        PRequest.hideContact = false;
        //MC_callback - the URL of the Callback.aspx file. SiteBaseURL is set in the web.config file.
        PRequest.MC_callback = WebsiteURL + "/Callback.aspx";

        HttpContext httpa = default(HttpContext);
        httpa = HttpContext.Current;
        HostedPaymentProcessor process = new HostedPaymentProcessor(httpa);
        process.SubmitTransaction(PRequest, MD5secretKey);
    }
}