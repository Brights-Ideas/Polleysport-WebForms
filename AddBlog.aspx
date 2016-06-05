<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="AddBlog.aspx.cs" Inherits="Default2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
    <form runat="server">
        <table border="0" cellpadding="0" cellspacing="0">
            <tr>
                <td>Title:
                </td>
            </tr>
            <tr>
                <td>
                    <asp:TextBox ID="txtTitle" runat="server" Width="550" />
                </td>
            </tr>
            <tr>
                <td>&nbsp;
                </td>
            </tr>
            <tr>
                <td>Body:
                </td>
            </tr>
            <tr>
                <td>
                    <asp:TextBox ID="txtBody" runat="server" TextMode="MultiLine" />
                </td>
            </tr>
            <tr>
                <td>&nbsp;
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Button ID="btnSubmit" Text="Submit" runat="server" OnClick="Submit" />
                </td>
            </tr>
        </table>
    </form>

    <script type="text/javascript" src="//tinymce.cachefly.net/4.0/tinymce.min.js"></script>
    <script type="text/javascript">
        tinymce.init({ selector: 'textarea' });
    </script>
</asp:Content>

