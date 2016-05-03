<%@ Control Language="C#" AutoEventWireup="true" CodeFile="CartControl.ascx.cs" Inherits="CartControl" %>

<h2>Shopping Cart</h2>
<hr class="star-primary">
<asp:GridView runat="server" CssClass="table table-striped" ID="gvShoppingCart" AutoGenerateColumns="false"
                Width="100%" ShowFooter="true" DataKeyNames="ProductId" 
                OnRowDataBound="gvShoppingCart_RowDataBound" OnRowCommand="gvShoppingCart_RowCommand">
				<HeaderStyle HorizontalAlign="Left" />
				<FooterStyle HorizontalAlign="Right"/>
				<AlternatingRowStyle BackColor="#DDDDDD" />
				<Columns>
					<asp:BoundField DataField="Name" HeaderText="Name" />
                    <asp:BoundField DataField="Size" HeaderText="Size" />
					<asp:TemplateField HeaderText="Quantity">
						<ItemTemplate>
                        <asp:Label runat="server" ID="lblSizeId" Text='<%# Eval("SizeId") %>' Visible="false"></asp:Label>
							<asp:TextBox runat="server" ID="txtQuantity" Columns="5" Text='<%# Eval("Quantity") %>'></asp:TextBox>
							<asp:LinkButton CssClass="btn btn-primary btn-xs" runat="server" ID="btnRemove" Text="Remove" CausesValidation="false" CommandName="Remove" CommandArgument='<%#Eval("ProductId") + ";" +Eval("SizeId")%>' style="font-size:12px;"></asp:LinkButton>
						</ItemTemplate>
					</asp:TemplateField>
					<asp:BoundField DataField="UnitPrice" HeaderText="Price" HeaderStyle-HorizontalAlign="Right" DataFormatString="{0:C}" />
					<asp:BoundField DataField="TotalPrice" HeaderText="Total" HeaderStyle-HorizontalAlign="Right" DataFormatString="{0:C}" />
				</Columns>
                <EmptyDataTemplate>
                    <div class="alert alert-info">
                    <h3>No Items In Cart</h3>
                        <a href="Default.aspx">< Back to Products</a>
                    </div>
                </EmptyDataTemplate>
			</asp:GridView>

<asp:Panel ID="plnCosts" Visible="true" runat="server">
            
                <ul class="list-group">
                    <li class="list-group-item"><asp:Label ID="Shipping" runat="server"></asp:Label></li>
                    <li class="list-group-item"><asp:Label ID="VatTotal" runat="server"></asp:Label></li>
                    <li class="list-group-item"><asp:Label ID="Total" runat="server"></asp:Label></li>
                  </ul>
            
            </asp:Panel>

<asp:Panel ID="plnProcess" Visible="true" runat="server">
    <asp:Button runat="server" ID="btnUpdateCart" CausesValidation="false" Text="Update Cart" CssClass="pull-left btn btn-primary" OnClick="btnUpdateCart_Click" />
    <asp:HyperLink ID="continue_shopping" runat="server" CssClass="btn btn-primary" NavigateUrl="../products.aspx">Continue Shopping </asp:HyperLink>
    <%-- World pay payment button - currently displaying test link --%>
    <asp:HyperLink ID="process_payment" runat="server" CssClass="pull-right btn btn-primary" NavigateUrl="../processPayment.aspx">Checkout </asp:HyperLink>
</asp:Panel>