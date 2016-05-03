<%@ Control Language="C#" AutoEventWireup="true" CodeFile="PagingControl.ascx.cs" Inherits="Controls_PagingControl" %>


<ul class="pager">
    <li>
        <asp:LinkButton runat="server" Text="First" CssClass="btn-default" CommandName="MoveFirst" CommandArgument='<%= CurrentPage %>' ID="btnFirst"></asp:LinkButton></li>
    <li> 
        <asp:LinkButton runat="server" Text="Next" CommandName="MoveNext" CommandArgument='<%= CurrentPage %>' ID="btnNext"></asp:LinkButton></li>
</ul>
<ul class="pagination">
    <li>
        <asp:PlaceHolder runat="server" ID="PagesPlaceHolder"></asp:PlaceHolder>
    </li>
</ul>
<ul class="pager">
    <li>
       <asp:LinkButton runat="server" Text="Prev" CommandName="MovePrev" CommandArgument='<%= CurrentPage %>' ID="btnPrev"></asp:LinkButton></li>
    <li>
        <asp:LinkButton runat="server" Text="Last" CommandName="MoveLast" CommandArgument='<%= CurrentPage %>' ID="btnLast"></asp:LinkButton></li>
</ul>