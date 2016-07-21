using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class _Default : Page
{
    private static int _pageSize = 9;

    protected void Page_Load(object sender, EventArgs e)
    {

        if (!IsPostBack)
        {
            BindDummyRow();
        }
    }

    private void BindDummyRow()
    {
        DataTable dummy = new DataTable();
        dummy.Columns.Add("ProductID");
        dummy.Columns.Add("ProductName");
        dummy.Columns.Add("ProductDescription");
        dummy.Columns.Add("ProductImageURL");
        
        dummy.Rows.Add();
        rpProducts.DataSource = dummy;
        rpProducts.DataBind();
    }


    [WebMethod]
    //public static string GetCustomers(string searchTerm, int pageIndex)
    public static string GetCustomers()
    {
        string query = "[Products_View_Home]";//[GetProducts_Pager]";
        SqlCommand cmd = new SqlCommand(query) {CommandType = CommandType.StoredProcedure};
        //cmd.Parameters.AddWithValue("@SearchTerm", searchTerm);
        //cmd.Parameters.AddWithValue("@PageIndex", pageIndex);
        //cmd.Parameters.AddWithValue("@PageSize", _pageSize);
        //cmd.Parameters.Add("@RecordCount", SqlDbType.Int, 4).Direction = ParameterDirection.Output;
        //return GetData(cmd, pageIndex).GetXml();
        return GetData(cmd).GetXml();
    }

    private static DataSet GetData(SqlCommand cmd)//, int pageIndex)
    {
        string strConnString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        using (SqlConnection con = new SqlConnection(strConnString))
        {
            using (SqlDataAdapter sda = new SqlDataAdapter())
            {
                cmd.Connection = con;
                sda.SelectCommand = cmd;
                using (DataSet ds = new DataSet())
                {
                    sda.Fill(ds);//, "Products");
                    //DataTable dt = new DataTable("Pager");
                    //dt.Columns.Add("PageIndex");
                    //dt.Columns.Add("PageSize");
                    //dt.Columns.Add("RecordCount");
                    //dt.Rows.Add();
                    //dt.Rows[0]["PageIndex"] = pageIndex;
                    //dt.Rows[0]["PageSize"] = _pageSize;
                    //dt.Rows[0]["RecordCount"] = cmd.Parameters["@RecordCount"].Value;
                    //ds.Tables.Add(dt);
                    return ds;
                }
            }
        }
    }
}