<%@ Page Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="Login" %>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">

    <section id="loginForm">
        <div class="row">
            <div class="col-lg-12 text-center">
                <h2>Log in</h2>
                <hr class="star-primary">
            </div>
        </div>
        <div class="row">
            <div class="col-lg-12 col-lg-offset-2">
                <form runat="server" role="form">
                    <asp:Login ID="myLogin" runat="server" CssClass="form-horizontal"
                        CreateUserText="Not registered yet? Create an account!"
                        CreateUserUrl="~/Membership/EnhancedCreateUserWizard.aspx"
                        RememberMeSet="True"
                        TitleText=""
                        UserNameLabelText="Username:" OnAuthenticate="myLogin_Authenticate"
                        OnLoginError="myLogin_LoginError">
                        <LayoutTemplate>
                            <div class="form-group">
                                <asp:Label runat="server" AssociatedControlID="UserName" CssClass="col-md-2 control-label">User name</asp:Label>
                                <div class="col-md-10">
                                    <asp:TextBox ID="UserName" CssClass="form-control" runat="server"></asp:TextBox>
                                    <asp:RequiredFieldValidator runat="server" ControlToValidate="UserName"
                                        CssClass="text-danger" ErrorMessage="The user name field is required." />
                                </div>
                            </div>
                            <div class="form-group">
                                <asp:Label runat="server" AssociatedControlID="Password" CssClass="col-md-2 control-label">Password:</asp:Label>
                                <div class="col-md-10">
                                    <asp:TextBox ID="Password" CssClass="form-control" runat="server" TextMode="Password"></asp:TextBox>
                                    <asp:RequiredFieldValidator runat="server" ControlToValidate="Password" CssClass="text-danger" ErrorMessage="The password field is required." />
                                </div>
                            </div>
                            <div class="form-group">
                                <asp:Label runat="server" AssociatedControlID="Email" CssClass="col-md-2 control-label">Email:</asp:Label>
                                <div class="col-md-10">
                                    <asp:TextBox ID="Email" CssClass="form-control" runat="server"></asp:TextBox>
                                    <asp:RequiredFieldValidator runat="server" CssClass="text-danger"
                                        ControlToValidate="Email" ErrorMessage="Email is required." />
                                </div>
                            </div>
                            <div class="col-md-offset-2 col-md-10">
                                <div class="checkbox">
                                    <asp:CheckBox ID="RememberMe" CssClass="checkbox" runat="server" Checked="false"
                                        Text="Remember me next time." />
                                </div>
                            </div>

                            <div>
                                <asp:Literal ID="FailureText" runat="server" EnableViewState="False"></asp:Literal>
                            </div>

                            <div class="form-group">
                                <div class="col-md-offset-2 col-md-10">
                                    <asp:Button ID="LoginButton" CssClass="btn btn-default" runat="server" CommandName="Login" Text="Log In" />
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-md-offset-2 col-md-10">
                                    <asp:Button ID="PwdRecoveryButton" CssClass="btn btn-default" runat="server" PostBackUrl="~/PasswordRecovery.aspx" Text="Recover Password" />
                                </div>
                            </div>
                        </LayoutTemplate>
                    </asp:Login>
                </form>
            </div>
        </div>
    </section>

</asp:Content>

