using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Net;
using System.Net.Mail;

public partial class Contact : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Control placeHolder = Controls[0].FindControl("ContentBody");

    }

    protected void btnSubmitMessage_Click(object sender, EventArgs e)
    {
        string encodedResponse = Request.Form["g-Recaptcha-Response"];
        bool IsCaptchaValid = ReCaptcha.Validate(encodedResponse);

        if (IsCaptchaValid)
        {

            if (hfStatus.Value == "sent")
            {
                return;
            }

            try
            {
                if (!Page.IsValid && string.IsNullOrEmpty(txtEmail.Value))
                    return;
                using (var smtp = new SmtpClient())
                {
                    //set from address
                    string FromAddress = ConfigurationManager.AppSettings["EmailTo"];
                    //set the Recipient address
                    string ToAddress = ConfigurationManager.AppSettings["EmailTo"];
                    //Create the MailMessage instance 
                    MailMessage MyMailMessage = new MailMessage(FromAddress, ToAddress);
                    //assign mail properties
                    MyMailMessage.Subject = "PolleySport contact form enquiry";
                    //MyMailMessage.Body = message.Value;
                    MyMailMessage.Body = message.Value + " - " + "Please reply to " + txtContactEmail.Text;
                    MyMailMessage.IsBodyHtml = false;

                    //send the message
                    smtp.Send(MyMailMessage);

                    hfStatus.Value = "sent";
                    pnlForm.Visible = false;
                    pnlSuccess.Visible = true;
                }
            }
            catch (Exception ex)
            {
                pnlError.Visible = true;
                litErrorMessage.Text = ex.Message;
            }
        }
    }
}