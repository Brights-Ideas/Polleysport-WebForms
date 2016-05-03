using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(Polleymotorsport.Startup))]
namespace Polleymotorsport
{
    public partial class Startup {
        public void Configuration(IAppBuilder app) {
            ConfigureAuth(app);
        }
    }
}
