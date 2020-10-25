using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Dynamic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySQLDataModel;
using System.Data;

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
            var SQL = db.ilan.Where(a => a.Arsiv == 1).Count();
            ToplamKayitSayisi = SQL;
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
            var SQL = (from a in db.ilan
                       where a.Arsiv == 1
                       select new
                       {
                           a.ID,
                           a.Baslik,
                           a.Kod,
                           a.IlanTur,
                           a.Onay,
                           a.Vitrin,
                           Il = db.sehir_il.Where(b => b.ID == a.Il).Select(b => b.Baslik).FirstOrDefault(),
                           Ilce = db.sehir_ilce.Where(b => b.ID == a.Ilce).Select(b => b.Baslik).FirstOrDefault(),
                           Semt = db.sehir_semt.Where(b => b.ID == a.Semt).Select(b => b.Baslik).FirstOrDefault(),
                           Kategori = db.kategori.Where(b => b.ID == a.KatID).Select(b => b.Baslik).FirstOrDefault(),
                           a.KayitTarih,
                           a.DegisTarih,
                           Ekleyen = db.kullanici.Where(b => b.ID == a.EkleyenID).Select(b => b.Adi).FirstOrDefault(),
                           Guncelleyen = db.kullanici.Where(b => b.ID == a.GuncelleyenID).Select(b => b.Adi).FirstOrDefault()
                       }).OrderBy(k => k.Kategori).Skip(Limit).Take(int.Parse(kayitsayi.Text));

            Cache["icerik"] = SQL;

            kayitlar.DataSource = SQL;
            kayitlar.DataBind();
        }
    }

    protected void kayitlar_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            switch (e.Row.Cells[9].Text)
            {
                case "1":
                    e.Row.Cells[9].Text = "<img src=\"Image/vitrin-aktif.png\" />";
                    break;

                case "0":
                    e.Row.Cells[9].Text = "<img src=\"Image/vitrin-pasif.png\" />";
                    break;
            }

            switch (e.Row.Cells[10].Text)
            {
                case "1":
                    e.Row.Cells[10].Text = "<img src=\"Image/komut-aktif.png\" />";
                    break;

                case "0":
                    e.Row.Cells[10].Text = "<img src=\"Image/komut-pasif.png\" />";
                    break;
            }

            e.Row.Cells[12].Text = "<a href=\"IlanEkle.aspx?ID=" + e.Row.Cells[1].Text + "\"><img src=\"Image/komut-duzenle.png\" /></a>";
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

    protected void secilenlerisil_Click(object sender, EventArgs e)
    {
        System.Threading.Thread.Sleep(100);

        foreach (GridViewRow satir in kayitlar.Rows)
        {
            CheckBox kutu = (CheckBox)satir.FindControl("secim");
            if (kutu.Checked)
            {
                Yonetim.Islem.IlanSil(int.Parse(kayitlar.DataKeys[satir.RowIndex].Value.ToString()));
            }
        }

        KayitYukle("");
    }

    protected void yeniekle_Click(object sender, EventArgs e)
    {
        Response.Redirect("IlanEkle.aspx");
    }

    protected void kayitlar_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        System.Threading.Thread.Sleep(100);

        int ID = int.Parse(e.CommandArgument.ToString());

        if (e.CommandName == "Onay")
        {
            using (BaglantiCumlesi db = new BaglantiCumlesi())
            {
                var SQL = from a in db.ilan where a.ID == ID select new { a.Onay };

                if (SQL.AsEnumerable().Count() > 0)
                {
                    foreach (var item in SQL)
                    {
                        switch (item.Onay)
                        {
                            case 1:
                                using (BaglantiCumlesi dbOnay = new BaglantiCumlesi())
                                {
                                    ilan TblOnay = dbOnay.ilan.First(a => a.ID == ID);
                                    TblOnay.Onay = 0;
                                    TblOnay.GuncelleyenID = int.Parse(HttpContext.Current.Request.Cookies["" + Class.Fonksiyonlar.Genel.ParametreAl("GuvenlikKodu") + "KullaniciID"].Value);
                                    TblOnay.DegisTarih = DateTime.Now;
                                    dbOnay.SaveChanges();
                                }
                                break;
                            case 0:
                                using (BaglantiCumlesi dbOnay = new BaglantiCumlesi())
                                {
                                    ilan TblOnay = dbOnay.ilan.First(a => a.ID == ID);
                                    TblOnay.Onay = 1;
                                    TblOnay.GuncelleyenID = int.Parse(HttpContext.Current.Request.Cookies["" + Class.Fonksiyonlar.Genel.ParametreAl("GuvenlikKodu") + "KullaniciID"].Value);
                                    TblOnay.DegisTarih = DateTime.Now;
                                    dbOnay.SaveChanges();
                                }
                                break;
                        }
                        Yonetim.Olay.Islem("ilan", "Güncellendi", ID.ToString());
                    }
                }
            }
        }

        if (e.CommandName == "Sil")
        {
            Yonetim.Islem.IlanSil(int.Parse(ID.ToString()));
        }

        KayitYukle("");
    }

    protected void secilenleriarsiv_Click(object sender, EventArgs e)
    {
        System.Threading.Thread.Sleep(100);

        foreach (GridViewRow satir in kayitlar.Rows)
        {
            CheckBox kutu = (CheckBox)satir.FindControl("secim");
            if (kutu.Checked)
            {
                int ID = int.Parse(kayitlar.DataKeys[satir.RowIndex].Value.ToString());

                using (BaglantiCumlesi db = new BaglantiCumlesi())
                {
                    ilan TblKullanici = db.ilan.First(a => a.ID == ID);
                    TblKullanici.Arsiv = 0;
                    TblKullanici.GuncelleyenID = int.Parse(HttpContext.Current.Request.Cookies["" + Class.Fonksiyonlar.Genel.ParametreAl("GuvenlikKodu") + "KullaniciID"].Value);
                    TblKullanici.DegisTarih = DateTime.Now;
                    db.SaveChanges();
                }
                Yonetim.Olay.Islem("ilan", "Güncellendi", ID.ToString());
            }
        }

        KayitYukle("");
    }
}