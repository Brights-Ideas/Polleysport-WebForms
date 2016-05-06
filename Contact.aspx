<%@ Page Title="Contact" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeFile="Contact.aspx.cs" Inherits="Contact" %>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
   <section>

        <div class="row">
            <div class="col-lg-12 text-center">
                <h2>Send a Message</h2>
                <hr class="star-primary">
            </div>
        </div>
        
        <div class="row">
            <div class="col-lg-4 col-lg-offset-2">
                <p class="bold">
                    We're based in Wimblington Road Manea, nr.March Cambs in the UK, not far from Huntingdon, Cambridgeshire & Surrounding areas.
                    For questions about an order or for more information about our products, give us a call or, email me at <a href="mailto:info@polleymotorsport.co.uk?Subject=Contact" target="_top">info@polleymotorsport.co.uk</a> or fill out the form to the right.

                    We are also on the usual social sites please see links in the footer.
                </p>
            </div>
            <div class="col-lg-4">
                <form action="" runat="server" class="form-horizontal">
                    
                <asp:Panel runat="server" ID="pnlForm">
                    <asp:HiddenField runat="server" ID="hfStatus" />
                    <div class="form-group">
                        <input type="text" id="txtEmail" name="txtEmail" style="display: none;" runat="server">
                        
                    </div>

                    <div class="form-group">
                        <label for="txtContactName">Enter Your Name *:</label>
                            <asp:TextBox ID="txtContactName" CssClass="form-control" runat="server" />
                            <asp:RequiredFieldValidator ID="rfvContactName" ControlToValidate="txtContactName"
                                Display="Dynamic" runat="server" ErrorMessage="Your name is required"
                                ForeColor="Red"></asp:RequiredFieldValidator>
                    </div>
                    <div class="form-group">
                        <label for="txtContactEmail">Enter Your E-mail *:</label>
                            <asp:TextBox ID="txtContactEmail" CssClass="form-control" runat="server" />
                            <asp:RequiredFieldValidator ID="rfvContactEmail" runat="server" ErrorMessage="Your email is required"
                                ControlToValidate="txtContactEmail" Display="Dynamic"
                                ForeColor="Red"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="regexEmailValid" runat="server" ValidationExpression="\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
                                ControlToValidate="txtContactEmail"
                                ErrorMessage="Invalid Email Format" Display="Dynamic" ForeColor="Red"></asp:RegularExpressionValidator>
                    </div>
                    <div class="form-group">
                        <label for="message">Your Message *:</label>
                            <textarea id="message" class="form-control" cols="10" rows="5" name="message" runat="server"></textarea>
                            <asp:RequiredFieldValidator ID="rfvEmailMessage" ControlToValidate="message"
                                Display="Dynamic" runat="server" ErrorMessage="Your message text is required"
                                ForeColor="Red"></asp:RequiredFieldValidator>
                    </div>
                    <div class="form-group">
                        <div class="g-recaptcha" data-sitekey="6LfrIx8TAAAAAHWZPE0Dij58Pe8qmWv-bXcZoq4F"></div>
                    </div>
                    <div class="form-group">
                        <asp:Button ID="btnSubmitMessage" runat="server" CssClass="btn btn-success" Text="Send a message" OnClick="btnSubmitMessage_Click" />
                    </div>

                </asp:Panel>

                <asp:Panel ID="pnlError" runat="server" Visible="False">
                    <div class="alert alert-error">
                        <h3>Error</h3>
                        <p>Sorry, something went wrong when we tried to send your message.</p>
                        <p>
                            <asp:Literal ID="litErrorMessage" runat="server"></asp:Literal>
                        </p>
                    </div>
                </asp:Panel>

                <asp:Panel runat="server" ID="pnlSuccess" Visible="False">
                    <div class="content_std">
                        <h3>Your Message</h3>
                        <p>
                            has been sent successfully
                        </p>
                    </div>
                </asp:Panel>
                
            </form>
            </div>
        </div>
    </section>

    <script type="text/javascript">
        $(".reset").click(function () {
            $(this).closest('form').find("input[type=text], textarea").val("");
        });
    </script>
    <script src='https://www.google.com/recaptcha/api.js'></script>
</asp:Content>
