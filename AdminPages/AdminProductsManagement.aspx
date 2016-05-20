<%@ Page Title="" Language="C#" MasterPageFile="~/AdminPages/Admin.master" AutoEventWireup="true"
    CodeFile="AdminProductsManagement.aspx.cs" Inherits="AdminPages_AdminProductsManagement" %>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentBody" runat="Server">
        <asp:ScriptManager runat="server" ID="ScriptManager1" />
       
        <!-- Placing GridView in UpdatePanel-->
        <asp:UpdatePanel ID="upCrudGrid" runat="server">
            <ContentTemplate>
                <asp:Button ID="btnAdd" runat="server" Text="Add New Product" CssClass="btn btn-info" OnClick="btnAdd_Click" />
                <asp:GridView ID="GridView1" runat="server" HorizontalAlign="Center"
                    OnRowCommand="GridView1_RowCommand" AutoGenerateColumns="false" AllowPaging="true"
                    DataKeyNames="ProductID" CssClass="table table-hover table-striped">
                    <Columns>
                        <asp:ButtonField CommandName="editRecord" ControlStyle-CssClass="btn btn-info"
                            ButtonType="Button" Text="Edit" HeaderText="Edit Record">
                            <ControlStyle CssClass="btn btn-info"></ControlStyle>
                        </asp:ButtonField>
                        <asp:ButtonField CommandName="deleteRecord" ControlStyle-CssClass="btn btn-info"
                            ButtonType="Button" Text="Delete" HeaderText="Delete Record">
                            <ControlStyle CssClass="btn btn-info"></ControlStyle>
                        </asp:ButtonField>

                        <asp:BoundField DataField="ProductID" HeaderText="Id" />
                        <asp:BoundField DataField="ProductName" HeaderText="Name" />
                        <asp:BoundField DataField="ProductDescription" HeaderText="Description" />
                        <asp:BoundField DataField="in_stock" HeaderText="Stock" />
                        <asp:BoundField DataField="ProductPrice" HeaderText="Price" />
                        <asp:ImageField HeaderText="Image" DataImageUrlField="ProductImageUrl" DataImageUrlFormatString="~\{0}" />
                        <asp:BoundField DataField="CategoryID" HeaderText="Category" />
                        <asp:BoundField DataField="SubCategoryID" HeaderText="SubCategory" />
                        <asp:BoundField DataField="enabled" HeaderText="Active" />
                    </Columns>
                </asp:GridView>
            </ContentTemplate>
            <Triggers>
            </Triggers>
        </asp:UpdatePanel>
        <!-- Edit Modal Starts here -->
        <div id="editModal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="editModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
            <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h3 id="editModalLabel">Edit </h3>
            </div>
            <asp:UpdatePanel ID="upEdit" runat="server">
                <ContentTemplate>
                    <div class="modal-body">
                        <div class="form-group">
                            <asp:Label ID="lblId" CssClass="col-sm-2" runat="server" Text="Id" />
                            <div class="col-sm-10">
                                <asp:Label ID="lblProductID" CssClass="form-control-static" runat="server" Text="productID" />
                            </div>
                        </div>
                        <div class="form-group">
                            <asp:Label ID="lblprodTitle" CssClass="col-sm-2 control-label" AssociatedControlID="txtprodTitle" runat="server" Text="Name " />
                            <div class="col-sm-10">
                                <asp:TextBox ID="txtprodTitle" CssClass="form-control" runat="server" />
                            </div>
                        </div>
                        <div class="form-group">
                            <asp:Label ID="prodDesc" CssClass="col-sm-2 control-label" AssociatedControlID="txtXtext" runat="server" Text="Description" />
                            <div class="col-sm-10">
                                <asp:TextBox ID="txtXtext" TextMode="MultiLine" CssClass="form-control" runat="server" />
                            
                            <asp:RegularExpressionValidator ID="regexDescriptionValid" runat="server" ControlToValidate="txtXtext"
                                ErrorMessage="HTML charactors found in description remove these before saving" ValidationExpression="/?\w+\s+[^>]*" Display="Dynamic" ForeColor="Red"></asp:RegularExpressionValidator>
                            </div>
                        </div>
                        <div class="form-group">
                            <asp:Label ID="prodStock" CssClass="col-sm-2 control-label" AssociatedControlID="txtStock" runat="server" Text="Stock Level"></asp:Label>
                            <div class="col-sm-10">
                                <asp:TextBox ID="txtStock" CssClass="form-control" runat="server" />
                            </div>
                        </div>
                        <div class="form-group">
                            <asp:Label ID="prodPrice" CssClass="col-sm-2 control-label" AssociatedControlID="txtPrice" runat="server" Text="Price £"></asp:Label>
                            <div class="col-sm-10">
                                <asp:TextBox ID="txtPrice" CssClass="form-control" runat="server" />
                            </div>
                        </div>
                        <div class="form-group">
                            <img alt="Upload Image" class="col-sm-2" runat="server" src="../Content/Images/uploadphoto.png" />
                            <div class="col-sm-10">
                                <asp:FileUpload ID="fileUploadImage" runat="server"></asp:FileUpload>
                                <asp:HiddenField ID="hfImageURL" runat="server" Value="" />
                            </div>
                        </div>
                        <div class="form-group">
                            <asp:Label ID="prodCategory" CssClass="col-sm-2 control-label" AssociatedControlID="ddCatId" runat="server" Text="Category" />
                            <div class="col-sm-10">
                                <asp:DropDownList ID="ddCatId" CssClass="form-control" runat="server" DataSourceID="remCats" DataTextField="category"
                                DataValueField="CategoryID" />
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <asp:Label ID="lblResult" Visible="false" runat="server"></asp:Label>
                        <asp:Button ID="btnSave" runat="server" Text="Update" CssClass="btn btn-info" OnClick="btnSave_Click" />
                        <button class="btn btn-info" data-dismiss="modal" aria-hidden="true">Close</button>
                    </div>
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="GridView1" EventName="RowCommand" />
                    <asp:AsyncPostBackTrigger ControlID="btnSave" EventName="Click" />
                </Triggers>
            </asp:UpdatePanel>
            </div>
            </div>
        </div>
        <!-- Edit Modal Ends here -->
        <!-- Add Record Modal Starts here-->
        <div id="addModal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="addModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
            <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h3 id="addModalLabel">Add New Record</h3>
            </div>
            <asp:UpdatePanel ID="upAdd" runat="server">
                <ContentTemplate>
                    <div class="modal-body">
                        <table class="table table-bordered table-hover">
                            <tr>
                                <td>Product Name : 
                               
                                    <asp:TextBox ID="txtProductName" runat="server"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>Description :
                               
                                    <asp:TextBox ID="txtDescription" runat="server"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>Price :
                               
                                    <asp:TextBox ID="txtProductPrice" runat="server"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>Stock :
                                   
                                    <asp:TextBox ID="txtProductStock" runat="server"></asp:TextBox>
                                    <asp:Label ID="Label1" runat="server" Text="Type Integer Value!" />
                                </td>
                            </tr>
                            <tr>
                                <td><img alt="Upload Image" src="../Content/Images/uploadphoto.png" />
                                    
                                    <asp:FileUpload ID="insertUploadPicture" runat="server" />
                                    <asp:HiddenField ID="ImageURL" runat="server" Value='' />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:DropDownList ID="Category" CssClass="form-control" runat="server" DataSourceID="remCats" DataTextField="category"
                                    DataValueField="CategoryID" />
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div class="modal-footer">
                        <asp:Button ID="btnAddRecord" runat="server" Text="Add" CssClass="btn btn-info" OnClick="btnAddRecord_Click" />
                        <button class="btn btn-info" data-dismiss="modal" aria-hidden="true">Close</button>
                    </div>
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="btnAddRecord" EventName="Click" />
                </Triggers>
            </asp:UpdatePanel>
            </div>
            </div>
        </div>
        <!--Add Record Modal Ends here-->
        <!-- Delete Record Modal Starts here-->
        <div id="deleteModal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="delModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
            <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h3 id="delModalLabel">Delete </h3>
            </div>
            <asp:UpdatePanel ID="upDel" runat="server">
                <ContentTemplate>
                    <div class="modal-body">
                        Are you sure you want to delete the record?
                           
                        <asp:HiddenField ID="hfCode" runat="server" />
                    </div>
                    <div class="modal-footer">
                        <asp:Button ID="btnDelete" runat="server" Text="Delete" CssClass="btn btn-info" OnClick="btnDelete_Click" />
                        <button class="btn btn-info" data-dismiss="modal" aria-hidden="true">Cancel</button>
                    </div>
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="btnDelete" EventName="Click" />
                </Triggers>
            </asp:UpdatePanel>
            </div>
            </div>
        </div>
        <!--Delete Record Modal Ends here -->
    <asp:SqlDataSource ID="remCats" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
        SelectCommand="SELECT [category], [categoryID] FROM [Category]" />
</asp:Content>
