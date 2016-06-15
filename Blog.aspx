<%@ Page Language="C#" MasterPageFile="Site.master" AutoEventWireup="true" CodeFile="Blog.aspx.cs" Inherits="Blog" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <div class="page-header">
        <h1>Blogs <small>Click the blog title below to view the blog details.</small></h1>
    </div>
    <div class="panel panel-default">
      <div class="panel-heading">Panel heading without title</div>
      <div class="panel-body">
        Panel content
        <asp:HyperLink ID="HyperLink1" CssClass="btn btn-primary" NavigateUrl="~/AddBlog.aspx" Text="Add Blog" runat="server" />
      </div>
    </div>
<br />

<table class="table table-striped">
<asp:Repeater ID="rptPages" runat="server">
    <HeaderTemplate>
        <thead>
            <tr>
                <th>#</th>
                <th>Title:</th>
            </tr>
        </thead>
    </HeaderTemplate>
    <ItemTemplate>
        <tr>
            <td>
        <%# Container.ItemIndex + 1 %>
            </td>
            <td>
        <asp:HyperLink ID="HyperLink2" NavigateUrl='<%# string.Format("~/Blogs/{0}/{1}.aspx", Eval("BlogId"), Eval("Slug")) %>'
            Text='<%# Eval("Title") %>' runat="server" />
            </td>
        </tr>
    </ItemTemplate>
    <SeparatorTemplate>
        <br />
    </SeparatorTemplate>
</asp:Repeater>
</table>

</asp:Content>