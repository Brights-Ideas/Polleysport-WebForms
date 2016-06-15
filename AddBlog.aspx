<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" ValidateRequest="false" CodeFile="AddBlog.aspx.cs" Inherits="Default2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
    <form runat="server">
        <div class="form-group">
            <label for="txtTitle">Title:</label>
            <asp:TextBox ID="txtTitle" CssClass="form-control" runat="server" Width="550" />
        </div>
        <div class="form-group">
            <label for="txtBody">Body:</label>
            <asp:TextBox ID="txtBody" runat="server" TextMode="MultiLine" />
              
        </div>
        <asp:Button ID="btnSubmit" CssClass="btn btn-primary" Text="Submit" runat="server" OnClick="Submit" />
    </form>

    <script type="text/javascript" src="//tinymce.cachefly.net/4.0/tinymce.min.js"></script>
    <script type="text/javascript">
        tinymce.init({ selector: 'textarea' });
    </script>
</asp:Content>

