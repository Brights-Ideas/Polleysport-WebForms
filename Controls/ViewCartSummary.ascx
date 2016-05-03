<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ViewCartSummary.ascx.cs" Inherits="ViewCartSummary" %>

<%--<div id="Cart_block">--%>
			<asp:GridView runat="server" ID="gvShoppingCart" AutoGenerateColumns="false" EmptyDataText="There is nothing in your shopping cart." GridLines="None" Width="100%" CellPadding="5" ShowFooter="true" DataKeyNames="ProductId" OnRowDataBound="gvShoppingCart_RowDataBound" OnRowCommand="gvShoppingCart_RowCommand">
				<HeaderStyle HorizontalAlign="Left" BackColor="#BF44BD" ForeColor="#FFFFFF" />
				<FooterStyle HorizontalAlign="Right" BackColor="#BF44BD" ForeColor="#FFFFFF" />
				<AlternatingRowStyle BackColor="#BF44BD" />
				<Columns>
					<asp:BoundField DataField="Description" HeaderText="Description" />
                    <asp:BoundField DataField="Size" HeaderText="Size" />
					<asp:TemplateField HeaderText="Quantity">
						<ItemTemplate>
							<asp:Label runat="server" ID="txtQuantity" Columns="5" Text='<%# Eval("Quantity") %>'></asp:Label><br />
						</ItemTemplate>
					</asp:TemplateField>
					<asp:BoundField DataField="UnitPrice" HeaderText="Price" ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Right" DataFormatString="{0:C}" />
					<asp:BoundField DataField="TotalPrice" HeaderText="Total" Visible="false" ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Right" DataFormatString="{0:C}" />
				</Columns>
			</asp:GridView>
			<br />
            <%--<asp:HyperLink ID="CartLink" runat="server" CssClass="button" BackColor="#BF44BD"
                NavigateUrl="~/UserCart.aspx">Edit Your Cart</asp:HyperLink>--%>
            <asp:HyperLink ID="lnkCheckout" runat="server" CssClass="button" BackColor="#BF44BD"
                NavigateUrl="~/Checkout.aspx">Proceed to checkout</asp:HyperLink><br />
		
        <div style="clear:both;"></div>