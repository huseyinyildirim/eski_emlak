using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySQLDataModel;

public partial class Yonetim_Ascx_ust : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Kayitlar();
    }

    protected void Kayitlar()
    {
        int ID = int.Parse(HttpContext.Current.Request.Cookies["" + Class.Fonksiyonlar.Genel.ParametreAl("GuvenlikKodu") + "KullaniciID"].Value);
        using (BaglantiCumlesi db = new BaglantiCumlesi())
        {
            var SQL = from a in db.kullanici where a.ID == ID select new { a.Adi, a.EPosta };

            if (SQL.AsEnumerable().Count() > 0)
            {
                foreach (var item in SQL)
                {
                    kullaniciadi.Text = item.Adi + " (" + item.EPosta + ")";
                }
            }
        }

        using (BaglantiCumlesi db = new BaglantiCumlesi())
        {
            var SQL = (from a in db.mesaj_kutu where a.AliciID == ID && a.Okundu == 0 select new { a.ID }).Count();

            if (SQL > 0)
            {
                mesaj.Text = "<img src=\"Image/mesajvar.png\" alt=\"" + SQL + " Yeni mesajınız var!\" /> <a href=\"MesajKutu.aspx\">" + SQL + " Yeni mesajınız var!</a>";
            }
            else
            {
                mesaj.Text = "<img src=\"Image/mesaj.png\" alt=\"Hiç mesajınız yok.\" /> <a href=\"MesajKutu.aspx\">Hiç mesajınız yok.</a>";
            }
        }
    }
}