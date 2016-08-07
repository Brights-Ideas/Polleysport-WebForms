<%@ Page Title="" Language="C#" MasterPageFile="~/AdminPages/Admin.master" AutoEventWireup="true"
    CodeFile="AdminGalleryManagement.aspx.cs" Inherits="AdminPages_AdminGalleryManagement" %>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentBody" runat="Server">
    <asp:SqlDataSource ID="sdsGallery" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
        SelectCommand="Gallery_view_search" FilterExpression="GalleryTitle LIKE '%{0}%'" SelectCommandType="StoredProcedure"
        CancelSelectOnNullParameter="False">
        <FilterParameters>
            <asp:ControlParameter Name="Title" ControlID="txtSearch" PropertyName="Text" />
        </FilterParameters>
    </asp:SqlDataSource>

    <asp:ScriptManager runat="server" ID="ScriptManager1" />
    <div class="page-header">
        <h1>Gallery Management <small>Admin section</small></h1>
    </div>
    <!-- Placing GridView in UpdatePanel-->
    <asp:UpdatePanel ID="upCrudGrid" runat="server">
        <ContentTemplate>
            <div class="panel panel-default">
                <div class="panel-heading">Gallery management</div>
                <div class="panel-body">
                    <asp:Button ID="btnAdd" runat="server" Text="Add New Gallery Item" CssClass="btn btn-info" OnClick="btnAdd_Click" />

                    <div class="col-lg-4 pull-right">
                        <div class="input-group">
                            <asp:TextBox ID="txtSearch" runat="server" placeholder="Search Gallery.." CssClass="form-control" />
                            <span class="input-group-btn">
                                <asp:Button ID="btnSearch" OnClick="btnSearch_Click" runat="server" CssClass="btn btn-primary" Text="Search" />
                            </span>
                        </div>
                        <!-- /input-group -->
                    </div>
                </div>
            </div>
            <asp:GridView ID="GridView1" runat="server" HorizontalAlign="Center"
                OnRowCommand="GridView1_RowCommand" AutoGenerateColumns="false" AllowPaging="true"
                OnPageIndexChanging="OnPageIndexChanging" PageSize="10" DataKeyNames="GalleryID" CssClass="table table-hover table-striped">
                <Columns>
                    <asp:ButtonField CommandName="editRecord" ControlStyle-CssClass="btn btn-info"
                        ButtonType="Button" Text="Edit" HeaderText="Edit Record">
                        <ControlStyle CssClass="btn btn-info"></ControlStyle>
                    </asp:ButtonField>
                    <asp:ButtonField CommandName="deleteRecord" ControlStyle-CssClass="btn btn-info"
                        ButtonType="Button" Text="Delete" HeaderText="Delete Record">
                        <ControlStyle CssClass="btn btn-info"></ControlStyle>
                    </asp:ButtonField>

                    <asp:BoundField DataField="GalleryID" HeaderText="Id" />
                    <asp:BoundField DataField="GalleryTitle" HeaderText="Name" />
                    <asp:BoundField DataField="GalleryContent" HeaderText="Description" />
                    <asp:ImageField HeaderText="Image" DataImageUrlField="GalleryImageUrl" ControlStyle-Height="200px" ControlStyle-Width="200px" DataImageUrlFormatString="~\GalleryImages\{0}" />
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
                                <asp:Label ID="lblId" CssClass="col-sm-2 control-label" AssociatedControlID="lblGalleryID" runat="server" Text="Id" />
                                <div class="col-sm-10">
                                    <asp:Label ID="lblGalleryID" CssClass="form-control-static" runat="server" Text="productID" />
                                </div>
                            </div>
                            <div class="form-group">
                                <asp:Label ID="lblgalleryTitle" CssClass="col-sm-2 control-label" AssociatedControlID="txtgalleryTitle" runat="server" Text="Name " />
                                <div class="col-sm-10">
                                    <asp:TextBox ID="txtgalleryTitle" CssClass="form-control" runat="server" />
                                </div>
                            </div>
                            <div class="form-group">
                                <asp:Label ID="prodDesc" CssClass="col-sm-2 control-label" AssociatedControlID="txtXtext" runat="server" Text="Description" />
                                <div class="col-sm-10">
                                    <asp:TextBox ID="txtXtext" Rows="8" TextMode="MultiLine" CssClass="form-control" runat="server" />

                                    <asp:RegularExpressionValidator ID="regexDescriptionValid" runat="server" ControlToValidate="txtXtext"
                                        ErrorMessage="HTML charactors found in description remove these before saving" ValidationExpression="/?\w+\s+[^>]*" Display="Dynamic" ForeColor="Red"></asp:RegularExpressionValidator>
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
                                <asp:Label ID="prodEnabled" CssClass="col-sm-2 control-label" AssociatedControlID="rblProductActive" runat="server" Text="Active" />
                                <div class="col-sm-10">
                                    <asp:RadioButtonList ID="rblProductActive" runat="server">
                                        <asp:ListItem Text="Enabled" Value="1" />
                                        <asp:ListItem Text="Disabled" Value="0" />
                                    </asp:RadioButtonList>
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

                        <asp:PostBackTrigger ControlID="btnSave" />
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
                            <div class="modal-body">
                                <div class="form-group">
                                    <label class="col-sm-2 control-label" for="txtGalleryName">Gallery Title</label>
                                    <div class="col-sm-10">
                                        <asp:TextBox ID="txtGalleryName" CssClass="form-control" runat="server" />
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label" for="txtDescription">Description</label>
                                    <div class="col-sm-10">
                                        <asp:TextBox ID="txtDescription" Rows="8" TextMode="MultiLine" CssClass="form-control" runat="server" />

                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtXtext"
                                            ErrorMessage="HTML charactors found in description remove these before saving" ValidationExpression="/?\w+\s+[^>]*" Display="Dynamic" ForeColor="Red"></asp:RegularExpressionValidator>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <img alt="Upload Image" class="col-sm-2" runat="server" src="../Content/Images/uploadphoto.png" />
                                    <div class="col-sm-10">
                                        <asp:FileUpload ID="insertUploadPicture" runat="server"></asp:FileUpload>
                                        <asp:HiddenField ID="ImageURL" runat="server" Value="" />
                                    </div>
                                </div>
                            </div>

                        </div>
                        <div class="modal-footer">
                            <asp:Button ID="btnAddRecord" runat="server" Text="Add" CssClass="btn btn-info" OnClick="btnAddRecord_Click" />
                            <button class="btn btn-info" data-dismiss="modal" aria-hidden="true">Close</button>
                        </div>
                    </ContentTemplate>
                    <Triggers>

                        <asp:PostBackTrigger ControlID="btnAddRecord" />
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
                           
                        <asp:HiddenField ID="hfGalleryID" runat="server" />
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

</asp:Content>
