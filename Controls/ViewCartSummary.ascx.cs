using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ViewCartSummary : System.Web.UI.UserControl
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
    }

    protected void BindData()
    {
        // Let's give the data to the GridView and let it work!
        // The GridView will take our cart items one by one and use the properties
        // that we declared as column names (DataFields)
        gvShoppingCart.DataSource = ShoppingCart.GetInstance().Items; //.Instance.Items;
        gvShoppingCart.DataBind();
    }

    protected void ShowEmptyData()
    {
        if (gvShoppingCart.Rows.Count == 0)
        {
            lnkCheckout.Visible = false;
            
        }
    }

    protected void gvShoppingCart_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        // If we are binding the footer row, let's add in our total
        if (e.Row.RowType == DataControlRowType.Footer)
        {
            e.Row.Cells[2].Text = "Total: " + ShoppingCart.GetInstance().GetSubTotal().ToString("C"); //.Instance.GetSubTotal().ToString("C");
        }
    }

    /**
     * This is the method that responds to the Remove button's click event
     */
    protected void gvShoppingCart_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        // We now have to re-setup the data so that the GridView doesn't keep
        // displaying the old data
        BindData();
        ShowEmptyData();
    }

    protected void btnUpdateCart_Click(object sender, EventArgs e)
    {

        BindData();
    }

}