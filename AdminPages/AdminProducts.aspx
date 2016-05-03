<%@ Page Title="" Language="C#" MasterPageFile="~/AdminPages/Admin.master" AutoEventWireup="true"
    CodeFile="AdminProducts.aspx.cs" Inherits="AdminPages_AdminProducts" %>

<asp:Content ID="Content3" ContentPlaceHolderID="headContent" runat="Server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="ContentBody" runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <asp:PlaceHolder ID="LocalPlaceHolder" runat="server"></asp:PlaceHolder>

    <%--<div class="modal-header">
            Add Product
        </div>--%>

    <asp:FormView ID="fvProducts" DataSourceID="remProducts"
        runat="server" ViewStateMode="Enabled" OnDataBound="fvProducts_DataBound" Width="100%">
        <EditItemTemplate>
            <div class="applicationWindow span8 offset1">
                <div class="modal-header">Edit Product</div>
                <div class="modal-body">
                    <div class="form-group">
                        <asp:Label ID="lblprodTitle" AssociatedControlID="txtprodTitle" runat="server" Text="Product Title" />
                        <asp:TextBox ID="txtprodTitle" CssClass="form-control" runat="server" Text='<%#Bind("ProductName")%>' />
                    </div>
                    <div class="form-group">
                        <asp:Label ID="prodDesc" runat="server" Text="Description"></asp:Label>
                        <asp:TextBox ID="txtXtext" TextMode="MultiLine" CssClass="form-control" runat="server" Text='<%#Bind("ProductDescription")%>' />
                        <asp:RegularExpressionValidator ID="regexDescriptionValid" runat="server" ControlToValidate="txtXtext"
                            ErrorMessage="HTML charactors found in description remove these before saving" ValidationExpression="/?\w+\s+[^>]*" Display="Dynamic" ForeColor="Red"></asp:RegularExpressionValidator>
                    </div>
                    <div class="form-group">
                        <asp:Label ID="prodStock" runat="server" Text="Stock Level"></asp:Label>
                        <asp:TextBox ID="txtStock" CssClass="form-control" runat="server" Text='<%#Bind("in_stock") %>' />
                    </div>
                    <div class="form-group">
                        <asp:Label ID="prodPrice" runat="server" Text="Polleysport Price £"></asp:Label>
                        <asp:TextBox ID="txtPrice" CssClass="form-control" runat="server" Text='<%#Bind("ProductPrice", "{0:##0.00}") %>' />
                    </div>
                    <div class="form-group">
                        <asp:Label ID="prodShip" runat="server" Text="Shipping £"></asp:Label>
                        <asp:TextBox ID="txtSHP" CssClass="form-control" runat="server" Text='<%#Bind("ShippingCost", "{0:##0.00}") %>' />
                    </div>
                    <div class="form-group">
                        <img alt="Upload Image" id="prodImage" src="../Content/Images/uploadphoto.png" />
                        <asp:FileUpload ID="uploadPicture" CssClass="form-control" runat="server" />
                        <asp:HiddenField ID="hfImageURL" runat="server" Value='<%#Bind("ProductImageUrl") %>' />
                    </div>
                    <div class="form-group">
                        <asp:Label ID="lblCats" runat="server" Text="Categories" />
                        <!-- loop through cats -->
                        <asp:DropDownList ID="ddCatId" CssClass="form-control" runat="server" DataSourceID="remCats" DataTextField="name"
                            DataValueField="CategoryID" SelectedValue='<%#Bind("CategoryID") %>' />
                    </div>
                    <div class="form-group">
                        <asp:Label ID="lblSize" runat="server" Text="Sizes" />
                        <asp:HiddenField ID="hdn_prod" Value='<%# Eval("ProductID") %>' runat="server" />
                        <!-- loop through sizes -->
                        <asp:DropDownList ID="DropDownSize" CssClass="form-control" runat="server" DataSourceID="DropDownSizeData"
                            AutoPostBack="true" DataTextField="attribute_value" DataValueField="Id" OnSelectedIndexChanged="DropDownSize_SelectedIndexChanged" />
                    </div>
                    <div class="form-group">
                        <asp:Label ID="lblSizePrice" runat="server" Text="Size Price" />
                        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                            <ContentTemplate>
                                <asp:TextBox ID="txtSizePrice" runat="server" CssClass="price" Text='<%#Bind("Price", "{0:##0.00}")  %>' />
                            </ContentTemplate>
                            <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="DropDownSize" />
                            </Triggers>
                        </asp:UpdatePanel>

                    </div>
                </div>
                    <div class="modal-footer">
                        <div class="btn-group pull-right">
                            <asp:Button ID="btnSaveDetails" runat="server" CssClass="btn btn-primary" Text="Update details"
                                OnClick="saveDetails" CausesValidation="true" />

                            <asp:LinkButton ID="UpdateCancelButton" runat="server" CssClass="btn btn-warning" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
                        </div>
                    </div>
                
            </div>
        </EditItemTemplate>
        <ItemTemplate>

            <div class="applicationWindow span8 offset1">
                <div class="modal-header">Update Product</div>
                <div class="modal-body">
                    <asp:HiddenField ID="hdn_prod" Value='<%# Eval("ProductID") %>' runat="server" />
                        <div class="row">
                            <a class="span3 pull-left" href="#">
                                <img class="media-object" id="ImageContent" alt="" src='../<%# Eval("ProductImageURL") %>' width="130px" height="180px" />
                            </a>
                            <div class="span6">
                                <h3 class="media-heading"><%# Eval("ProductName")%> </h3>
                                <%# Eval("ProductDescription").ToString() %>
                            </div>

                                 <div class="span3 btn-group-vertical pull-right">
                                    <asp:LinkButton ID="NewButton" runat="server" CausesValidation="False"
                                        CssClass="btn btn-success" CommandName="New" Text="Add Product" />
                                    <asp:LinkButton ID="btnEdit" Text="Edit Product" CssClass="btn btn-warning" CommandName="Edit"
                                        runat="server" />
                                    <asp:LinkButton ID="lnkDelete" Text="Delete Product" CssClass="btn btn-danger" CommandName="Delete"
                                        OnClientClick="return confirm('Delete entry?');" runat="server" />
                                </div>
                        </div>
                </div>
            </div>
        </ItemTemplate>
        <InsertItemTemplate>

            <div class="applicationWindow span8 offset1">
                <div class="modal-header">Add Product</div>
                <div class="modal-body">
                    <div class="form-group">
                        <label for="txtProductName">Product name: </label>
                        <asp:TextBox ID="txtProductName" CssClass="form-control" Text='<%#Bind("ProductName") %>' runat="server"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <label for="txtDescription">Description: </label>
                        <asp:TextBox ID="txtDescription" CssClass="form-control" TextMode="MultiLine" Text='<%#Bind("ProductDescription") %>' runat="server"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <label for="txtProductPrice">Price: </label>
                        <asp:TextBox ID="txtProductPrice" CssClass="form-control" Text='<%#Bind("ProductPrice", "{0:c}") %>' runat="server"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <label for="txtPriceStock">Shipping: </label>
                        <asp:TextBox ID="txtShipping" CssClass="form-control" Text='<%#Bind("ShippingCost", "{0:c}") %>' runat="server"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <label for="txtPriceStock">Stock Level: </label>
                        <asp:TextBox ID="txtPriceStock" CssClass="form-control" runat="server" Text='<%#Bind("in_stock") %>' />
                    </div>
                    <div class="form-group">
                        <img alt="Upload Image" id="prodImage" src="../Content/Images/uploadphoto.png" />
                        <asp:FileUpload ID="uploadPicture" CssClass="form-control" runat="server" />
                        <asp:HiddenField ID="hfImageURL" runat="server" Value='<%#Bind("ProductImageUrl") %>' />
                    </div>
                    <div class="form-group">
                        <label for="">Category: </label>
                        <asp:DropDownList ID="ddlCategory" CssClass="form-control"
                            DataSourceID="remCats"
                            DataValueField="CategoryID"
                            DataTextField="Name"
                            SelectedValue='<%#Bind("CategoryID") %>' runat="server">
                        </asp:DropDownList>
                    </div>

                </div>
                    <div class="modal-footer">
                        <div class="btn-group pull-right">
                            <asp:LinkButton ID="InsertButton" runat="server" CssClass="btn btn-primary" OnClick="InsertButton_Click" CausesValidation="True" CommandName="Insert" Text="Insert" />
                            <asp:LinkButton ID="InsertCancelButton" runat="server" CssClass="btn btn-warning" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
                        </div>
                    </div>
                
            </div>
        </InsertItemTemplate>
        <EmptyDataTemplate>
            There is no records in data source.
        </EmptyDataTemplate>
    </asp:FormView>


    <asp:SqlDataSource ID="remProducts" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
        SelectCommand="SELECT * FROM Products LEFT JOIN Product_Attributes ON Products.ProductID = Product_Attributes.Product_Id WHERE ProductID=@ProductID"
        InsertCommand="Products_Insert" InsertCommandType="StoredProcedure"
        UpdateCommand="Products_Edit" UpdateCommandType="StoredProcedure"
        DeleteCommand="UPDATE Products SET enabled = 0 WHERE ProductID=@ProductID"
        runat="server">
        <InsertParameters>
            <asp:Parameter Name="ProductName" Type="String" />
            <asp:Parameter Name="ProductDescription" Type="String" />
            <asp:Parameter Name="ProductPrice" Type="Decimal" />
            <asp:Parameter Name="ShippingCost" Type="Decimal" />
            <asp:Parameter Name="in_stock" Type="Int32" />
            <asp:Parameter Name="ProductImageURL" Type="String" />
            <asp:Parameter Name="CategoryID" Type="Int32" />
        </InsertParameters>
        <SelectParameters>
            <asp:QueryStringParameter Name="ProductID" QueryStringField="ProductID" ConvertEmptyStringToNull="true" Type="Int32" />
        </SelectParameters>
        <UpdateParameters>
            <asp:QueryStringParameter Name="ProductID" QueryStringField="ProductID" Type="Int32" />
            <asp:ControlParameter ControlID="fvProducts$txtprodTitle" Name="Name" PropertyName="Text"
                Type="String" />
            <asp:ControlParameter ControlID="fvProducts$txtXtext" Name="Description" PropertyName="Text"
                Type="String" />
            <asp:ControlParameter ControlID="fvProducts$txtStock" Name="Stock" PropertyName="Text"
                Type="Int32" />
            <asp:ControlParameter ControlID="fvProducts$txtPrice" Name="Price" PropertyName="Text"
                Type="Decimal" />
            <asp:ControlParameter ControlID="fvProducts$txtSHP" Name="Shipping" PropertyName="Text"
                Type="Decimal" />
            <asp:ControlParameter ControlID="fvProducts$hfImageURL" Name="ImageURL" PropertyName="Value"
                Type="String" />
            <asp:ControlParameter ControlID="fvProducts$ddCatId" Name="CatId" PropertyName="Text"
                Type="Int32" />
            <asp:ControlParameter ControlID="fvProducts$DropDownSize" Name="Id" PropertyName="Text"
                Type="Int32" />
            <asp:ControlParameter ControlID="fvProducts$txtSizePrice" Name="SizePrice" PropertyName="Text"
                Type="Decimal" />
        </UpdateParameters>
        <DeleteParameters>
            <asp:QueryStringParameter Name="ProductID" QueryStringField="ProductID" Type="Int32" />
        </DeleteParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="DropDownSizeData" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
        SelectCommand="SELECT Id, attribute_value FROM Product_Attributes WHERE (Product_Id = @ProductID)">
        <SelectParameters>
            <asp:QueryStringParameter Name="ProductID" QueryStringField="ProductID" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="remCats" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
        SelectCommand="SELECT [name], [categoryID] FROM [Category]" />

</asp:Content>
