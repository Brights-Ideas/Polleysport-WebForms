<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
        <header>
            <div class="container">
                <div class="row">
                    <div class="col-lg-12">
                        <div class="intro-text">
                            <img class="img-responsive" src="Content/Images/PolleysportLogo.png" alt="Polleysport Logo">
                            <span class="name"></span>
                            <span class="skills"></span>
                        </div>
                    </div>
                </div>
            </div>
        </header>
</asp:Content>
<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <asp:SqlDataSource ID="sdsProducts" runat="server"
        ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
        SelectCommand="Products_View_Home" SelectCommandType="StoredProcedure" CancelSelectOnNullParameter="False">
    </asp:SqlDataSource>
    <!--<section id="portfolio">-->
        <div class="container">
            <div class="row text-center">
                <asp:Repeater ID="rpProducts" DataSourceID="sdsProducts" runat="server">
                    <ItemTemplate>
                        <div class="col-sm-4 portfolio-item text-center">
                            <div class="thumbnail">
                                <img class="img-responsive" src="<%# Eval("ProductImageURL")%>" alt='<%# Eval("ProductName")%>' />
                                <!-- width="800" height="500"<p>-->
                                <!--<div class="caption">-->
                                    <h3><%# Eval("ProductName") %></h3>
                                <!--<p>
                                    <%# Eval("ProductDescription").ToString().ToTruncatedString(50) %>
                                </p>-->
                                <p>
                                    <a class="btn btn-primary" href='<%# Eval("ProductID", "ProductDetails.aspx?ProductID={0}") %>'>View details</a>
                                </p>
                                <!--</div>-->
                           </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </div>
    <!--</section>-->

</asp:Content>
