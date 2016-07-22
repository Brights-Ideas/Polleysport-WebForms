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
            GetCustomers(1);
        });

        $("[id*=txtSearch]").live("keyup", function () {
            GetCustomers(parseInt(1));
        });

        $(".Pager .page").live("click", function () {
            GetCustomers(parseInt($(this).attr('page')));
        });

        function SearchTerm() {
            return jQuery.trim($("[id*=txtSearch]").val());
        };

        function GetCustomers(pageIndex) {
            $.ajax({
                type: "POST",
                url: "Default.aspx/GetCustomers",
                data: '{searchTerm: "' + SearchTerm() + '", pageIndex: ' + pageIndex + '}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: OnSuccess,
                failure: function(response) {
                    alert(response.d);
                },
                error: function(response) {
                    alert(response.d);
                }
            });
            
        }

        function OnSuccess(response) {
            var xmlDoc = $.parseXML(response.d);
            var xml = $(xmlDoc);
            var customers = xml.find("Table");
            var table = $("#dvCustomers #product-item").eq(0).clone(true);
            $("#dvCustomers #product-item").eq(0).remove();
            customers.each(function () {
                var customer = $(this);
                $(".name", table).html(customer.find("ProductName").text());
                $("img.product-image", table).attr("src", customer.find("ProductImageURL").text());
                $(".description", table).html(customer.find("ProductDescription").text());
                $("#dvCustomers").append(table);//.append("<br />");
                table = $("#dvCustomers #product-item").eq(0).clone(true);
            });
        }
    </script>
<%--    <asp:SqlDataSource ID="sdsProducts" runat="server"
        ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
        SelectCommand="Products_View_Home" SelectCommandType="StoredProcedure" CancelSelectOnNullParameter="False"></asp:SqlDataSource>--%>
    <!--<section id="portfolio">-->
    <div class="container">
        <div class="row text-center">
            <form id="form1" runat="server">

                <div class="input-group">
                    <asp:TextBox ID="txtSearch" runat="server" placeholder="Search Product.." CssClass="form-control" />
                   <%-- <span class="input-group-btn">
                        <asp:Button ID="btnSearch" runat="server" CssClass="btn btn-primary" Text="Search" />
                    </span>--%>
                </div>
                <hr />
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
                <div class="Pager"></div>
            </form>

        </div>
    </div>
    <!--</section>-->
</asp:Content>