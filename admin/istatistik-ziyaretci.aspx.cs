using System;
using System.Linq;
using System.Text;
using System.Web.UI.WebControls;

namespace emlak.admin
{
    public partial class istatistik_ziyaretci : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Class.Fonksiyonlar.Genel.OturumIslemleri.CookieKontrol();

            if (!IsPostBack)
            {
                YuklenecekAlanlar();
                Sayfalama();
                KayitYukle("");
            }
        }

        protected void YuklenecekAlanlar()
        {
            kayitsayi.Items.Clear();
            kayitsayi.Items.Add(new ListItem("10", "10"));
            kayitsayi.Items.Add(new ListItem("20", "20"));
            kayitsayi.Items.Add(new ListItem("30", "30"));
            kayitsayi.Items.Add(new ListItem("50", "50"));
            kayitsayi.Items.Add(new ListItem("75", "75"));
            kayitsayi.Items.Add(new ListItem("100", "100"));
            kayitsayi.Items.Add(new ListItem("125", "125"));
            kayitsayi.Items.Add(new ListItem("150", "150"));

            kayitsayi.Text = Class.Fonksiyonlar.Genel.Parametre().Select(b => b.yonetici_liste_kayit_sayi).FirstOrDefault();
        }

        protected void Sayfalama()
        {
            sayfa.Items.Clear();

            int ToplamKayitSayisi = 0;
            using (BaglantiCumlesi db = new BaglantiCumlesi())
            {
                var SQL = (from a in db.tbl_sayac
                           where a.bot == false
                           group a by a.tarih_ek into g
                           select new
                           {
                               TarihSayi = g.Count()
                           }).AsEnumerable();

                if (SQL.Any())
                {
                    foreach (var item in SQL)
                    {
                        ToplamKayitSayisi = item.TarihSayi;
                    }
                }
            }

            int ToplamSayfaSayisi = 0;

            if ((ToplamKayitSayisi % int.Parse(kayitsayi.Text)) == 0)
            {
                ToplamSayfaSayisi = ToplamKayitSayisi / int.Parse(kayitsayi.Text);
            }
            else
            {
                ToplamSayfaSayisi = (ToplamKayitSayisi / int.Parse(kayitsayi.Text)) + 1;
            }

            for (int i = 1; i <= ToplamSayfaSayisi; i++)
            {
                sayfa.Items.Add(new ListItem(i.ToString(), i.ToString()));
            }
        }

        protected void KayitYukle(string SqlCumle)
        {
            System.Threading.Thread.Sleep(100);

            int Limit;
            if (sayfa.Text == "1")
            {
                Limit = 0;
            }
            else if (sayfa.SelectedValue == "")
            {
                Limit = 0;
            }
            else
            {
                Limit = (int.Parse(sayfa.Text) - 1) * int.Parse(kayitsayi.Text);
            }

            using (BaglantiCumlesi db = new BaglantiCumlesi())
            {
                var SQL = (from a in db.tbl_sayac
                           where a.bot == false
                           group a by a.tarih_ek into g
                           select new
                           {
                               Tarih = g.Key,
                               Tekil = g.Count(),
                               Cogul = g.Sum(p => p.cogul),
                               SayfaGosterim = db.tbl_sayac_sayfa.Where(p => p.tarih_ek == g.Key).Sum(p => p.hit)
                           }).OrderByDescending(p => p.Tarih).Skip(Limit).Take(int.Parse(kayitsayi.Text));

                Cache["icerik"] = SQL;

                kayitlar.DataSource = SQL;
                kayitlar.DataBind();

                if (SQL.Any())
                {
                    StringBuilder sb = new StringBuilder();
                    int i = 1;
                    int KayitSayi = SQL.AsEnumerable().Count();
                    foreach (var item in SQL)
                    {
                        sb.Append("" + item.Tarih.ToShortDateString() + "|" + item.Tekil + "|" + item.Cogul + "");

                        if (KayitSayi == i)
                        {
                            sb.Append("");
                        }
                        else
                        {
                            sb.Append("/");
                            i++;
                        }
                    }

                    grafik.Text = Yonetim.JavaScript.BarPasta(sb.ToString());
                }
            }
        }

        protected void kayitsayisec(object sender, EventArgs e)
        {
            System.Threading.Thread.Sleep(100);
            Sayfalama();
            KayitYukle("");
        }

        protected void sayfasec(object sender, EventArgs e)
        {
            System.Threading.Thread.Sleep(100);
            KayitYukle("");
        }

        protected void kayitlar_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                e.Row.Cells[4].Text = "<a href=\"istatistik-ziyaretci-detay.aspx?Tarih=" + e.Row.Cells[4].Text + "\">Ziyaretçi Detayları</a>";
                e.Row.Cells[5].Text = "<a href=\"istatistik-sayfa-gosterim.aspx?Tarih=" + e.Row.Cells[5].Text + "\">Sayfa Gösterim Detayları</a>";
            }
        }
    }
}