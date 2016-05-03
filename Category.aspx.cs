using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Category : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        repProducts.DataBind();
        if (!this.IsPostBack)
        {
            this.GetData();
        }
    }

    protected void repProducts_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if (repProducts.Items.Count < 1)
        {
            if (e.Item.ItemType == ListItemType.Footer)
            {
                Label lblFooter = (Label)e.Item.FindControl("lblEmptyData");
                lblFooter.Visible = true;
            }
        }
    }

    private void GetData()
    {
        DataView dv = (DataView)dsCategory.Select(DataSourceSelectArguments.Empty);
        DataRowView drv = dv[0];

        lblCategory.Text = drv["Category"].ToString();
    }

}