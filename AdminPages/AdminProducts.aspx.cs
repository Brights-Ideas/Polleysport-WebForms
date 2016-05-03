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
using System.IO;

using System.Collections.Generic;
using System.Data.SqlClient;
using System.Drawing;
using System.Drawing.Imaging;

public partial class AdminPages_AdminProducts : System.Web.UI.Page
{

    protected void Page_Load(object sender, EventArgs e)
    {
        //if (!IsPostBack)
            remProducts.DataBind();
            
        /*Control placeHolder = Controls[0].FindControl("ContentBody");

        DropDownList ddlSizeControl = fvProducts.Controls[0].FindControl("DropDownSize") as DropDownList;
        var lblSizeControl = fvProducts.Controls[0].FindControl("lblSize") as Label;

        var txtSizePriceControl = fvProducts.Controls[0].FindControl("txtSizePrice") as TextBox;
        var lblSizePriceControl = fvProducts.Controls[0].FindControl("lblSizePrice") as Label;
        */
    }

    protected void fvProducts_DataBound(object sender, EventArgs e)
    {
        if (fvProducts.CurrentMode == FormViewMode.ReadOnly)
        {
            fvProducts.HeaderText = "Read-Only Mode";
            fvProducts.HeaderStyle.BackColor = System.Drawing.Color.Green;
            // here you can safely access the FormView's ItemTemplate and it's controls via FindControl
        }
        else if (fvProducts.CurrentMode == FormViewMode.Edit)
        {
            fvProducts.HeaderText = "Edit Mode";
            fvProducts.HeaderStyle.BackColor = System.Drawing.Color.Red;
            // here  you can safely access the FormView's EditItemTemplate and it's controls via FindControl
            Control placeHolder = Controls[0].FindControl("ContentBody");

            DropDownList ddlSizeControl = fvProducts.Controls[0].FindControl("DropDownSize") as DropDownList;
            var lblSizeControl = fvProducts.Controls[0].FindControl("lblSize") as Label;

            var txtSizePriceControl = fvProducts.Controls[0].FindControl("txtSizePrice") as TextBox;
            var lblSizePriceControl = fvProducts.Controls[0].FindControl("lblSizePrice") as Label;

            if (ddlSizeControl != null && ddlSizeControl.SelectedIndex != -1) //SelectedValue.Equals("-1"))
            {
                ddlSizeControl.Visible = true;
                lblSizeControl.Visible = true;

                txtSizePriceControl.Visible = true;
                lblSizePriceControl.Visible = true;
            }
            else
            {
                ddlSizeControl.Visible = false;
                lblSizeControl.Visible = false;

                txtSizePriceControl.Visible = false;
                lblSizePriceControl.Visible = false;
            }
        }
        else if (fvProducts.CurrentMode == FormViewMode.Insert)
        {
            fvProducts.HeaderText = "Insert mode.";
            fvProducts.HeaderStyle.BackColor = System.Drawing.Color.Yellow;
            // here you can safely access the FormView's InsertItemTemplate and it's controls via FindControl
        }
    }

    protected void InsertButton_Click(object sender, EventArgs e)
    {
        StartUpLoad();
        remProducts.Insert();
        
    }

    private void StartUpLoad()
    {
        //get the file name of the posted image
        string imgName = ((FileUpload)fvProducts.Controls[0].FindControl("uploadPicture")).FileName; //uploadPicture.FileName;

        //get the size in bytes that
        int imgSize = ((FileUpload)fvProducts.Controls[0].FindControl("uploadPicture")).PostedFile.ContentLength; //uploadPicture.PostedFile.ContentLength;

        //validates the posted file before saving
        if (((FileUpload)fvProducts.Controls[0].FindControl("uploadPicture")).PostedFile != null && ((FileUpload)fvProducts.Controls[0].FindControl("uploadPicture")).FileName != "")
        {
            //if (FileUpload1.PostedFile != null && FileUpload1.PostedFile.FileName != "") {
            // 10240 KB means 10MB, You can change the value based on your requirement
            if (((FileUpload)fvProducts.Controls[0].FindControl("uploadPicture")).PostedFile.ContentLength > 20240)
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
                ((FileUpload)fvProducts.Controls[0].FindControl("uploadPicture")).SaveAs(imagePath);

                ImageResizeUtils.ResizeImage(imagePath, 300, 300);
                Page.ClientScript.RegisterClientScriptBlock(typeof(Page), "Alert", "alert('Image saved!')", true);
                //ProductImages/imgName
                ((HiddenField)fvProducts.Controls[0].FindControl("hfImageURL")).Value = "ProductImages/" + imgName;
            }
        }

    }

    protected void DropDownSize_SelectedIndexChanged(object sender, EventArgs e)
    {
        int Id = int.Parse(((DropDownList)fvProducts.Controls[0].FindControl("DropDownSize")).SelectedValue);
        // update the price depending on the size selected from the drop down list
        txtSizePrice.Text = GetPrice(Id);
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
   
    protected void saveDetails(object sender, EventArgs e)
    {
        StartUpLoad();
        remProducts.Update();
    }
}