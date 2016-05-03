using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;
using Polleymotorsport;
using Microsoft.AspNet.Identity;

public partial class Login : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            if (Request.IsAuthenticated && !string.IsNullOrEmpty(Request.QueryString["ReturnUrl"]))
                // This is an unauthorized, authenticated request...
                Response.Redirect("~/UnauthorizedAccess.aspx");
        }
    }

    protected void LogIn(object sender, EventArgs e)
    //protected void myLogin_Authenticate(object sender, AuthenticateEventArgs e)
    {
        if (IsValid)
        {
            // Validate the user password
            var manager = new UserManager();
            ApplicationUser user = manager.Find(UserName.Text, Password.Text);
            if (user != null)
            {
                IdentityHelper.SignIn(manager, user, RememberMe.Checked);
                IdentityHelper.RedirectToReturnUrl(Request.QueryString["ReturnUrl"], Response);
            }
            else
            {
                FailureText.Text = "Invalid username or password.";
                ErrorMessage.Visible = true;
            }
        }
        // Get the email address entered
        //TextBox EmailTextBox = myLogin.FindControl("Email") as TextBox;
        //string email = EmailTextBox.Text.Trim();

        // Verify that the username/password pair is valid
        //if (Membership.ValidateUser(myLogin.UserName, myLogin.Password))
        //{
        //    // Username/password are valid, check email
        //    MembershipUser usrInfo = Membership.GetUser(myLogin.UserName);
        //    if (usrInfo != null && string.Compare(usrInfo.Email, email, true) == 0)
        //    {
        //        // Email matches, the credentials are valid
        //        e.Authenticated = true;

        //        // Determine redirect URL and send user there
        //        //Response.Redirect("~/AdminPages/AdminManagement.aspx");
        //    }
        //    else
        //    {
        //        // Email address is invalid...
        //        e.Authenticated = false;
        //    }
        //}
        //else
        //{
        //    // Username/password are not valid...
        //    e.Authenticated = false;
        //}
    }

    protected void myLogin_LoginError(object sender, EventArgs e)
    {
        // Determine why the user could not login...        
        //myLogin.FailureText = "Your login attempt was not successful. Please try again.";

        // Does there exist a User account for this user?
        //MembershipUser usrInfo = Membership.GetUser(myLogin.UserName);
        MembershipUser usrInfo = Membership.GetUser(UserName.Text);
        if (usrInfo != null)
        {
            // Is this user locked out?
            if (usrInfo.IsLockedOut)
            {
                //myLogin.FailureText = "Your account has been locked out because of too many invalid login attempts. Please contact the administrator to have your account unlocked.";
                FailureText.Text = "Your account has been locked out because of too many invalid login attempts. Please contact the administrator to have your account unlocked.";
            }
            else if (!usrInfo.IsApproved)
            {
                FailureText.Text = "Your account has not yet been approved. You cannot login until an administrator has approved your account.";
            }
        }
    }
}