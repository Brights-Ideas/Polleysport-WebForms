<%@ Page Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Products.aspx.cs"
    Inherits="Products" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="Server">
    <form runat="server">
    <asp:SqlDataSource ID="sdsProducts" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
        SelectCommand="Products_View" FilterExpression="ProductName LIKE '%{0}%'" SelectCommandType="StoredProcedure"
        CancelSelectOnNullParameter="False">
        <FilterParameters>
            <asp:ControlParameter Name="Product" ControlID="txtSearch" PropertyName="Text" />
        </FilterParameters>
    </asp:SqlDataSource>
    <div class="modal-header">
        Products
        <div class="col-lg-4 pull-right">
            <div class="input-group">
                <asp:TextBox ID="txtSearch" runat="server" placeholder="Search Product.." CssClass="form-control" />
                <span class="input-group-btn">
                    <asp:Button ID="btnSearch" runat="server" CssClass="btn btn-primary" Text="Search" />
                </span>
            </div>
            <!-- /input-group -->
        </div>
    </div>
    <div class="well">
        <asp:Repeater ID="rpProducts" runat="server">
            <ItemTemplate>
                <ul class="media-list">
                    <li class="media"><a class="pull-left" href="#">
                        <img class="img-thumbnail" src="<%# (int)Eval("in_stock") <= 0 ? "Content/Images/SoldOut.jpg" : Eval("ProductImageURL")%>"
                            alt='<%# Eval("ProductName")%>' width="160" height="200" />
                    </a>
                        <div class="media-body">
                            <h4 class="media-heading">
                                <%# Eval("ProductName") %>
                            </h4>
                            <p><%# Eval("ProductDescription") %></p>
                            <hr />
                            <asp:HyperLink ID="HyperLink2" Style="margin: 20px;" runat="server" CssClass="pull-right btn btn-primary"
                                NavigateUrl='<%# Eval("ProductID", "ProductDetails.aspx?ProductID={0}") %>'>View Details >></asp:HyperLink>
                        </div>
                    </li>
                </ul>
            </ItemTemplate>
        </asp:Repeater>
        <div id="pagination" style="display: inline-block">
            <asp:Panel ID="pnlNavigation" runat="server" Visible="false">
                <asp:Button ID="btnPrev" runat="server" CssClass="button" Text=" << " OnClick="btnPrev_Click" />
                <asp:Label ID="lblCurrentPage" runat="server"></asp:Label>
                <asp:Button ID="btnNext" runat="server" CssClass="button" Text=" >> " OnClick="btnNext_Click" />
            </asp:Panel>
        </div>
    </div>
    </form>
</asp:Content>
