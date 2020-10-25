using System;
using System.Linq;
using System.Web.UI.WebControls;
using MySQLDataModel;

public partial class Yonetim_Kullanici : System.Web.UI.Page
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

        kayitsayi.Text = Class.Fonksiyonlar.Genel.ParametreAl("YoneticiListeKayitSayi");
    }

    protected void Sayfalama()
    {
        sayfa.Items.Clear();

        int ToplamKayitSayisi = 0;
        using (BaglantiCumlesi db = new BaglantiCumlesi())
        {
            var SQL = from a in db.sayac where a.Bot == 0 group a by a.Tarih into g select new { TarihSayi = g.Count() };
            if (SQL.AsEnumerable().Count() > 0)
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
            var SQL = (from a in db.sayac
                       where a.Bot == 0
                       group a by a.Tarih into g
                       select new
                       {

                           Tarih = g.Key,
                           Tekil = g.Count(),
                           Cogul = g.Sum(p => p.Cogul),
                           SayfaGosterim = db.sayac_sayfa.Where(p => p.Tarih == g.Key).Sum(p => p.Hit)
                       }).OrderByDescending(p => p.Tarih).Skip(Limit).Take(int.Parse(kayitsayi.Text));

            Cache["icerik"] = SQL;

            kayitlar.DataSource = SQL;
            kayitlar.DataBind();

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
            e.Row.Cells[4].Text = "<a href=\"IstatistikZiyaretciDetay.aspx?Tarih=" + e.Row.Cells[4].Text + "\">Ziyaretçi Detayları</a>";
            e.Row.Cells[5].Text = "<a href=\"IstatistikSayfaGosterim.aspx?Tarih=" + e.Row.Cells[5].Text + "\">Sayfa Gösterim Detayları</a>";
        }
    }
}