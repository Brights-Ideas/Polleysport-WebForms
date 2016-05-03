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

public partial class ProductDetails : System.Web.UI.Page
{
   

    protected void Page_Load(object sender, EventArgs e)
    {
        Control placeHolder = Controls[0].FindControl("MainContent");
        

        var ddlSizeControl = fvProductsDetails.Controls[0].FindControl("DropDownSize") as DropDownList;
        var lblSizeControl = fvProductsDetails.Controls[0].FindControl("SizeLabel") as Label;

        // Hide size drop down list for products where size variations arent avialable
        if (ddlSizeControl != null)
        {
            if (ddlSizeControl.SelectedIndex != -1) //SelectedValue.Equals("-1"))
            {
                ddlSizeControl.Visible = true;
                lblSizeControl.Visible = true;
                //DropDownSize();
            }
            else
            {
                ddlSizeControl.Visible = false;
                lblSizeControl.Visible = false;
            }
        }
        
    }

    /// <summary>
    /// Send product details to the cart
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void AddToCart_Click(object sender, EventArgs e)
    {
        decimal Price = decimal.Parse(((Label)fvProductsDetails.Controls[0].FindControl("PriceLabel")).Text);
        string ProductName = ((Literal)fvProductsDetails.Controls[0].FindControl("NameLabel")).Text;
        string ProductImageUrl = ((Image)fvProductsDetails.Controls[0].FindControl("Image1")).ImageUrl;
        int ProductQuantity = int.Parse(((TextBox)fvProductsDetails.Controls[0].FindControl("txtQuantity")).Text);
        int ProductID = int.Parse(Request.QueryString["ProductID"]);
        //int SizeID = int.Parse(((DropDownList)fvProductsDetails.Controls[0].FindControl("DropDownSize")).SelectedValue);

        //protected void DropDownSize()
        //{
        // varibles to be set if the drop down list is available
        int ddlSize = 0;
        string txtSizeDescription = string.Empty;
        var ddlSizeControl = fvProductsDetails.Controls[0].FindControl("DropDownSize") as DropDownList;

        //Check to see if the dropdown values are available
        if (ddlSizeControl.Visible && ddlSizeControl.SelectedIndex != -1)
        {
            ddlSize = int.Parse(ddlSizeControl.SelectedValue);
            txtSizeDescription = ddlSizeControl.SelectedItem.Text;
        }

        // variable to hold the selected size details
        int Size = 0;
        string SizeDescription = string.Empty;

        if (ddlSize != 0 && txtSizeDescription != null)
        {
            Size = ddlSize;
            SizeDescription = txtSizeDescription;
        }
        //}

        // Add items to the shopping cart
        ShoppingCart.GetInstance().AddItem(ProductID, Price, SizeDescription, ProductQuantity, Size); //.Instance.AddItem(ProductID, Price, SizeDescription, ProductQuantity, Size);
        //if(ProductQuantity > 1) ShoppingCart.Instance.SetItemQuantity(ProductID, ProductQuantity);
        //if() ShoppingCart.Instance.SetItemSize(ProductID, SizeID);
        //Response.Redirect("ProductDetails.aspx?ProductID=" + ProductID);
        Response.Redirect("Checkout.aspx");
        //Server.Transfer("ProductDetails.aspx?ProductID=" + ProductID);
    }

    protected void DropDownSize_SelectedIndexChanged(object sender, EventArgs e)
    { 
        int Id = int.Parse(((DropDownList)fvProductsDetails.Controls[0].FindControl("DropDownSize")).SelectedValue);
        // update the price depending on the size selected from the drop down list
        PriceLabel.Text = GetPrice(Id);
    }

    /// <summary>
    /// Updates the product price according to the size selected
    /// </summary>
    /// <param name="sizeId"></param>
    /// <returns></returns>
    protected string GetPrice(int sizeId)
    {
        decimal returnValue;
        string outcomeMessage;
        try
        {
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
}
