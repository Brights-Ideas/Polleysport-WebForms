using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Configuration;
using System.Data.SqlClient;

public partial class AdminPages_AdminProductsManagement : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!this.IsPostBack)
            CurrentPage = 0;
        BindPagedDataSource();
    }

    public int CurrentPage
    {
        get
        {
            // look for current page in ViewState
            object o = this.ViewState["_CurrentPage"];
            if (o == null)
                return 0;
            else
                return (int)o;
        }
        set { this.ViewState["_CurrentPage"] = value; }
    }

    private void BindRepeater()
    {
        string constr = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        using (SqlConnection con = new SqlConnection(constr))
        {
            using (SqlCommand cmd = new SqlCommand("Customers_CRUD"))
            {
                cmd.Parameters.AddWithValue("@Action", "SELECT");
                using (SqlDataAdapter sda = new SqlDataAdapter())
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Connection = con;
                    sda.SelectCommand = cmd;
                    using (DataTable dt = new DataTable())
                    {
                        sda.Fill(dt);
                        prodRepeater.DataSource = dt;
                        prodRepeater.DataBind();
                    }
                }
            }
        }
    }

    private void BindPagedDataSource()
    {
        DataSourceSelectArguments arg = new DataSourceSelectArguments();
        DataView dv = (DataView)this.prods.Select(arg);
        PagedDataSource objPds = new PagedDataSource();
        objPds.DataSource = dv;
        objPds.AllowPaging = true;
        objPds.PageSize = 5;
        objPds.CurrentPageIndex = CurrentPage;
        lblCurrentPage.Text = "Page " + (CurrentPage + 1).ToString() + " of "
            + objPds.PageCount.ToString();
        //Enable/Disable Prev and Next buttons 
        btnPrev.Enabled = !objPds.IsFirstPage;
        btnNext.Enabled = !objPds.IsLastPage;
        prodRepeater.DataSource = objPds;
        prodRepeater.DataBind();
        if (objPds.PageCount > 1)
        {
            pnlNavigation.Visible = true;
        }
    }

    public void btnNext_Click(object sender, System.EventArgs e)
    {
        // Set viewstate variable to the next page
        CurrentPage += 1;
        // Reload control
        BindPagedDataSource();
    }

    public void btnPrev_Click(object sender, System.EventArgs e)
    {
        // Set viewstate variable to the previous page
        if (CurrentPage > 0)
            CurrentPage -= 1;
        else
            CurrentPage = 1;
        // Reload control
        BindPagedDataSource();
    }

    protected void OnEdit(object sender, EventArgs e)
    {
        //Find the reference of the Repeater Item.
        RepeaterItem item = (sender as LinkButton).Parent as RepeaterItem;
        this.ToggleElements(item, true);
    }

    protected void OnUpdate(object sender, EventArgs e)
    {
        //Find the reference of the Repeater Item.
        RepeaterItem item = (sender as LinkButton).Parent as RepeaterItem;
        int productId = int.Parse((item.FindControl("lblProductId") as Label).Text);
        string name = (item.FindControl("txtContactName") as TextBox).Text.Trim();
        string country = (item.FindControl("txtCountry") as TextBox).Text.Trim();

        string constr = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        using (SqlConnection con = new SqlConnection(constr))
        {
            using (SqlCommand cmd = new SqlCommand("Products_Update"))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@Action", "UPDATE");
                //cmd.Parameters.AddWithValue("@CustomerId", customerId);
                cmd.Parameters.AddWithValue("@ProductID", productId);
                //cmd.Parameters.AddWithValue("@ProductName" varchar(50),
                //cmd.Parameters.AddWithValue("@brief_description" text,
                //cmd.Parameters.AddWithValue("@ProductDescription" varchar(50),
                //cmd.Parameters.AddWithValue("@ProductPrice" money,
                //cmd.Parameters.AddWithValue("@ProductImageURL" varchar(MAX),
                //cmd.Parameters.AddWithValue("@categoryID" int
                //cmd.Parameters.AddWithValue("@Name", name);
                //cmd.Parameters.AddWithValue("@Country", country);
                cmd.Connection = con;
                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
            }
        }
        this.BindRepeater();
    }

    private void ToggleElements(RepeaterItem item, bool isEdit)
    {
        //Toggle Buttons.
        item.FindControl("lnkEdit").Visible = !isEdit;
        item.FindControl("lnkUpdate").Visible = isEdit;
        //item.FindControl("lnkCancel").Visible = isEdit;
       // item.FindControl("lnkDelete").Visible = !isEdit;

        //Toggle Labels.
        item.FindControl("lblProductName").Visible = !isEdit;
        //item.FindControl("lblCountry").Visible = !isEdit;

        //Toggle TextBoxes.
        item.FindControl("txtContactName").Visible = isEdit;
        //item.FindControl("txtCountry").Visible = isEdit;
    }
}