using System;

namespace emlak
{
    public class Global : System.Web.HttpApplication
    {

        protected void Application_Start(object sender, EventArgs e)
        {
            System.Web.Routing.RouteTable.Routes.Add("sayfa", new System.Web.Routing.Route("sayfa/{SayfaID}/{SayfaAdi}", new System.Web.Routing.PageRouteHandler("~/Sayfa.aspx")));
            System.Web.Routing.RouteTable.Routes.Add("ilan", new System.Web.Routing.Route("ilan/{IlanID}/{IlanAdi}", new System.Web.Routing.PageRouteHandler("~/Ilan.aspx")));
            System.Web.Routing.RouteTable.Routes.Add("kategori", new System.Web.Routing.Route("kategori/{KategoriID}/{KategoriAdi}", new System.Web.Routing.PageRouteHandler("~/Kategori.aspx")));
        }

        protected void Session_Start(object sender, EventArgs e)
        {

        }

        protected void Application_BeginRequest(object sender, EventArgs e)
        {

        }

        protected void Application_AuthenticateRequest(object sender, EventArgs e)
        {

        }

        protected void Application_Error(object sender, EventArgs e)
        {

        }

        protected void Session_End(object sender, EventArgs e)
        {

        }

        protected void Application_End(object sender, EventArgs e)
        {

        }
    }
}