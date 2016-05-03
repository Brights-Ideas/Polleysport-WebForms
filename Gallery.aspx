<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeFile="Gallery.aspx.cs" Inherits="Gallery" %>

<asp:Content ID="Content1" ContentPlaceHolderID="headContent" runat="Server">
    <script src="lightbox/js/jquery-1.10.2.min.js"></script>
    <script src="lightbox/js/lightbox-2.6.min.js"></script>
    <link href="lightbox/css/lightbox.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">

    <div class="modal-header">
        Gallery Page -
            Under consturction
    </div>


    <form id="form1" runat="server">

        <div class="well">
            <div class="row">
                <asp:ListView ID="GalleryListView" GroupItemCount="5" runat="server"
                    DataSourceID="sdsGallery">
                    <LayoutTemplate>
                        <asp:PlaceHolder
                            ID="groupPlaceholder"
                            runat="server" />
                    </LayoutTemplate>
                    <GroupTemplate>
                        <div>
                            <asp:PlaceHolder
                                ID="itemPlaceholder"
                                runat="server" />
                        </div>
                    </GroupTemplate>
                    <ItemTemplate>
                        <div class="col-lg-3">
                            <a href="GalleryImages/<%#Eval("GalleryImageURL") %>" data-lightbox="image-1">
                                <img src="GalleryImages/<%#Eval("GalleryImageURL") %>" class="img-thumbnail" width="200" height="150" />
                            </a>
                            <p><%# !string.IsNullOrEmpty(Eval("GalleryTitle").ToString()) ? Eval("GalleryTitle").ToString() : "Description" %></p>
                        </div>
                    </ItemTemplate>
                    <EmptyItemTemplate>
                    </EmptyItemTemplate>
                </asp:ListView>
            </div>
        </div>
        <asp:SqlDataSource ID="sdsGallery" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
            SelectCommand="Gallery_view" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
    </form>
</asp:Content>
