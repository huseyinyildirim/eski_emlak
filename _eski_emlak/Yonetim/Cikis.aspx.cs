using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Yonetim_Cikis : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Yonetim.Olay.GirisCikis("Çıkış");
        Class.Fonksiyonlar.Genel.OturumIslemleri.CookieSil();
        Class.Fonksiyonlar.JavaScript.MesajKutusuVeYonlendir("Başarıyla güvenli çıkış yaptınız!", "Default.aspx");
    }
}