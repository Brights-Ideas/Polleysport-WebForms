<%@ Page Title="" Language="C#" MasterPageFile="~/AdminPages/Admin.master" AutoEventWireup="true"
    CodeFile="AdminProductsManagement.aspx.cs" Inherits="AdminPages_AdminProductsManagement" %>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentBody" runat="Server">

    <div class="applicationWindow span8 offset1">
        <asp:SqlDataSource ID="prods" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
            SelectCommand="Products_View" SelectCommandType="StoredProcedure" CancelSelectOnNullParameter="false"></asp:SqlDataSource>
        <div class="modal-header">Update products</div>
        <div class="modal-body">
            <asp:Repeater ID="prodRepeater" runat="server">
                <HeaderTemplate>
                </HeaderTemplate>
                <ItemTemplate>
                    <div class="product-container-left">
                        <asp:Label ID="lblProductId" runat="server" Text='<%# Eval("ProductID") %>' Visible="false" />
                        <div class="media">
                            <a class="pull-left" href="#">
                                <img class="media-object" id="ImageContent" alt="" src='../<%# Eval("ProductImageURL") %>' width="130px" height="180px" />
                            </a>
                            <div class="media-body">
                                <h3 class="media-heading">
                                    <asp:Label ID="lblProductName" runat="server" Text='<%# Eval("ProductName") %>' /><%# Eval("ProductName")%> </h3>
                                <%# Eval("ProductDescription")%>
                                <asp:TextBox ID="txtContactName" runat="server" Width="120" Text='<%# Eval("ProductName") %>'
                    Visible="false" />
                            </div>
                            <p>
                                <asp:LinkButton ID="lnkEdit" Text="Edit" runat="server" OnClick="OnEdit" />
                                <asp:LinkButton ID="lnkUpdate" Text="Update" runat="server" Visible="false" OnClick="OnUpdate" />


                                <asp:HyperLink ID="HyperLink2" runat="server" CssClass="btn btn-primary" NavigateUrl='<%# Eval("ProductID", "AdminProducts.aspx?ProductID={0}") %>'>Modify/Add</asp:HyperLink>
                            </p>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
            <table border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse">
                <tr>
                    <td style="width: 150px">Name:<br />
                        <asp:TextBox ID="txtName" runat="server" Width="140" />
                    </td>
                    <td style="width: 150px">Country:<br />
                        <asp:TextBox ID="txtCountry" runat="server" Width="140" />
                    </td>
                    <td style="width: 100px">
                        
                    </td>
                </tr>
            </table>

        </div>
        <div class="modal-footer">
            <div id="pagination" style="display: inline-block">
                <asp:Panel ID="pnlNavigation" runat="server" Visible="false">
                    <asp:Button ID="btnPrev" runat="server" CssClass="button" Text=" << " OnClick="btnPrev_Click" />
                    <asp:Label ID="lblCurrentPage" runat="server"></asp:Label>
                    <asp:Button ID="btnNext" runat="server" CssClass="button" Text=" >> " OnClick="btnNext_Click" />
                </asp:Panel>
            </div>
        </div>
    </div>
</asp:Content>
