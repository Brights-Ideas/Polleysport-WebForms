using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

public partial class CartControl : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        // ASP.NET keeps track of the state of all server controls
        // (like the GridView).  Because of this, we don't need to supply it with
        // the data every time the page loads.  (No more re-checking checkboxes
        // that were checked or re-selecting the right item in the drop-down when
        // the page is submitted.  It's all done for you!)
        if (!IsPostBack)
        {
            BindData();
            
            ShowEmptyData();
        }
        if (gvShoppingCart.DataSource != null)
        PriceData();
    }

    protected void BindData()
    {
        // Let's give the data to the GridView and let it work!
        // The GridView will take our cart items one by one and use the properties
        // that we declared as column names (DataFields)
        gvShoppingCart.DataSource = ShoppingCart.GetInstance().Items; //Instance.Items;
        gvShoppingCart.DataBind();
    }

    protected void ShowEmptyData()
    {
        if (gvShoppingCart.Rows.Count == 0)
        {
            plnCosts.Visible = false;
            //btnUpdateCart.Visible = false;
            plnProcess.Visible = false;
        }
    }

    protected void PriceData()
    {
        VatTotal.Text = "<strong>VAT:</strong> " + ShoppingCart.GetInstance().ReturnItemVatTotal().ToString("C"); //Instance.ReturnItemVatTotal().ToString("C");
        Shipping.Text = "<strong>Delivery:</strong> " + ShoppingCart.GetInstance().GetShippingCosts().ToString("C"); //.Instance.GetShippingCosts().ToString("C");
        Total.Text = "<strong>Total:</strong> " + ShoppingCart.GetInstance().ReturnItemTotal().ToString("C"); //.Instance.ReturnItemTotal().ToString("C");
    }

    protected void gvShoppingCart_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        // If we are binding the footer row, let's add in our total
        if (e.Row.RowType == DataControlRowType.Footer)
        {
            e.Row.Cells[3].Text = "<strong>Sub Total:</strong> " + ShoppingCart.GetInstance().GetSubTotal().ToString("C"); //.Instance.GetSubTotal().ToString("C");
        }
    }

    /**
     * This is the method that responds to the Remove button's click event
     */
    protected void gvShoppingCart_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "Remove")
        {
            string[] arg = new string[2];
            arg = e.CommandArgument.ToString().Split(';');

            int productId = Convert.ToInt32(arg[0]); //Convert.ToInt32(e.CommandArgument);
            int sizeId = Convert.ToInt32(arg[1]); //146;
            ShoppingCart.GetInstance().RemoveItem(productId, sizeId); //.Instance.RemoveItem(productId, sizeId);
        }

        // We now have to re-setup the data so that the GridView doesn't keep
        // displaying the old data
        BindData();
        PriceData();
        ShowEmptyData();
    }

    protected void btnUpdateCart_Click(object sender, EventArgs e)
    {
        foreach (GridViewRow row in gvShoppingCart.Rows)
        {
            if (row.RowType == DataControlRowType.DataRow)
            {
                // We'll use a try catch block in case something other than a number is typed in
                // If so, we'll just ignore it.
                try
                {
                    // Get the productId from the GridView's datakeys
                    int productId = Convert.ToInt32(gvShoppingCart.DataKeys[row.RowIndex].Value);
                    // Find the quantity TextBox and retrieve the value
                    int quantity = int.Parse(((TextBox)row.Cells[1].FindControl("txtQuantity")).Text);
                    // Get the sizeId from the GridView's datakeys
                    //int sizeId = Convert.ToInt32(gvShoppingCart.DataKeys[row.RowIndex].Value);
                    int sizeId = int.Parse(((Label)row.Cells[1].FindControl("lblSizeId")).Text);
                        //Convert.ToInt32(gvShoppingCart.DataKeys[row.RowIndex].Value);
                    ShoppingCart.GetInstance().SetItemQuantity(productId, quantity, sizeId); //.Instance.SetItemQuantity(productId, quantity, sizeId);
                }
                catch (FormatException) { }
            }
        }

        BindData();
        PriceData();
    }

}
