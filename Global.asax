<%@ Application Language="C#" %>

<%@ Import Namespace="System.Web.Routing" %>

<script runat="server">

    void Application_Start(object sender, EventArgs e)
    {
        //RouteConfig.RegisterRoutes(RouteTable.Routes);
        //BundleConfig.RegisterBundles(BundleTable.Bundles);
        RegisterRoutes(RouteTable.Routes);
    }

    static void RegisterRoutes(RouteCollection routes)
    {
        routes.MapPageRoute("DisplayBlog", "Blogs/{BlogId}/{Slug}.aspx", "~/DisplayBlog.aspx");
    }

</script>
