using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class MemberPages_Users : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    private void Page_PreRender()
    {
        if (Alphalinks.Letter == "All")
        {
            Users.DataSource = Membership.GetAllUsers();
        }
        else
        {
            Users.DataSource = Membership.FindUsersByName(Alphalinks.Letter + "%");
        }
        Users.DataBind();
    }
}