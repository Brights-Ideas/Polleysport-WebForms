<%@ Page Title="" Language="C#" MasterPageFile="~/AdminPages/Admin.master" AutoEventWireup="true"
    CodeFile="AdminProductsManagement.aspx.cs" Inherits="AdminPages_AdminProductsManagement" %>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentBody" runat="Server">
    <asp:ScriptManager runat="server" ID="ScriptManager1" />
    <!-- Placing GridView in UpdatePanel-->
    <asp:UpdatePanel ID="upCrudGrid" runat="server">
        <ContentTemplate>
            <asp:GridView ID="GridView1" runat="server" Width="940px" HorizontalAlign="Center"
                OnRowCommand="GridView1_RowCommand" AutoGenerateColumns="false" AllowPaging="true"
                DataKeyNames="ProductID" CssClass="table table-hover table-striped">
                <Columns>
                    <asp:ButtonField CommandName="detail" ControlStyle-CssClass="btn btn-info"
                        ButtonType="Button" Text="Detail" HeaderText="Detailed View">
                        <ControlStyle CssClass="btn btn-info"></ControlStyle>
                    </asp:ButtonField>
                    <asp:ButtonField CommandName="editRecord" ControlStyle-CssClass="btn btn-info"
                        ButtonType="Button" Text="Edit" HeaderText="Edit Record">
                        <ControlStyle CssClass="btn btn-info"></ControlStyle>
                    </asp:ButtonField>
                    <asp:ButtonField CommandName="deleteRecord" ControlStyle-CssClass="btn btn-info"
                        ButtonType="Button" Text="Delete" HeaderText="Delete Record">
                        <ControlStyle CssClass="btn btn-info"></ControlStyle>
                    </asp:ButtonField>
                    <asp:BoundField DataField="ProductID" HeaderText="ProductID" />
                    <asp:BoundField DataField="ProductName" HeaderText="ProductName" />
                    <asp:BoundField DataField="ProductPrice" HeaderText="ProductPrice" />
                    
                </Columns>
            </asp:GridView>
            <asp:Button ID="btnAdd" runat="server" Text="Add New Record" CssClass="btn btn-info" OnClick="btnAdd_Click" />
        </ContentTemplate>
        <Triggers>
        </Triggers>
    </asp:UpdatePanel>
    <!-- Detail Modal Starts here-->
    <div id="detailModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
            <h3 id="myModalLabel">Detailed View</h3>
        </div>
        <div class="modal-body">
            <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                <ContentTemplate>
                    <asp:DetailsView ID="DetailsView1" runat="server" CssClass="table table-bordered table-hover" BackColor="White" ForeColor="Black" FieldHeaderStyle-Wrap="false" FieldHeaderStyle-Font-Bold="true" FieldHeaderStyle-BackColor="LavenderBlush" FieldHeaderStyle-ForeColor="Black" BorderStyle="Groove" AutoGenerateRows="False">
                        <Fields>
                            <asp:BoundField DataField="ProductID" HeaderText="ProductID" />
                            <asp:BoundField DataField="ProductName" HeaderText="ProductName" />
                            <asp:BoundField DataField="ProductPrice" HeaderText="ProductPrice" />
                        </Fields>
                    </asp:DetailsView>
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="GridView1" EventName="RowCommand" />
                    <asp:AsyncPostBackTrigger ControlID="btnAdd" EventName="Click" />
                </Triggers>
            </asp:UpdatePanel>
            <div class="modal-footer">
                <button class="btn btn-info" data-dismiss="modal" aria-hidden="true">Close</button>
            </div>
        </div>
    </div>
    <!-- Detail Modal Ends here -->
    <!-- Edit Modal Starts here -->
    <div id="editModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="editModalLabel" aria-hidden="true">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
            <h3 id="editModalLabel">Edit Record</h3>
        </div>
        <asp:UpdatePanel ID="upEdit" runat="server">
            <ContentTemplate>
              <%--  <div class="modal-body">
                    <table class="table">
                        <tr>
                            <td>Country Code : 
                           
                                <asp:Label ID="lblCountryCode" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>Population : 
                           
                                <asp:TextBox ID="txtPopulation" runat="server"></asp:TextBox>
                                <asp:Label runat="server" Text="Type Integer Value!" />
                            </td>
                        </tr>
                        <tr>
                            <td>Country Name:
                           
                                <asp:TextBox ID="txtName" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>Continent:
                           
                                <asp:TextBox ID="txtContinent1" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                    </table>
                </div>--%>
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
    <!-- Edit Modal Ends here -->
    <!-- Add Record Modal Starts here-->
    <div id="addModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="addModalLabel" aria-hidden="true">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
            <h3 id="addModalLabel">Add New Record</h3>
        </div>
        <asp:UpdatePanel ID="upAdd" runat="server">
            <ContentTemplate>
                <div class="modal-body">
                    <table class="table table-bordered table-hover">
                        <tr>
                            <td>Country Code : 
                               
                                <asp:TextBox ID="txtCode" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>Country Name : 
                               
                                <asp:TextBox ID="txtCountryName" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>Continent Name:
                               
                                <asp:TextBox ID="txtContinent" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>Region:
                               
                                <asp:TextBox ID="txtRegion" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>Population:
                                   
                                <asp:TextBox ID="txtTotalPopulation" runat="server"></asp:TextBox>
                                <asp:Label ID="Label1" runat="server" Text="Type Integer Value!" />
                            </td>
                        </tr>
                        <tr>
                            <td>Year of Independence
                                       
                                <asp:TextBox ID="txtIndYear" runat="server"></asp:TextBox>
                                <asp:Label ID="Label2" runat="server" Text="Type Integer Value!" />
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
    <!--Add Record Modal Ends here-->
    <!-- Delete Record Modal Starts here-->
    <div id="deleteModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="delModalLabel" aria-hidden="true">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
            <h3 id="delModalLabel">Delete Record</h3>
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
    <!--Delete Record Modal Ends here -->
    <asp:SqlDataSource ID="DropDownSizeData" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
        SelectCommand="SELECT Id, attribute_value FROM Product_Attributes WHERE (Product_Id = @ProductID)">
        <SelectParameters>
            <asp:QueryStringParameter Name="ProductID" QueryStringField="ProductID" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="remCats" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
        SelectCommand="SELECT [name], [categoryID] FROM [Category]" />
</asp:Content>
