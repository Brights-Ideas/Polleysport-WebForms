using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Mime;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Configuration;
using System.Data.SqlClient;

public partial class AdminPages_AdminProductsManagement : System.Web.UI.Page
{
    DataTable dt;

    protected void Page_Load(object sender, EventArgs e)
    {
        //if (!this.IsPostBack)
        //{
        //    CurrentPage = 0;
        //}
        //BindPagedDataSource();
        BindGrid();
    }

    #region Admin CRUD Grid
    public void BindGrid()
    {
        try
        {
            //Fetch data from mysql database
            string connString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            SqlConnection conn = new SqlConnection(connString);
            conn.Open();
            string cmd = "select * from products";
            SqlDataAdapter dAdapter = new SqlDataAdapter(cmd, conn);
            DataSet ds = new DataSet();
            dAdapter.Fill(ds);
            dt = ds.Tables[0];
            //Bind the fetched data to gridview
            GridView1.DataSource = dt;
            GridView1.DataBind();

        }
        catch (SqlException ex)
        {
            System.Console.Error.Write(ex.Message);

        }

    }

    protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        int index = Convert.ToInt32(e.CommandArgument);
        if (e.CommandName.Equals("detail"))
        {
            string code = GridView1.DataKeys[index].Value.ToString();
            IEnumerable<DataRow> query = from i in dt.AsEnumerable()
                                         where i.Field<String>("Code").Equals(code)
                                         select i;
            DataTable detailTable = query.CopyToDataTable<DataRow>();
            DetailsView1.DataSource = detailTable;
            DetailsView1.DataBind();
            System.Text.StringBuilder sb = new System.Text.StringBuilder();
            sb.Append(@"<script type='text/javascript'>");
            sb.Append("$('#detailModal').modal('show');");
            sb.Append(@"</script>");
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "DetailModalScript", sb.ToString(), false);
        }
        else if (e.CommandName.Equals("editRecord"))
        {
            GridViewRow gvrow = GridView1.Rows[index];
            //lblCountryCode.Text = HttpUtility.HtmlDecode(gvrow.Cells[3].Text).ToString();
            txtprodTitle.Text = HttpUtility.HtmlDecode(gvrow.Cells[3].Text).ToString();
            //txtPopulation.Text = HttpUtility.HtmlDecode(gvrow.Cells[7].Text);
            txtXtext.Text = HttpUtility.HtmlDecode(gvrow.Cells[4].Text);
            txtPrice.Text = HttpUtility.HtmlDecode(gvrow.Cells[5].Text);
            lblResult.Visible = false;
            System.Text.StringBuilder sb = new System.Text.StringBuilder();
            sb.Append(@"<script type='text/javascript'>");
            sb.Append("$('#editModal').modal('show');");
            sb.Append(@"</script>");
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "EditModalScript", sb.ToString(), false);

        }
        else if (e.CommandName.Equals("deleteRecord"))
        {
            string code = GridView1.DataKeys[index].Value.ToString();
            hfCode.Value = code;
            System.Text.StringBuilder sb = new System.Text.StringBuilder();
            sb.Append(@"<script type='text/javascript'>");
            sb.Append("$('#deleteModal').modal('show');");
            sb.Append(@"</script>");
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "DeleteModalScript", sb.ToString(), false);
        }

    }


    protected void btnSave_Click(object sender, EventArgs e)
    {
        string code = txtprodTitle.Text;
        int population = Convert.ToInt32( 1);
        string countryname = txtXtext.Text;
        string continent = txtPrice.Text;
        executeUpdate(code, population, countryname, continent);
        BindGrid();
        System.Text.StringBuilder sb = new System.Text.StringBuilder();
        sb.Append(@"<script type='text/javascript'>");
        sb.Append("alert('Records Updated Successfully');");
        sb.Append("$('#editModal').modal('hide');");
        sb.Append(@"</script>");
        ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "EditHideModalScript", sb.ToString(), false);

    }

    private void executeUpdate(string code, int population, string countryname, string continent)
    {
        string connString = ConfigurationManager.ConnectionStrings["MySqlConnString"].ConnectionString;
        try
        {
            SqlConnection conn = new SqlConnection(connString);
            conn.Open();
            string updatecmd = "update tblCountry set Population=@population, Name=@countryname,Continent=@continent where Code=@code";
            SqlCommand updateCmd = new SqlCommand(updatecmd, conn);
            updateCmd.Parameters.AddWithValue("@population", population);
            updateCmd.Parameters.AddWithValue("@countryname", countryname);
            updateCmd.Parameters.AddWithValue("@continent", continent);
            updateCmd.Parameters.AddWithValue("@code", code);
            updateCmd.ExecuteNonQuery();
            conn.Close();

        }
        catch (SqlException me)
        {
            System.Console.Error.Write(me.InnerException.Data);
        }
    }

    protected void btnAdd_Click(object sender, EventArgs e)
    {
        System.Text.StringBuilder sb = new System.Text.StringBuilder();
        sb.Append(@"<script type='text/javascript'>");
        sb.Append("$('#addModal').modal('show');");
        sb.Append(@"</script>");
        ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "AddShowModalScript", sb.ToString(), false);

    }

    protected void btnAddRecord_Click(object sender, EventArgs e)
    {
        string code = txtCode.Text;
        string name = txtCountryName.Text;
        string region = txtRegion.Text;
        string continent = txtContinent.Text;
        int population = Convert.ToInt32(txtTotalPopulation.Text);
        int indyear = Convert.ToInt32(txtIndYear.Text);
        executeAdd(code, name, continent, region, population, indyear);
        BindGrid();
        System.Text.StringBuilder sb = new System.Text.StringBuilder();
        sb.Append(@"<script type='text/javascript'>");
        sb.Append("alert('Record Added Successfully');");
        sb.Append("$('#addModal').modal('hide');");
        sb.Append(@"</script>");
        ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "AddHideModalScript", sb.ToString(), false);


    }

    private void executeAdd(string code, string name, string continent, string region, int population, int indyear)
    {
        string connString = ConfigurationManager.ConnectionStrings["MySqlConnString"].ConnectionString;
        try
        {
            SqlConnection conn = new SqlConnection(connString);
            conn.Open();
            string updatecmd = "insert into tblCountry (Code,Name,Continent,Region,Population,IndepYear) values (@code,@name,@continent,@region,@population,@indyear)";
            SqlCommand addCmd = new SqlCommand(updatecmd, conn);
            addCmd.Parameters.AddWithValue("@code", code);
            addCmd.Parameters.AddWithValue("@name", name);
            addCmd.Parameters.AddWithValue("@continent", continent);
            addCmd.Parameters.AddWithValue("@region", region);
            addCmd.Parameters.AddWithValue("@population", population);
            addCmd.Parameters.AddWithValue("@indyear", indyear);
            addCmd.ExecuteNonQuery();
            conn.Close();

        }
        catch (SqlException me)
        {
            System.Console.Write(me.Message);
        }
    }

    protected void btnDelete_Click(object sender, EventArgs e)
    {
        string code = hfCode.Value;
        executeDelete(code);
        BindGrid();
        System.Text.StringBuilder sb = new System.Text.StringBuilder();
        sb.Append(@"<script type='text/javascript'>");
        sb.Append("alert('Record deleted Successfully');");
        sb.Append("$('#deleteModal').modal('hide');");
        sb.Append(@"</script>");
        ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "delHideModalScript", sb.ToString(), false);


    }

    private void executeDelete(string code)
    {
        string connString = ConfigurationManager.ConnectionStrings["MySqlConnString"].ConnectionString;
        try
        {
            SqlConnection conn = new SqlConnection(connString);
            conn.Open();
            string updatecmd = "delete from tblCountry where Code=@code";
            SqlCommand addCmd = new SqlCommand(updatecmd, conn);
            addCmd.Parameters.AddWithValue("@code", code);
            addCmd.ExecuteNonQuery();
            conn.Close();

        }
        catch (SqlException me)
        {
            System.Console.Write(me.Message);
        }

    }
    //public void BindGrid()
    //{
    //    try
    //    {
    //        //Fetch data from mysql database
    //        var connString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
    //        var conn = new SqlConnection(connString);
    //        conn.Open();
    //        const string cmd = "select * from Products";
    //        var dAdapter = new SqlDataAdapter(cmd, conn);
    //        var ds = new DataSet();
    //        dAdapter.Fill(ds);
    //        dt = ds.Tables[0];
    //        //Bind the fetched data to gridview
    //        GridView1.DataSource = dt;
    //        GridView1.DataBind();

    //    }
    //    catch (SqlException ex)
    //    {
    //        Console.Error.Write(ex.Message);

    //    }

    //}

    //protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
    //{
    //    int index = Convert.ToInt32(e.CommandArgument);
    //    if (e.CommandName.Equals("detail"))
    //    {
    //        //string code = GridView1.DataKeys[index].Value.ToString();
    //        string productID = GridView1.DataKeys[index].Value.ToString();
    //        IEnumerable<DataRow> query = from i in dt.AsEnumerable()
    //                                     where i.Field<String>("ProductID").Equals(productID)
    //                                     select i;
    //        DataTable detailTable = query.CopyToDataTable<DataRow>();
    //        DetailsView1.DataSource = detailTable;
    //        DetailsView1.DataBind();
    //        var sb = new System.Text.StringBuilder();
    //        sb.Append(@"<script type='text/javascript'>");
    //        sb.Append("$('#detailModal').modal('show');");
    //        sb.Append(@"</script>");
    //        ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "DetailModalScript", sb.ToString(), false);
    //    }
    //    else if (e.CommandName.Equals("editRecord"))
    //    {
    //        GridViewRow gvrow = GridView1.Rows[index];
    //        //lblCountryCode.Text = HttpUtility.HtmlDecode(gvrow.Cells[3].Text).ToString();
    //        txtprodTitle.Text = HttpUtility.HtmlDecode(gvrow.Cells[3].Text).ToString();
    //        //txtPopulation.Text = HttpUtility.HtmlDecode(gvrow.Cells[7].Text);
    //        txtXtext.Text = HttpUtility.HtmlDecode(gvrow.Cells[7].Text);
    //        txtStock.Text = HttpUtility.HtmlDecode(gvrow.Cells[4].Text);
    //        txtPrice.Text = HttpUtility.HtmlDecode(gvrow.Cells[5].Text);
    //        lblResult.Visible = false;
    //        var sb = new System.Text.StringBuilder();
    //        sb.Append(@"<script type='text/javascript'>");
    //        sb.Append("$('#editModal').modal('show');");
    //        sb.Append(@"</script>");
    //        ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "EditModalScript", sb.ToString(), false);

    //    }
    //    else if (e.CommandName.Equals("deleteRecord"))
    //    {
    //        string productID = GridView1.DataKeys[index].Value.ToString();
    //        //hfCode.Value = code;
    //        hdn_prod.Value = productID;
    //        var sb = new System.Text.StringBuilder();
    //        sb.Append(@"<script type='text/javascript'>");
    //        sb.Append("$('#deleteModal').modal('show');");
    //        sb.Append(@"</script>");
    //        ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "DeleteModalScript", sb.ToString(), false);
    //    }

    //}

    //protected void btnSave_Click(object sender, EventArgs e)
    //{
    //    //string code = lblCountryCode.Text;
    //    //int population = Convert.ToInt32(txtPopulation.Text);
    //    //string countryname = txtName.Text;
    //    //string continent = txtContinent1.Text;

    //    string Name = txtprodTitle.Text;
    //    string Description = txtXtext.Text;
    //    int Stock = Convert.ToInt32(txtStock.Text);
    //    decimal Price = Convert.ToDecimal(txtPrice.Text);
    //    decimal Shipping = Convert.ToDecimal(txtSHP.Text);
    //    string ImageUrl = hfImageURL.Value;
    //    int CategoryID = Convert.ToInt32(ddCatId.SelectedValue);
    //    decimal SizePrice = Convert.ToDecimal(txtSizePrice.Text);

    //    int ProductID = Convert.ToInt32(hdn_prod.Value);
        
    //    executeUpdate(ProductID, Name, Description, Stock, Price, Shipping, ImageUrl, CategoryID, SizePrice);
    //    BindGrid();
    //    var sb = new System.Text.StringBuilder();
    //    sb.Append(@"<script type='text/javascript'>");
    //    sb.Append("alert('Records Updated Successfully');");
    //    sb.Append("$('#editModal').modal('hide');");
    //    sb.Append(@"</script>");
    //    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "EditHideModalScript", sb.ToString(), false);

    //}

    //private void executeUpdate(int ProductID, string Name, string Description, int Stock, decimal Price, decimal Shipping, string ImageUrl, int CategoryID, decimal SizePrice)
    //{
    //    string connString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
    //    try
    //    {
    //        var conn = new SqlConnection(connString);
    //        conn.Open();
    //        string updatecmd = "UPDATE Products SET ProductName=@Name, " +
    //                           "ProductDescription=@Description," +
    //                           "in_stock=@Stock," +
    //                           "ProductPrice=@Price," +
    //                           "ShippingCost=@Shipping," +
    //                           "ProductImageUrl=@ImageURL," +
    //                           "categoryID=@CatId" +
    //                           "WHERE ProductID=@ProductID";
    //        var updateCmd = new SqlCommand(updatecmd, conn);
    //        updateCmd.Parameters.AddWithValue("@Name", Name);
    //        updateCmd.Parameters.AddWithValue("@Description", Description);
    //        updateCmd.Parameters.AddWithValue("@Stock", Stock);
    //        updateCmd.Parameters.AddWithValue("@Price", Price);
    //        updateCmd.Parameters.AddWithValue("@Shipping", Shipping);
    //        updateCmd.Parameters.AddWithValue("@ImageURL", ImageUrl);
    //        updateCmd.Parameters.AddWithValue("@CatId", CategoryID);
    //        updateCmd.Parameters.AddWithValue("@ProductID", ProductID);

    //        updateCmd.Parameters.AddWithValue("@SizePrice", SizePrice);
    //        //updateCmd.Parameters.AddWithValue("@Id", int
    //        //updateCmd.Parameters.AddWithValue("@population", population);
    //        //updateCmd.Parameters.AddWithValue("@countryname", countryname);
    //        //updateCmd.Parameters.AddWithValue("@continent", continent);
    //        //updateCmd.Parameters.AddWithValue("@ProductID", ProductID);
    //        updateCmd.ExecuteNonQuery();
    //        conn.Close();

    //    }
    //    catch (SqlException me)
    //    {
    //        Console.Error.Write(me.InnerException.Data);
    //    }
    //}

    //protected void btnAdd_Click(object sender, EventArgs e)
    //{
    //    var sb = new System.Text.StringBuilder();
    //    sb.Append(@"<script type='text/javascript'>");
    //    sb.Append("$('#addModal').modal('show');");
    //    sb.Append(@"</script>");
    //    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "AddShowModalScript", sb.ToString(), false);

    //}

    //protected void btnAddRecord_Click(object sender, EventArgs e)
    //{
    //    //string code = txtCode.Text;
    //    string Name = txtprodTitle.Text;
    //    string description = txtXtext.Text;
    //    decimal price = Convert.ToDecimal(txtPrice.Text);
    //    decimal shipping = Convert.ToDecimal(txtSHP.Text);
    //    int stock = Convert.ToInt32(txtStock.Text);
    //    string imageUrl = hfImageURL.Value;
    //    int categoryID = 1;
    //    //string continent = txtContinent.Text;
    //    //int population = Convert.ToInt32(txtTotalPopulation.Text);
    //    //int indyear = Convert.ToInt32(txtIndYear.Text);
    //    executeAdd(Name, description, price, shipping, stock, imageUrl, categoryID);
    //    BindGrid();
    //    var sb = new System.Text.StringBuilder();
    //    sb.Append(@"<script type='text/javascript'>");
    //    sb.Append("alert('Record Added Successfully');");
    //    sb.Append("$('#addModal').modal('hide');");
    //    sb.Append(@"</script>");
    //    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "AddHideModalScript", sb.ToString(), false);


    //}

    //private void executeAdd(string Name, string description, decimal price, decimal shipping, int stock, string imageUrl, int categoryID)
    //{
    //    string connString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
    //    try
    //    {
    //        SqlConnection conn = new SqlConnection(connString);
    //        conn.Open();
    //        string updatecmd = "insert into Products (ProductName,ProductDescription,Price,Population,IndepYear) " +
    //                           "values " +
    //                           "(@Name,@Description,@Price,@population,@indyear)";
    //        SqlCommand addCmd = new SqlCommand(updatecmd, conn);
    //        //addCmd.Parameters.AddWithValue("@code", code);
    //        addCmd.Parameters.AddWithValue("@Name", Name);
    //        addCmd.Parameters.AddWithValue("@Description", description);
    //        addCmd.Parameters.AddWithValue("@Price", price);
    //        addCmd.Parameters.AddWithValue("@ProductImageURL", imageUrl);
    //        addCmd.Parameters.AddWithValue("@in_stock", stock);
    //        addCmd.ExecuteNonQuery();
    //        conn.Close();

    //    }
    //    catch (SqlException me)
    //    {
    //        Console.Write(me.Message);
    //    }
    //}

    //protected void btnDelete_Click(object sender, EventArgs e)
    //{
    //    string code = hfCode.Value;
    //    executeDelete(code);
    //    BindGrid();
    //    var sb = new System.Text.StringBuilder();
    //    sb.Append(@"<script type='text/javascript'>");
    //    sb.Append("alert('Record deleted Successfully');");
    //    sb.Append("$('#deleteModal').modal('hide');");
    //    sb.Append(@"</script>");
    //    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "delHideModalScript", sb.ToString(), false);


    //}

    //private void executeDelete(string code)
    //{
    //    string connString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
    //    try
    //    {
    //        SqlConnection conn = new SqlConnection(connString);
    //        conn.Open();
    //        string updatecmd = "delete from tblCountry where Code=@code";
    //        SqlCommand addCmd = new SqlCommand(updatecmd, conn);
    //        addCmd.Parameters.AddWithValue("@code", code);
    //        addCmd.ExecuteNonQuery();
    //        conn.Close();

    //    }
    //    catch (SqlException me)
    //    {
    //        System.Console.Write(me.Message);
    //    }

    //}

    #endregion

    #region Pagination controls
    public int CurrentPage
    {
        get
        {
            // look for current page in ViewState
            object o = ViewState["_CurrentPage"];
            if (o == null)
                return 0;
            return (int)o;
        }
        set { ViewState["_CurrentPage"] = value; }
    }

    public void btnNext_Click(object sender, System.EventArgs e)
    {
        // Set viewstate variable to the next page
        CurrentPage += 1;
        // Reload control
        //BindPagedDataSource();
    }

    public void btnPrev_Click(object sender, System.EventArgs e)
    {
        // Set viewstate variable to the previous page
        if (CurrentPage > 0)
            CurrentPage -= 1;
        else
            CurrentPage = 1;
        // Reload control
        //BindPagedDataSource();
    }
    #endregion

    protected void DropDownSize_SelectedIndexChanged(object sender, EventArgs e)
    {
        var id = int.Parse(((DropDownList)GridView1.Controls[0].FindControl("DropDownSize")).SelectedValue);
        // update the price depending on the size selected from the drop down list
        //txtSizePrice.Text = GetPrice(id);
    }

    /// <summary>
    /// Updates the product price according to the size selected
    /// </summary>
    /// <param name="sizeId"></param>
    /// <returns></returns>
    protected string GetPrice(int sizeId)
    {
        string outcomeMessage;
        try
        {
            decimal returnValue;
            using (var sqlConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
            {
                using (var sqlCommand = new SqlCommand("Product_Attributes_Prices", sqlConnection))
                {
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    sqlConnection.Open();

                    sqlCommand.Parameters.Clear();
                    sqlCommand.Parameters.AddWithValue("@Id", sizeId);

                    returnValue = (decimal)sqlCommand.ExecuteScalar();

                    sqlConnection.Close();
                }
            }
            return returnValue.ToString("#0.00");
        }
        catch (Exception ex)
        {
            outcomeMessage = "<b>Error occured while updating." + ex.StackTrace + " + </b>";
        }

        return outcomeMessage;
    }

    private void StartUpLoad()
    {
        //get the file name of the posted image
        string imgName = ((FileUpload)GridView1.Controls[0].FindControl("uploadPicture")).FileName; //uploadPicture.FileName;

        //get the size in bytes that
        int imgSize = ((FileUpload)GridView1.Controls[0].FindControl("uploadPicture")).PostedFile.ContentLength; //uploadPicture.PostedFile.ContentLength;

        //validates the posted file before saving
        if (((FileUpload)GridView1.Controls[0].FindControl("uploadPicture")).PostedFile != null && ((FileUpload)GridView1.Controls[0].FindControl("uploadPicture")).FileName != "")
        {
            //if (FileUpload1.PostedFile != null && FileUpload1.PostedFile.FileName != "") {
            // 10240 KB means 10MB, You can change the value based on your requirement
            if (((FileUpload)GridView1.Controls[0].FindControl("uploadPicture")).PostedFile.ContentLength > 20240)
            {
                //if 
                //FilenameDetails.InnerHtml = "File is too big";
                //message.Text
                Page.ClientScript.RegisterClientScriptBlock(typeof(Page), "Alert", "alert('File is too big.')", true);

            }
            else
            {

                //For live
                string imagePath = Server.MapPath("~/ProductImages/");
                imagePath = imagePath + @"\" + imgName;

                //For testing
                //string imagePath = ConfigurationManager.AppSettings["UploadPath"] + imgName;

                //then save it to the Folder
                ((FileUpload)GridView1.Controls[0].FindControl("uploadPicture")).SaveAs(imagePath);

                ImageResizeUtils.ResizeImage(imagePath, 300, 300);
                Page.ClientScript.RegisterClientScriptBlock(typeof(Page), "Alert", "alert('Image saved!')", true);
                //ProductImages/imgName
                ((HiddenField)GridView1.Controls[0].FindControl("hfImageURL")).Value = "ProductImages/" + imgName;
            }
        }

    }

    //private void BindRepeater()
    //{
    //    string constr = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
    //    using (SqlConnection con = new SqlConnection(constr))
    //    {
    //        using (SqlCommand cmd = new SqlCommand("Customers_CRUD"))
    //        {
    //            cmd.Parameters.AddWithValue("@Action", "SELECT");
    //            using (SqlDataAdapter sda = new SqlDataAdapter())
    //            {
    //                cmd.CommandType = CommandType.StoredProcedure;
    //                cmd.Connection = con;
    //                sda.SelectCommand = cmd;
    //                using (DataTable dt = new DataTable())
    //                {
    //                    sda.Fill(dt);
    //                    prodRepeater.DataSource = dt;
    //                    prodRepeater.DataBind();
    //                }
    //            }
    //        }
    //    }
    //}

    //private void BindPagedDataSource()
    //{
    //    DataSourceSelectArguments arg = new DataSourceSelectArguments();
    //    DataView dv = (DataView)this.prods.Select(arg);
    //    PagedDataSource objPds = new PagedDataSource();
    //    objPds.DataSource = dv;
    //    objPds.AllowPaging = true;
    //    objPds.PageSize = 5;
    //    objPds.CurrentPageIndex = CurrentPage;
    //    lblCurrentPage.Text = "Page " + (CurrentPage + 1).ToString() + " of "
    //        + objPds.PageCount.ToString();
    //    //Enable/Disable Prev and Next buttons 
    //    btnPrev.Enabled = !objPds.IsFirstPage;
    //    btnNext.Enabled = !objPds.IsLastPage;
    //    prodRepeater.DataSource = objPds;
    //    prodRepeater.DataBind();
    //    if (objPds.PageCount > 1)
    //    {
    //        pnlNavigation.Visible = true;
    //    }
    //}

    //protected void OnEdit(object sender, EventArgs e)
    //{
    //    //Find the reference of the Repeater Item.
    //    var item = (sender as LinkButton).Parent as RepeaterItem;
    //    this.ToggleElements(item, true);
    //}

    //protected void OnUpdate(object sender, EventArgs e)
    //{
    //    //Find the reference of the Repeater Item.
    //    RepeaterItem item = (sender as LinkButton).Parent as RepeaterItem;
    //    int productId = int.Parse((item.FindControl("lblProductId") as Label).Text);
    //    string name = (item.FindControl("txtContactName") as TextBox).Text.Trim();
    //    string country = (item.FindControl("txtCountry") as TextBox).Text.Trim();

    //    string constr = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
    //    using (SqlConnection con = new SqlConnection(constr))
    //    {
    //        using (SqlCommand cmd = new SqlCommand("Products_Update"))
    //        {
    //            cmd.CommandType = CommandType.StoredProcedure;
    //            cmd.Parameters.AddWithValue("@Action", "UPDATE");
    //            //cmd.Parameters.AddWithValue("@CustomerId", customerId);
    //            cmd.Parameters.AddWithValue("@ProductID", productId);
    //            //cmd.Parameters.AddWithValue("@ProductName" varchar(50),
    //            //cmd.Parameters.AddWithValue("@brief_description" text,
    //            //cmd.Parameters.AddWithValue("@ProductDescription" varchar(50),
    //            //cmd.Parameters.AddWithValue("@ProductPrice" money,
    //            //cmd.Parameters.AddWithValue("@ProductImageURL" varchar(MAX),
    //            //cmd.Parameters.AddWithValue("@categoryID" int
    //            //cmd.Parameters.AddWithValue("@Name", name);
    //            //cmd.Parameters.AddWithValue("@Country", country);
    //            cmd.Connection = con;
    //            con.Open();
    //            cmd.ExecuteNonQuery();
    //            con.Close();
    //        }
    //    }
    //    //this.BindRepeater();
    //}

    //private void ToggleElements(RepeaterItem item, bool isEdit)
    //{
    //    //Toggle Buttons.
    //    item.FindControl("lnkEdit").Visible = !isEdit;
    //    item.FindControl("lnkUpdate").Visible = isEdit;
    //    //item.FindControl("lnkCancel").Visible = isEdit;
    //   // item.FindControl("lnkDelete").Visible = !isEdit;

    //    //Toggle Labels.
    //    item.FindControl("lblProductName").Visible = !isEdit;
    //    //item.FindControl("lblCountry").Visible = !isEdit;

    //    //Toggle TextBoxes.
    //    item.FindControl("txtContactName").Visible = isEdit;
    //    //item.FindControl("txtCountry").Visible = isEdit;
    //}
}