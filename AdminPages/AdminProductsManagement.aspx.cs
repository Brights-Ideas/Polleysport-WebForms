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
        if (!this.IsPostBack)
        {
            CurrentPage = 0;
        }

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
            //string cmd = "SELECT TOP 3 * FROM Products ORDER BY productID DESC";
            string cmd = "SELECT Products.ProductID, Products.ProductName, Products.ProductDescription, Products.in_stock, Products.ProductPrice, Products.ProductImageUrl, Products.CategoryID, SubCategory.SubCategoryID, Products.enabled FROM Products LEFT JOIN SubCategory ON Products.CategoryID = SubCategory.SubCategoryId ORDER BY Products.productID DESC";
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

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        dt.DefaultView.RowFilter = string.Format("ProductName LIKE '{0}'", txtSearch.Text);
        GridView1.DataBind();
        //BindGrid();
    }

    protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        int index = Convert.ToInt32(e.CommandArgument);
        if (e.CommandName.Equals("detail"))
        {
            int productId = Convert.ToInt32(GridView1.DataKeys[index].Value);//.ToString();
            IEnumerable<DataRow> query = from i in dt.AsEnumerable()
                                         where i.Field<Int32>("ProductID").Equals(productId)
                                         select i;
            DataTable detailTable = query.CopyToDataTable<DataRow>();
            //DetailsView1.DataSource = detailTable;
            //DetailsView1.DataBind();
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
            lblProductID.Text = HttpUtility.HtmlDecode(gvrow.Cells[2].Text).ToString();
            txtprodTitle.Text = HttpUtility.HtmlDecode(gvrow.Cells[3].Text).ToString();
            //txtPopulation.Text = HttpUtility.HtmlDecode(gvrow.Cells[7].Text);
            txtXtext.Text = HttpUtility.HtmlDecode(gvrow.Cells[4].Text);
            txtStock.Text = HttpUtility.HtmlDecode(gvrow.Cells[5].Text);
            txtPrice.Text = HttpUtility.HtmlDecode(gvrow.Cells[6].Text);
            hfImageURL.Value = HttpUtility.HtmlDecode(gvrow.Cells[7].Text);
            ddCatId.SelectedValue = HttpUtility.HtmlDecode(gvrow.Cells[8].Text);
            ddSubCatId.SelectedValue = HttpUtility.HtmlDecode(gvrow.Cells[9].Text);
            rblProductActive.SelectedValue = HttpUtility.HtmlDecode(gvrow.Cells[10].Text);
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
        int productId = Convert.ToInt32(lblProductID.Text);
        string productName = txtprodTitle.Text;
        //int population = Convert.ToInt32( 1);
        string description = txtXtext.Text;
        int stock = Convert.ToInt32(txtStock.Text);
        decimal price = Convert.ToDecimal(txtPrice.Text);
        if (fileUploadImage.HasFile)
        {
            StartUpLoad(fileUploadImage);
        }
        string imageUrl = hfImageURL.Value;
        int categoryId = Convert.ToInt32(ddCatId.SelectedValue);
        int subCategoryId = Convert.ToInt32(ddSubCatId.SelectedValue);
        bool enabled = Convert.ToBoolean(rblProductActive.SelectedValue);
        executeUpdate(productName, description, stock, price, imageUrl, categoryId, subCategoryId, enabled, productId);
        BindGrid();
        System.Text.StringBuilder sb = new System.Text.StringBuilder();
        sb.Append(@"<script type='text/javascript'>");
        sb.Append("alert('Records Updated Successfully');");
        sb.Append("$('#editModal').modal('hide');");
        sb.Append(@"</script>");
        ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "EditHideModalScript", sb.ToString(), false);

    }

    private void executeUpdate(string productName, string description, int stock, decimal price, string imageUrl, int categoryId, int subCategoryId, bool enabled, int productId)
    {
        string connString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        try
        {
            SqlConnection conn = new SqlConnection(connString);
            conn.Open();
            //string updatecmd = "update Products set Population=@population, Name=@countryname,Continent=@continent where Code=@code";
            string updatecmd = "UPDATE Products SET ProductName = @Name, ProductDescription = @Description, in_stock = @Stock, ProductPrice = @Price, ProductImageUrl = @ImageURL, categoryID = @CatId, subCategoryID = @SubCatId WHERE ProductID = @ProductID";
            SqlCommand updateCmd = new SqlCommand(updatecmd, conn);
            updateCmd.Parameters.AddWithValue("@Name", productName);
	        updateCmd.Parameters.AddWithValue("@Description", description);
	        updateCmd.Parameters.AddWithValue("@Stock", stock);
	        updateCmd.Parameters.AddWithValue("@Price", price );
	        //updateCmd.Parameters.AddWithValue("@Shipping money,
	        updateCmd.Parameters.AddWithValue("@ImageURL", imageUrl);
            updateCmd.Parameters.AddWithValue("@CatId", categoryId);
            updateCmd.Parameters.AddWithValue("@SubCatId", subCategoryId);
            updateCmd.Parameters.AddWithValue("@enabled", enabled);

            updateCmd.Parameters.AddWithValue("@ProductID", productId);
	        
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
        string productName = txtProductName.Text;
        string description = txtDescription.Text;
        decimal price = Convert.ToDecimal(txtProductPrice.Text);
        int stock = Convert.ToInt32(txtProductStock.Text);
        if(insertUploadPicture.HasFile)
        {
            StartUpLoad(insertUploadPicture);
        }
        //StartUpLoad();
        string imageUrl = insertUploadPicture.FileName;// StartUpLoad(insertUploadPicture);
        int categoryId = Convert.ToInt32(Category.SelectedValue);
        
        executeAdd(productName, description, price, stock, imageUrl, categoryId);
        BindGrid();
        System.Text.StringBuilder sb = new System.Text.StringBuilder();
        sb.Append(@"<script type='text/javascript'>");
        sb.Append("alert('Record Added Successfully');");
        sb.Append("$('#addModal').modal('hide');");
        sb.Append(@"</script>");
        ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "AddHideModalScript", sb.ToString(), false);


    }

    private void executeAdd(string productName, string description, decimal price, int stock, string imageUrl, int categoryId)
    {
        string connString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        try
        {
            SqlConnection conn = new SqlConnection(connString);
            conn.Open();
            //string updatecmd = "insert into tblCountry (Code,Name,Continent,Region,Population,IndepYear) values (@code,@name,@continent,@region,@population,@indyear)";

            string updatecmd = "INSERT INTO Products (ProductName,ProductDescription,ProductPrice,ProductImageURL,in_stock,categoryID,[enabled]) VALUES (@ProductName, @ProductDescription,@ProductPrice,@ProductImageURL,@in_stock,@CategoryID,1 )";
            SqlCommand addCmd = new SqlCommand(updatecmd, conn);
            //addCmd.Parameters.AddWithValue("@code", code);
            //addCmd.Parameters.AddWithValue("@name", name);
            //addCmd.Parameters.AddWithValue("@continent", continent);
            //addCmd.Parameters.AddWithValue("@region", region);
            //addCmd.Parameters.AddWithValue("@population", population);
            //addCmd.Parameters.AddWithValue("@indyear", indyear);
            addCmd.Parameters.AddWithValue("@ProductName", productName);
            addCmd.Parameters.AddWithValue("@ProductDescription", description);
            addCmd.Parameters.AddWithValue("@ProductPrice", price);
            //addCmd.Parameters.AddWithValue("@ShippingCost money,
            addCmd.Parameters.AddWithValue("@in_stock", stock);
            addCmd.Parameters.AddWithValue("@ProductImageURL", imageUrl);
            addCmd.Parameters.AddWithValue("@CategoryID", categoryId);
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
        string connString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
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

    #endregion

    #region Pagination controls

    protected void OnPageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridView1.PageIndex = e.NewPageIndex;
        GridView1.DataBind();
    }

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
        BindGrid();
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
        BindGrid();
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

    private void StartUpLoad(FileUpload UploadPicture)
    {
        //get the file name of the posted image
        //string imgName = ((FileUpload)GridView1.Controls[0].FindControl("insertUploadPicture")).FileName;
        string imgName = UploadPicture.FileName;

        //get the size in bytes that
        //int imgSize = ((FileUpload)GridView1.Controls[0].FindControl("insertUploadPicture")).PostedFile.ContentLength;
        int imgSize = UploadPicture.PostedFile.ContentLength;

        //validates the posted file before saving
        //if (((FileUpload)GridView1.Controls[0].FindControl("insertUploadPicture")).PostedFile != null && ((FileUpload)GridView1.Controls[0].FindControl("insertUploadPicture")).FileName != "")
        if (UploadPicture.PostedFile != null && imgName != "")
        {
            // 10240 KB means 10MB, You can change the value based on your requirement
            //if (((FileUpload)GridView1.Controls[0].FindControl("insertUploadPicture")).PostedFile.ContentLength > 20240)
            if (imgSize > 20240)
            {
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
                //((FileUpload)GridView1.Controls[0].FindControl("fileUploadImage")).SaveAs(imagePath);
                UploadPicture.SaveAs(imagePath);

                //ImageResizeUtils.ResizeImage(imagePath, 300, 300);
                Page.ClientScript.RegisterClientScriptBlock(typeof(Page), "Alert", "alert('Image saved!')", true);
                //ProductImages/imgName
                //((HiddenField)GridView1.Controls[0].FindControl("hfImageURL")).Value = "ProductImages/" + imgName;
                hfImageURL.Value = "ProductImages/" + imgName;
            }
        }
        //return "ProductImages/" + imgName;
    }

}