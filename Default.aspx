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
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
    <script type="text/javascript">
        $(function () {
            GetProducts(1);
        });

        //$("[id*=txtSearch]").live("keyup", function () {
        //GetCustomers(parseInt(1));
        //});
        $("#btnSearch")
            .click(function () {
                GetProducts(parseInt(1));
            });

        $(".Pager .page").live("click", function () {
            GetProducts(parseInt($(this).attr('page')));
        });

        function SearchTerm() {
            return jQuery.trim($("[id*=txtSearch]").val());
        };

        function GetProducts(pageIndex) {
            $.ajax({
                type: "POST",
                url: "Default.aspx/GetProducts",
                data: '{searchTerm: "' + SearchTerm() + '", pageIndex: ' + pageIndex + '}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: OnSuccess,
                failure: function (response) {
                    alert(response.d);
                },
                error: function (response) {
                    alert(response.d);
                }
            });

        }

        function OnSuccess(response) {
            var xmlDoc = $.parseXML(response.d);
            var xml = $(xmlDoc);
            var products = xml.find("Table");
            var repeater = $("#dvCustomers #product-item").eq(0).clone(true);
            $("#dvCustomers #product-item").eq(0).remove();
            products.each(function () {
                var product = $(this);
                $(".name", repeater).html(product.find("ProductName").text());
                $("img.product-image", repeater).attr("src", product.find("ProductImageURL").text());
                //$(".description", table).html(product.find("ProductDescription").text());
                $(".btn-primary", repeater).attr("href", "ProductDetails.aspx?ProductID=" + product.find("ProductID").text());
                $("#dvCustomers").append(repeater);//.append("<br />");
                repeater = $("#dvCustomers #product-item").eq(0).clone(true);
            });
        }
    </script>
    <%--    <asp:SqlDataSource ID="sdsProducts" runat="server"
        ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
        SelectCommand="Products_View_Home" SelectCommandType="StoredProcedure" CancelSelectOnNullParameter="False"></asp:SqlDataSource>--%>
    <!--<section id="portfolio">-->


    <form id="form1" runat="server">
        <div class="container">
            <div class="row">
                <div class="col-lg-4 pull-right">
                <div class="input-group">
                    <asp:TextBox ID="txtSearch" runat="server" placeholder="Search Product.." CssClass="form-control" />
                    <span class="input-group-btn">
                        <asp:Button ID="btnSearch" runat="server" CssClass="btn btn-primary" Text="Search" />
                    </span>
                </div>
            </div>
            </div>
            <hr/>
            <div class="row text-center">
                <div id="dvCustomers">
                    <asp:Repeater ID="rpProducts" runat="server">
                        <ItemTemplate>
                            <div id="product-item" class="col-sm-4 portfolio-item text-center">
                                <div class="thumbnail">
                                    <img class="img-responsive product-image" src="<%# Eval("ProductImageURL")%>" alt='<%# Eval("ProductName")%>' />
                                    <h3><span class="name"><%# Eval("ProductName") %></span></h3>
                                    <%--<span class="description"><%# Eval("ProductDescription").ToString().ToTruncatedString(50) %></span>--%>
                                    <p><a class="btn btn-primary" href='<%# Eval("ProductID", "ProductDetails.aspx?ProductID={0}") %>'>View details</a></p>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
                <%--<div class="Pager"></div>--%>
            </div>

        </div>

    </form>

    <!--</section>-->
</asp:Content>