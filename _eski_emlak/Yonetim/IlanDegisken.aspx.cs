using System;
using System.Linq;
using System.Web;
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

        using (BaglantiCumlesi db=new BaglantiCumlesi())
        {
            var SQL = from a in db.ilan_degisken
                      where a.UstID == 0
                      orderby a.Baslik ascending
                      select new
                      {
                          a.ID,
                          a.Baslik
                      };

            kategori.DataSource = SQL;
            kategori.DataBind();
        }
    }

    protected void Sayfalama()
    {
        sayfa.Items.Clear();

        int ToplamKayitSayisi = 0;
        using (BaglantiCumlesi db = new BaglantiCumlesi())
        {
            var SQL = db.ilan_degisken.Where(b => b.UstID == 0).Count();
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

        int UstID = int.Parse(kategori.SelectedValue);

        using (BaglantiCumlesi db = new BaglantiCumlesi())
        {
            var SQL = (from a in db.ilan_degisken
                       where a.UstID == UstID
                       orderby a.Baslik ascending
                       select new
                       {
                           a.ID,
                           a.Baslik,
                           a.Onay,
                           DegerSayi = db.ilan_degisken.Where(b => b.UstID == a.ID).Count(),
                           Kategori = db.ilan_degisken.Where(b => b.ID == a.UstID).Select(b => b.Baslik).FirstOrDefault(),
                           a.KayitTarih,
                           a.DegisTarih,
                           Ekleyen = db.kullanici.Where(b => b.ID == a.EkleyenID).Select(b => b.Adi).FirstOrDefault(),
                           Guncelleyen = db.kullanici.Where(b => b.ID == a.GuncelleyenID).Select(b => b.Adi).FirstOrDefault()
                       }).Skip(Limit).Take(int.Parse(kayitsayi.Text));

            Cache["icerik"] = SQL;

            kayitlar.DataSource = SQL;
            kayitlar.DataBind();
        }
    }

    protected void kayitlar_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            switch (e.Row.Cells[3].Text)
            {
                case "1":
                    e.Row.Cells[3].Text = "<img src=\"Image/komut-aktif.png\" />";
                    break;

                case "0":
                    e.Row.Cells[3].Text = "<img src=\"Image/komut-pasif.png\" />";
                    break;
            }

            e.Row.Cells[5].Text = "<a href=\"IlanDegiskenDuzenle.aspx?ID=" + e.Row.Cells[1].Text + "\"><img src=\"Image/komut-duzenle.png\" /></a>";
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
                int ID = int.Parse(kayitlar.DataKeys[satir.RowIndex].Value.ToString());

                using (BaglantiCumlesi db = new BaglantiCumlesi())
                {
                    ilan_degisken TblKullanici = db.ilan_degisken.First(a => a.ID == ID);
                    db.DeleteObject(TblKullanici);
                    db.SaveChanges();
                }
                Yonetim.Olay.Islem("ilan_degisken", "Silindi", ID.ToString());
            }
        }

        KayitYukle("");
    }

    protected void yeniekle_Click(object sender, EventArgs e)
    {
        Response.Redirect("IlanDegiskenEkle.aspx");
    }

    protected void kayitlar_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        System.Threading.Thread.Sleep(100);

        int ID = int.Parse(e.CommandArgument.ToString());

        if (e.CommandName == "Onay")
        {
            using (BaglantiCumlesi db = new BaglantiCumlesi())
            {
                var SQL = from a in db.ilan_degisken where a.ID == ID select new { a.Onay };

                if (SQL.AsEnumerable().Count() > 0)
                {
                    foreach (var item in SQL)
                    {
                        switch (item.Onay)
                        {
                            case 1:
                                using (BaglantiCumlesi dbOnay = new BaglantiCumlesi())
                                {
                                    ilan_degisken TblOnay = dbOnay.ilan_degisken.First(a => a.ID == ID);
                                    TblOnay.Onay = 0;
                                    TblOnay.GuncelleyenID = int.Parse(HttpContext.Current.Request.Cookies["" + Class.Fonksiyonlar.Genel.ParametreAl("GuvenlikKodu") + "KullaniciID"].Value);
                                    TblOnay.DegisTarih = DateTime.Now;
                                    dbOnay.SaveChanges();
                                }
                                break;
                            case 0:
                                using (BaglantiCumlesi dbOnay = new BaglantiCumlesi())
                                {
                                    ilan_degisken TblOnay = dbOnay.ilan_degisken.First(a => a.ID == ID);
                                    TblOnay.Onay = 1;
                                    TblOnay.GuncelleyenID = int.Parse(HttpContext.Current.Request.Cookies["" + Class.Fonksiyonlar.Genel.ParametreAl("GuvenlikKodu") + "KullaniciID"].Value);
                                    TblOnay.DegisTarih = DateTime.Now;
                                    dbOnay.SaveChanges();
                                }
                                break;
                        }
                        Yonetim.Olay.Islem("ilan_degisken", "Güncellendi", ID.ToString());
                    }
                }
            }
        }

        if (e.CommandName == "Sil")
        {
            using (BaglantiCumlesi db = new BaglantiCumlesi())
            {
                ilan_degisken TblSil = db.ilan_degisken.First(a => a.ID == ID);
                db.DeleteObject(TblSil);
                db.SaveChanges();
            }
            Yonetim.Olay.Islem("ilan_degisken", "Silindi", ID.ToString());
        }

        KayitYukle("");
    }

    protected void kategorisec(object sender, EventArgs e)
    {
        System.Threading.Thread.Sleep(100);
        KayitYukle("");
    }

    protected void btn_sabit_adi_ekle_Click(object sender, EventArgs e)
    {
        try
        {
            using (BaglantiCumlesi db = new BaglantiCumlesi())
            {
                ilan_degisken TblEkle = new ilan_degisken();
                TblEkle.UstID = 0;
                TblEkle.Baslik = form_degeradi.Text;
                TblEkle.Onay = 1;
                TblEkle.EkleyenID = int.Parse(HttpContext.Current.Request.Cookies["" + Class.Fonksiyonlar.Genel.ParametreAl("GuvenlikKodu") + "KullaniciID"].Value);
                TblEkle.KayitTarih = DateTime.Now;
                db.AddToilan_degisken(TblEkle);
                db.SaveChanges();
            }

            Yonetim.Olay.Islem("ilan_degisken", "Yeni Kayıt", "");
            Class.Fonksiyonlar.JavaScript.MesajKutusuVeYonlendir("İlan değişken kategorisi başarıyla eklenmiştir. İlan değişkenleri listesine yönlendiriliyorsunuz.", "IlanDegisken.aspx");
        }
        catch (Exception ex)
        {
            Class.Fonksiyonlar.JavaScript.MesajKutusuVeYonlendir(Yonetim.Degiskenler.Hata + ex.Message, "IlanDegisken.aspx");
        }
    }
}