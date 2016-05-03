using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;

public partial class Products : System.Web.UI.Page
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

    private void BindPagedDataSource()
    {
        DataSourceSelectArguments arg = new DataSourceSelectArguments();
        DataView dv = (DataView)this.sdsProducts.Select(arg);
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
        rpProducts.DataSource = objPds;
        rpProducts.DataBind();
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
}
