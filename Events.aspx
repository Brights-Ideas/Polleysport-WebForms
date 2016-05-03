<%@ Page Title="Events Page" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Events.aspx.cs" Inherits="_Events" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="Server">

    <asp:SqlDataSource ID="sdsEvents" runat="server"
            ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
            SelectCommand="SELECT * FROM [EVENTS]" CancelSelectOnNullParameter="false"></asp:SqlDataSource>

    
        <div class="modal-header">Polleysport Service Calender</div>

        <section>
            <asp:Repeater ID="rpEvents" DataSourceID="sdsEvents" runat="server">
                <HeaderTemplate>
                    <table class="table table-striped table-hover">
                        <tr>
                            <th>
                                Date
                            </th>
                            <th>
                                Circuit
                            </th>
                            <th>
                                Formula / Club
                            </th>
                        </tr>
                </HeaderTemplate>
                <ItemTemplate>
                    <tr>
                        <td>
                            <asp:Label ID="lblDate" runat="server" Text='<%# Eval("EventDate","{0:dd/MM/yyyy}").ToString() %>'/>
                        </td>
                        <td>
                           <asp:Label ID="lblName" runat="server" Text='<%# Eval("EventName")%>'/>

                        </td>
                        <td>
                            <asp:Label ID="lblClub" runat="server" Text='<%# Eval("EventClub")%>'/>
                        </td>
                    </tr>
                </ItemTemplate>
                <FooterTemplate>
                    </table>
                </FooterTemplate>
            </asp:Repeater> 
        </section>

</asp:Content>