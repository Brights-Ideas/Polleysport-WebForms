<%@ Page Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Checkout.aspx.cs"
    Inherits="Checkout" %>

<%@ Register Src="Controls/CartControl.ascx" TagName="CartControl" TagPrefix="uc1" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="Server">
        <div class="col-lg-8 col-lg-offset-2 text-center">
            <form runat="server">
                <uc1:CartControl ID="CartControl1" runat="server" />
            </form>
        </div>
    
</asp:Content>
