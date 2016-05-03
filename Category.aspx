<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeFile="Category.aspx.cs" Inherits="Category" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="Server">

        <div class="row">
            <div class="col-lg-12 text-center">
                <h2><asp:Label ID="lblCategory" Text='<%# Eval("Category") %>' runat="server" /></h2>
                <hr class="star-primary">
            </div>
        </div>
        <div class="container">
            <div class="row text-center">
                <asp:Repeater ID="repProducts" runat="server" DataSourceID="dsProdList">
                    <ItemTemplate>
                        <div class="col-md-3 col-sm-6 hero-feature">
                        <!--<div class="col-sm-4 portfolio-item text-center">-->
                            <div class="thumbnail">
                            <img class="img-rounded" src="<%# (int)Eval("in_stock") <= 0 ? "Content/Images/SoldOut.jpg" : Eval("ProductImageURL")%>"
                                alt='<%# Eval("ProductName")%>' width="244" height="244" />
                                <div class="caption">
                                <h4><%# Eval("ProductName").ToString().Length >= 15 ? Eval("ProductName").ToString().ToTruncatedString(15) : Eval("ProductName")%></h4>
                                <p><%# Eval("ProductDescription").ToString().Length <= 0 ? "<br/><br/>" : Eval("ProductDescription").ToString().ToTruncatedString(10) %></p>
                                <p><asp:HyperLink ID="HyperLink1" Visible='<%# StringHelper.StockDisplayClass((int)Eval("in_stock")) %>' runat="server" CssClass="btn btn-primary"
                                NavigateUrl='<%# Eval("ProductID", "ProductDetails.aspx?ProductID={0}") %>'>More Info</asp:HyperLink></p>
                                </div>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </div>

    <asp:SqlDataSource ID="dsProdList" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
        SelectCommand="ProductCategories" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="1" Name="cat_ID" QueryStringField="showme"
                Type="Int64" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="dsCategory" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
        SelectCommand="CategoryName" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="1" Name="cat_ID" QueryStringField="showme"
                Type="Int64" />
        </SelectParameters>
    </asp:SqlDataSource>

</asp:Content>
