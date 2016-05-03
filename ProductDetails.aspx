<%@ Page Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="ProductDetails.aspx.cs"
    Inherits="ProductDetails" %>

<%--<%@ Register Src="~/CartSummary.ascx" TagName="CartControl" TagPrefix="CSummary" %>--%>
<%@ Register Src="Controls/ViewCartSummary.ascx" TagName="CartControl" TagPrefix="CSummary" %>
<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="Server">
    <form runat="server">
    <asp:SqlDataSource ID="sdsProductDetails" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
        SelectCommand="ProductDetails" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:QueryStringParameter Name="ProductID" QueryStringField="ProductID" Type="Int64" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:PlaceHolder ID="LocalPlaceHolder" runat="server"></asp:PlaceHolder>

    
        <asp:FormView ID="fvProductsDetails" runat="server" DataSourceID="sdsProductDetails">
        <ItemTemplate>
            <section>
                <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
                <div class="container">
                <div class="row">
                    <div class="col-lg-12 text-center">
                        <h2>
                            <asp:Literal ID="NameLabel" runat="server" Text='<%# Eval("ProductName") %>'></asp:Literal></h2>
                        <hr class="star-primary">
                    </div>
                </div>
                <div class="row">                    
                    <asp:HiddenField ID="Shipping" Value='<%#Eval("ShippingCost") %>' runat="server" />

                    <div class="col-lg-4 col-lg-offset-2">
                        <asp:Image ID="Image1" CssClass="img-thumbnail img-centered" runat="server" ImageUrl='<%# (int)Eval("in_stock") <=0 ? "Content/Images/SoldOut.jpg" : Eval("ProductImageURL") %>' />
                    </div>
                    <div class="col-lg-4">
                    
                    <asp:HiddenField ID="hdn_prod" Value='<%# Eval("ProductID") %>' runat="server" />
                    <%--Sizes dropdown datasource--%>
                    <asp:SqlDataSource ID="DropDownSizeData" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
                        SelectCommand="SELECT Id, attribute_value FROM Product_Attributes WHERE (Product_Id = @prodID)">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="hdn_prod" Name="prodID" Type="Int64" />
                        </SelectParameters>
                    </asp:SqlDataSource>

                    <div class="form-horizontal">
                        <div class="form-group">
                            <asp:Label ID="QuantityLabel" runat="server" Text="Quantity" CssClass="col-lg-2 control-label"></asp:Label>
                            <div class="col-lg-10">
                                <asp:TextBox ID="txtQuantity" runat="server" MaxLength="2" Text="1" CssClass="form-control" Width="50px"></asp:TextBox>
                            </div>
                        </div>
                        <div class="form-group">
                            <asp:Label ID="SizeLabel" runat="server" Text="Size" CssClass="col-lg-2 control-label"></asp:Label>
                            <%--Sizes dropdown list--%>
                            <div class="col-lg-10">
                                <asp:DropDownList ID="DropDownSize" runat="server" DataSourceID="DropDownSizeData"
                                    AutoPostBack="true" DataTextField="attribute_value" DataValueField="Id" OnSelectedIndexChanged="DropDownSize_SelectedIndexChanged"
                                    CssClass="form-control" />
                            </div>
                        </div>
                    </div>

                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                        <ContentTemplate>
                            <label class="control-label">Price excluding VAT</label><br />
                            <span class="productPrice">&pound<asp:Label ID="PriceLabel" runat="server" Text='<%# Eval("ProductPrice", "{0:##0.00}")  %>'></asp:Label>
                            </span>
                        </ContentTemplate>
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="DropDownSize" />
                        </Triggers>
                    </asp:UpdatePanel>
                        
                    <button runat="server" id="btnCart" onserverclick="AddToCart_Click" visible='<%# StringHelper.StockDisplayClass((int)Eval("in_stock")) %>' class="btn btn-primary" title="Add to Cart">
                        <i class='fa fa-cart-plus'></i>Add to Cart
                    </button>
                    </div>
                    
                    <div class="col-lg-8 col-lg-offset-2 text-center">
                        <hr />
                        <h3>Description</h3>
                        <p><asp:Label ID="DescriptionLabel" runat="server" Text='<%# Eval("ProductDescription") %>'></asp:Label></p>
                    </div>
                </div>
            </div>
            </section>
        </ItemTemplate>
        <EmptyDataTemplate>
            <section>
                <div class="container">
                    <div class="row">
                        <div class="col-lg-8 col-lg-offset-2 text-center">
                            <h3><i class="fa fa-exclamation-triangle"></i></h3>
                            <p>There are no products matching this criteria please return to the home page</p>
                            <a class="btn btn-primary" href="Default.aspx">Home</a>
                        </div>
                    </div>
                </div>
            </section>
        </EmptyDataTemplate>
    </asp:FormView>
    </form>
</asp:Content>
