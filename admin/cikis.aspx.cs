using System;

namespace emlak.admin
{
    public partial class cikis : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Yonetim.Olay.GirisCikis("Çıkış");
            Class.Fonksiyonlar.Genel.OturumIslemleri.CookieSil();
            Class.Fonksiyonlar.JavaScript.MesajKutusuVeYonlendir("Başarıyla güvenli çıkış yaptınız!", "default.aspx");
        }
    }
}