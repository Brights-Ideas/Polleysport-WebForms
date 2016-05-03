using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;

using System.IO;
using System.Text;
using System.Net;

public partial class Checkout : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        
        if (PreviousPage != null)
        {
            Control placeHolder = PreviousPage.Controls[0].FindControl("MainContent");

            DropDownList CustTitle = (DropDownList)placeHolder.FindControl("txtTitle");
            TextBox CustFirstName = (TextBox)placeHolder.FindControl("txtFirstName");
            TextBox CustLastName = (TextBox)placeHolder.FindControl("txtLastName");
            TextBox CustAddress1 = (TextBox)placeHolder.FindControl("txtAdd1");
            TextBox CustAddress2 = (TextBox)placeHolder.FindControl("txtAdd2");
            TextBox CustTown = (TextBox)placeHolder.FindControl("txtTown");
            TextBox CustCounty = (TextBox)placeHolder.FindControl("txtCounty");
            TextBox CustEmail = (TextBox)placeHolder.FindControl("txtCustEmail");
            TextBox CustPostcode = (TextBox)placeHolder.FindControl("txtPostCode");
            TextBox CustDeliveryInstructions = (TextBox)placeHolder.FindControl("txtDelInst");

            if (placeHolder != null)
            {
                //lblTitle.Text = CustTitle.Text;
                //lblFirstName.Text = CustFirstName.Text;
                //lblLastName.Text = CustLastName.Text;
                //lblAdd1.Text = CustAddress1.Text;
                //lblAdd2.Text = CustAddress2.Text;
                //lblTown.Text = CustTown.Text;
                //lblCounty.Text = CustCounty.Text;
                //lblCustEmail.Text = CustEmail.Text;
                //lblPostCode.Text = CustPostcode.Text;
                //lblDelInst.Text = CustDeliveryInstructions.Text;
            }
        }
    }

    #region WorldPay

    ///// <summary>
    ///// Concatenate to product name(s) for each item in the cart
    ///// </summary>
    ///// <returns></returns>
    //public string ReturnItemDesc()
    //{
    //    var cartItemDesc = string.Empty;
    //    foreach (var item in Profile.SCart.Items)
    //    {
    //       cartItemDesc += item.ProductName + ", ";
    //    }
    //    return cartItemDesc;
    //}

    ///// <summary>
    ///// Calculates the cart total
    ///// </summary>
    ///// <returns></returns>
    //public string ReturnItemTotal()
    //{
    //    var cartTotal = new VatRateHelper();
    //    //Net price without VAT = £23.50 divided by 1.175 = £20
    //    //var cartTotal = string.Empty;
    //    //var Vat = double.Parse(ConfigurationManager.AppSettings["VatRate"]);
    //    //cartTotal = string.Format("{0:##0.00}", Profile.SCart.Total * Vat + Profile.SCart.Total);
    //     double cartTotalVAT = cartTotal.ReturnItemTotal(Profile.SCart.Total);

    //     return cartTotalVAT.ToString("0.00");
    //}

    #endregion


    protected void continueToPayment_Click(object sender, EventArgs e)
    {
        

        // Show PayPal button when order details are added to DB
        //paymentPanel.Visible = true;
    
    }
}