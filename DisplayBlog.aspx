<%@ Page Language="C#" MasterPageFile="Site.master" AutoEventWireup="true" CodeFile="DisplayBlog.aspx.cs" Inherits="DisplayBlog" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <h2>
    <asp:Label ID="lblTitle" runat="server" /></h2>
<hr />
<asp:Label ID="lblBody" runat="server" />
</asp:Content>