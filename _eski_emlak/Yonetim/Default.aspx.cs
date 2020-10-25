using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySQLDataModel;

public partial class Yonetim_Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Class.Fonksiyonlar.Genel.OturumIslemleri.CookieKontrol();

        Grafik();
        Uyari();
    }

    protected void Uyari()
    {
        uyarilar.Text = "<br />";
        using (BaglantiCumlesi db=new BaglantiCumlesi())
        {
            uyarilar.Text += "&raquo; <a href=\"IlanOnaysiz.aspx\">" + db.ilan.Where(p => p.Onay == 0).Count() + " adet onay bekleyen ilan bulunmaktadır.</a>";
        }
    }

    protected void Grafik()
    {
        using (BaglantiCumlesi db = new BaglantiCumlesi())
        {
            var SQL = (from a in db.sayac
                       group a by a.Tarih into g
                       select new
                       {

                           Tarih = g.Key,
                           Tekil = g.Count(),
                           Cogul = g.Sum(p => p.Cogul),
                           SayfaGosterim = db.sayac_sayfa.Where(p => p.Tarih == g.Key).Sum(p => p.Hit)
                       }).OrderByDescending(p => p.Tarih);

            if (SQL.AsEnumerable().Count() > 0)
            {
                string Veri = string.Empty;
                int i = 1;
                int KayitSayi = SQL.AsEnumerable().Count();
                foreach (var item in SQL)
                {
                    Veri += "" + item.Tarih.Value.ToShortDateString() + "|" + item.Tekil + "|" + item.Cogul + "";

                    if (KayitSayi == i)
                    {
                        Veri += "";
                    }
                    else
                    {
                        Veri += "/";
                        i++;
                    }
                }

                grafik.Text = Yonetim.JavaScript.BarPasta(Veri);
            }
        }
    }
}