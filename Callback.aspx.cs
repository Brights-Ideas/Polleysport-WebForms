using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Configuration;
using WorldPayDotNet.Hosted;

public partial class Callback : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            //Get callbackPW and MD5secretkey from web.config
            string CallbackPW = WebConfigurationManager.AppSettings["CallbackPW"];
            string MD5secretKey = WebConfigurationManager.AppSettings["MD5secretKey"];

            HttpContext context = HttpContext.Current;
            //CallbackResult - Validates Callback - populated with the post variables sent back to the callback URL.
            CallbackResult CallbackResult = new CallbackResult(context.Request.Form, MD5secretKey, CallbackPW);

            //NOTE: CallbackResult.<parameter> can be used to return individual callback parameters
            // - e.g. CallbackResult.transId, CallbackResult.amount etc.
            // - see http://www.worldpay.com/support/kb/bg/paymentresponse/pr5201.html for a full list of callback parameters.

            //Check returned transaction status
            switch (CallbackResult.transStatus)
            {
                //Y = Successful
                case "Y":
                    //Transaction Successful - Add your code to process a successful transaction here (before the break).

                    //Response.Write("Transaction Successful - Transaction ID: " + CallbackResult.transId);
                    TransMessage.Text = "Transaction Successful - Transaction ID: " + CallbackResult.transId;
                    break;

                //C = Cancelled
                case "C":
                    //Transaction Cancelled - Add your code to process a cancelled transaction here (before the break).

                    Response.Write("Transaction Cancelled.");
                    break;
            }
        }
        catch (Exception ex)
        {
            //Respond with StatusCode 500 - gateway will pick this up and send out an error email with further details.
            Response.StatusCode = 500;
            Response.Write(ex.Message);
        }
    }
}