<%@ Page Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="PasswordRecovery.aspx.cs" Inherits="MemberPages_PasswordRecovery" %>

<asp:Content ID="ContentPasswordRecovery" ContentPlaceHolderID="MainContent" runat="Server">

    <div class="modal-header">Forgot Password</div>
    <div class="well">
        <form id="pwdRecover" role="form" runat="server">
            <asp:PasswordRecovery ID="PasswordRecovery1" runat="server">
                <UserNameTemplate>
                    <div class="form-group">
                        <div class="alert alert-info" role="alert">Forgot Your Password?</div>
                    </div>
                    <div class="form-group">
                        <label for="InputPassword1">Enter your User Name to receive your password.</label>
                    </div>
                    <div class="form-group">
                        <asp:Label ID="Label1" runat="server" CssClass="col-sm-2 control-label" AssociatedControlID="UserName">User Name:</asp:Label>
                        <div class="col-sm-10">
                            <asp:TextBox ID="UserName" CssClass="form-control" runat="server"></asp:TextBox>
                        </div>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="UserName"
                            ErrorMessage="User Name is required." ToolTip="User Name is required." ValidationGroup="PasswordRecovery1">*</asp:RequiredFieldValidator>
                    </div>
                    <asp:Literal ID="Literal1" runat="server" EnableViewState="False"></asp:Literal>

                    <asp:Button ID="btnSubmit" runat="server" CssClass="btn btn-default" CommandName="Submit" Text="Submit" ValidationGroup="PasswordRecovery1" />
                </UserNameTemplate>

            </asp:PasswordRecovery>
        </form>
    </div>
</asp:Content>
