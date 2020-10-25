using System;
using System.Linq;

namespace emlak.admin
{
    public partial class _default : System.Web.UI.Page
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
            using (BaglantiCumlesi db = new BaglantiCumlesi())
            {
                uyarilar.Text += "&raquo; <a href=\"ilan-onaysiz.aspx\">" + db.tbl_ilan.Where(p => p.onay == false).Count() + " adet onay bekleyen ilan bulunmaktadır.</a>";
            }
        }

        protected void Grafik()
        {
            using (BaglantiCumlesi db = new BaglantiCumlesi())
            {
                var SQL = (from a in db.tbl_sayac
                           group a by a.tarih_ek into g
                           select new
                           {

                               Tarih = g.Key,
                               Tekil = g.Count(),
                               Cogul = g.Sum(p => p.cogul),
                               SayfaGosterim = db.tbl_sayac_sayfa.Where(p => p.tarih_ek == g.Key).Sum(p => p.hit)
                           }).OrderByDescending(p => p.Tarih);

                if (SQL.Any())
                {
                    string Veri = string.Empty;
                    int i = 1;
                    int KayitSayi = SQL.AsEnumerable().Count();
                    foreach (var item in SQL)
                    {
                        Veri += "" + item.Tarih.ToShortDateString() + "|" + item.Tekil + "|" + item.Cogul + "";

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
}