<%@ Page Language="C#" MasterPageFile="~/AdminPages/Admin.master" AutoEventWireup="true" CodeFile="Users.aspx.cs" Inherits="MemberPages_Users" %>

<%@ Register TagPrefix="dc" TagName="alphalinks" Src="~/Controls/alphalinks.ascx" %>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentBody" runat="Server">

    <div class="applicationWindow span10 offset1">
        <div class="modal-header">Users by Name</div>
        <div class="modal-body">

            User Name filter:
            <dc:alphalinks runat="server" id="Alphalinks" />

            <asp:GridView runat="server" ID="Users" AutoGenerateColumns="false" CssClass="table table-striped"
                GridLines="none">
                <Columns>
                    <asp:TemplateField>
                        <HeaderTemplate>User Name</HeaderTemplate>
                        <ItemTemplate>
                            <a href="edit_user.aspx?username=<%# Eval("UserName") %>"><%# Eval("UserName") %></a>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="email" ControlStyle-BackColor="Purple" HeaderText="Email" />
                    <asp:BoundField DataField="comment" HeaderText="Comments" />
                    <asp:BoundField DataField="creationdate" HeaderText="Creation Date" />
                    <asp:BoundField DataField="lastlogindate" HeaderText="Last Login Date" />
                    <asp:BoundField DataField="lastactivitydate" HeaderText="Last Activity Date" />
                    <asp:BoundField DataField="isapproved" HeaderText="Is Active" />
                    <asp:BoundField DataField="isonline" HeaderText="Is Online" />
                    <asp:BoundField DataField="islockedout" HeaderText="Is Locked Out" />
                </Columns>
            </asp:GridView>

        </div>
    </div>
</asp:Content>
