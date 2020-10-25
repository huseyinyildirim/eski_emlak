using System;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySQLDataModel;

public partial class Yonetim_Kullanici : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Class.Fonksiyonlar.Genel.OturumIslemleri.CookieKontrol();

        if (!Page.IsPostBack)
        {
            Il_Yukle();
            Kayitlar();
        }
    }

    protected void btn_devam_Click(object sender, EventArgs e)
    {
        try
        {
            if (Request.QueryString["ID"] != null && Class.Fonksiyonlar.Genel.NumerikKontrol(Request.QueryString["ID"].ToString()))
            {
                int ID = int.Parse(Request.QueryString["ID"].ToString());

                using (BaglantiCumlesi db = new BaglantiCumlesi())
                {
                    var SQL = from a in db.ilan where a.ID == ID select new { a.KatID };
                    if (SQL.AsEnumerable().Count() > 0)
                    {
                        foreach (var item in SQL)
                        {
                            if (form_katid.SelectedValue != item.KatID.ToString())
                            {
                                using (BaglantiCumlesi db2 = new BaglantiCumlesi())
                                {
                                    var SQL2 = from a in db.ilan_detay where a.IlanID == ID select a;
                                    foreach (var item2 in SQL2)
                                    {
                                        db2.ilan_detay.DeleteObject(item2);
                                    }
                                    db2.SaveChanges();
                                }
                            }
                        }
                    }
                }
                using (BaglantiCumlesi db = new BaglantiCumlesi())
                {
                    ilan Tbl = db.ilan.First(a => a.ID == ID);
                    Tbl.IlanTur = form_ilantur.SelectedValue;
                    Tbl.KatID = int.Parse(form_katid.SelectedValue);
                    Tbl.Kod = Class.Fonksiyonlar.Genel.SQLTemizle(form_ilankod.Text);
                    Tbl.Baslik = Class.Fonksiyonlar.Genel.SQLTemizle(form_ilanbaslik.Text);
                    Tbl.Fiyat = int.Parse(form_fiyat.Text.Replace(".", "").Replace(",", "").Replace("-", "").Replace("#", ""));
                    Tbl.FiyatTur = form_fiyattur.SelectedValue;
                    Tbl.IlanSure = int.Parse(form_ilansure.SelectedValue);
                    Tbl.Il = int.Parse(form_il.SelectedValue);
                    if (form_ilce.SelectedValue != "0")
                    {
                        Tbl.Ilce = int.Parse(form_ilce.SelectedValue);
                    }
                    if (form_semt.SelectedValue != "0")
                    {
                        Tbl.Semt = int.Parse(form_semt.SelectedValue);
                    }
                    Tbl.Mevki = Class.Fonksiyonlar.Genel.SQLTemizle(form_mevki.Text);
                    Tbl.Adres = Class.Fonksiyonlar.Genel.SQLTemizle(form_adres.Text);
                    Tbl.AdresGoster = int.Parse(form_adresgoster.SelectedValue);
                    Tbl.Satis = int.Parse(form_satis.SelectedValue);
                    Tbl.Vitrin = int.Parse(form_vitrin.SelectedValue);
                    Tbl.Onay = int.Parse(form_onay.SelectedValue);
                    Tbl.Arsiv = 0;
                    Tbl.GuncelleyenID = int.Parse(HttpContext.Current.Request.Cookies["" + Class.Fonksiyonlar.Genel.ParametreAl("GuvenlikKodu") + "KullaniciID"].Value);
                    Tbl.DegisTarih = DateTime.Now;
                    db.SaveChanges();
                }
                Yonetim.Olay.Islem("ilan", "Güncellendi", ID.ToString());
                Response.Redirect("IlanEkle2.aspx?ID=" + Request.QueryString["ID"] + "");
            }
            else
            {
                using (BaglantiCumlesi db = new BaglantiCumlesi())
                {
                    ilan Tbl = new ilan();
                    Tbl.IlanTur = form_ilantur.SelectedValue;
                    Tbl.KatID = int.Parse(form_katid.SelectedValue);
                    Tbl.Kod = Class.Fonksiyonlar.Genel.SQLTemizle(form_ilankod.Text);
                    Tbl.Baslik = Class.Fonksiyonlar.Genel.SQLTemizle(form_ilanbaslik.Text);
                    Tbl.Fiyat = int.Parse(form_fiyat.Text);
                    Tbl.FiyatTur = form_fiyattur.SelectedValue;
                    Tbl.IlanSure = int.Parse(form_ilansure.SelectedValue);
                    Tbl.Il = int.Parse(form_il.SelectedValue);
                    if (form_ilce.SelectedValue != "0")
                    {
                        Tbl.Ilce = int.Parse(form_ilce.SelectedValue);
                    }
                    if (form_semt.SelectedValue != "0")
                    {
                        Tbl.Semt = int.Parse(form_semt.SelectedValue);
                    }
                    Tbl.Mevki = Class.Fonksiyonlar.Genel.SQLTemizle(form_mevki.Text);
                    Tbl.Adres = Class.Fonksiyonlar.Genel.SQLTemizle(form_adres.Text);
                    Tbl.AdresGoster = int.Parse(form_adresgoster.SelectedValue);
                    Tbl.Satis = int.Parse(form_satis.SelectedValue);
                    Tbl.Vitrin = int.Parse(form_vitrin.SelectedValue);
                    Tbl.Koordinat = "39.368279, 35.657959";
                    Tbl.Onay = 0;
                    Tbl.Arsiv = 0;
                    Tbl.EkleyenID = int.Parse(HttpContext.Current.Request.Cookies["" + Class.Fonksiyonlar.Genel.ParametreAl("GuvenlikKodu") + "KullaniciID"].Value);
                    Tbl.KayitTarih = DateTime.Now;
                    db.AddToilan(Tbl);
                    db.SaveChanges();
                }
                Yonetim.Olay.Islem("ilan", "Yeni Kayıt", "");

                using (BaglantiCumlesi db = new BaglantiCumlesi())
                {
                    var SQL = (from a in db.ilan orderby a.ID descending select new { a.ID }).Take(1);

                    if (SQL.AsEnumerable().Count() > 0)
                    {
                        foreach (var item in SQL)
                        {
                            Response.Redirect("IlanEkle2.aspx?ID=" + item.ID + "");
                        }
                    }
                }
            }
        }
        catch (Exception ex)
        {
            Class.Fonksiyonlar.JavaScript.MesajKutusuVeYonlendir(Yonetim.Degiskenler.Hata + ex.Message, "IlanEkle.aspx");
        }
    }

    protected void Il_Yukle()
    {
        using (BaglantiCumlesi db = new BaglantiCumlesi())
        {
            var SQL = from a in db.sehir_il where a.Onay == 1 orderby a.Baslik ascending select new { a.ID, a.Baslik };
            if (SQL.AsEnumerable().Count() > 0)
            {
                form_il.Items.Add(new ListItem("« Lütfen İl Seçiniz »", "0"));
                foreach (var item in SQL)
                {
                    form_il.Items.Add(new ListItem(item.Baslik, item.ID.ToString()));
                }
            }
        }
    }

    protected void Ilce_Yukle(string ID)
    {
        form_semt.Items.Clear();
        form_ilce.Items.Clear();

        int IlID = int.Parse(ID);
        using (BaglantiCumlesi db = new BaglantiCumlesi())
        {
            var SQL = from a in db.sehir_ilce where a.IlID == IlID && a.Onay == 1 orderby a.Baslik ascending select new { a.ID, a.Baslik };
            if (SQL.AsEnumerable().Count() > 0)
            {
                form_semt.Enabled = false;
                form_ilce.Enabled = true;
                form_ilce.Items.Add(new ListItem("« Lütfen İlçe Seçiniz »", "0"));
                foreach (var item in SQL)
                {
                    form_ilce.Items.Add(new ListItem(item.Baslik, item.ID.ToString()));
                }
            }
        }
    }

    protected void Semt_Yukle(string ID)
    {
        form_semt.Enabled = false;
        form_semt.Items.Clear();
        int IlceID = int.Parse(ID);
        using (BaglantiCumlesi db = new BaglantiCumlesi())
        {
            var SQL = from a in db.sehir_semt where a.IlceID == IlceID && a.Onay == 1 orderby a.Baslik ascending select new { a.ID, a.Baslik };
            if (SQL.AsEnumerable().Count() > 0)
            {
                form_semt.Enabled = true;
                form_semt.Items.Add(new ListItem("« Lütfen Semt Seçiniz »", "0"));
                foreach (var item in SQL)
                {
                    form_semt.Items.Add(new ListItem(item.Baslik, item.ID.ToString()));
                }
            }
        }
    }

    protected void form_il_SelectedIndexChanged(object sender, EventArgs e)
    {
        Ilce_Yukle(form_il.Text);
    }

    protected void form_ilce_SelectedIndexChanged(object sender, EventArgs e)
    {
        Semt_Yukle(form_ilce.Text);
    }

    protected void Kayitlar()
    {
        //İlan kategori
        using (BaglantiCumlesi db = new BaglantiCumlesi())
        {
            var SQL = from a in db.kategori where a.Onay == 1 select new { a.ID, a.Baslik };
            if (SQL.AsEnumerable().Count() > 0)
            {
                form_katid.Items.Add(new ListItem("« Lütfen Seçiniz »", "0"));
                foreach (var item in SQL)
                {
                    form_katid.Items.Add(new ListItem(item.Baslik, item.ID.ToString()));
                }
            }
        }

        //Fiyat türü
        using (BaglantiCumlesi db = new BaglantiCumlesi())
        {
            var SQL = from a in db.ilan_degisken where a.UstID == 1 && a.Onay == 1 select new { a.Baslik, a.Değer };
            if (SQL.AsEnumerable().Count() > 0)
            {
                form_fiyattur.Items.Add(new ListItem("« Lütfen Seçiniz »", "0"));
                foreach (var item in SQL)
                {
                    form_fiyattur.Items.Add(new ListItem(item.Baslik, item.Değer));
                }
            }
        }

        //İlan süresi
        using (BaglantiCumlesi db = new BaglantiCumlesi())
        {
            var SQL = from a in db.ilan_degisken where a.UstID == 6 && a.Onay == 1 select new { a.Baslik, a.Değer };
            if (SQL.AsEnumerable().Count() > 0)
            {
                form_ilansure.Items.Add(new ListItem("« Lütfen Seçiniz »", "0"));
                foreach (var item in SQL)
                {
                    form_ilansure.Items.Add(new ListItem(item.Baslik, item.Değer));
                }
            }
        }

        if (Request.QueryString["ID"] != null && Class.Fonksiyonlar.Genel.NumerikKontrol(Request.QueryString["ID"].ToString()))
        {
            kayit_bilgi.Visible = true;
            int ID = int.Parse(Request.QueryString["ID"].ToString());
            using (BaglantiCumlesi db = new BaglantiCumlesi())
            {
                var SQL = from a in db.ilan where a.ID == ID select a;
                if (SQL.AsEnumerable().Count() > 0)
                {
                    foreach (var item in SQL)
                    {
                        form_ilantur.Text = item.IlanTur;
                        form_katid.Text = item.KatID.ToString();
                        form_ilankod.Text = HttpUtility.HtmlDecode(item.Kod);
                        form_ilanbaslik.Text = HttpUtility.HtmlDecode(item.Baslik);
                        form_fiyat.Text = item.Fiyat.ToString();
                        form_fiyattur.Text = item.FiyatTur;
                        form_ilansure.Text = item.IlanSure.ToString();
                        form_il.Text = item.Il.ToString();
                        Ilce_Yukle(form_il.Text);
                        form_ilce.Text = item.Ilce.ToString();
                        Semt_Yukle(form_ilce.Text);
                        form_semt.Text = item.Semt.ToString();
                        form_mevki.Text = HttpUtility.HtmlDecode(item.Mevki);
                        form_adres.Text = HttpUtility.HtmlDecode(item.Adres);
                        form_adresgoster.Text = item.AdresGoster.ToString();
                        form_vitrin.Text = item.Vitrin.ToString();
                        form_onay.Text = item.Onay.ToString();
                        form_satis.Text = item.Satis.ToString();
                    }
                }
            }

            using (BaglantiCumlesi db = new BaglantiCumlesi())
            {
                var SQL = from a in db.ilan
                          where a.ID == ID
                          select new
                          {
                              a.Kod,
                              a.Baslik,
                              a.KatID,
                              Il = db.sehir_il.Where(b => b.ID == a.Il).Select(b => b.Baslik).FirstOrDefault(),
                              Ilce = db.sehir_ilce.Where(b => b.ID == a.Ilce).Select(b => b.Baslik).FirstOrDefault(),
                              Semt = db.sehir_semt.Where(b => b.ID == a.Semt).Select(b => b.Baslik).FirstOrDefault(),
                              a.KayitTarih,
                              a.DegisTarih,
                              Ekleyen = db.kullanici.Where(b => b.ID == a.EkleyenID).Select(b => b.Adi).FirstOrDefault(),
                              Guncelleyen = db.kullanici.Where(b => b.ID == a.GuncelleyenID).Select(b => b.Adi).FirstOrDefault()

                          };

                if (SQL.AsEnumerable().Count() > 0)
                {
                    foreach (var item in SQL)
                    {
                        ilan_bilgi.Text = "<fieldset><legend>İlan Bilgileri</legend><div><strong>İlan Kodu:</strong> " + item.Kod + "<br />";
                        ilan_bilgi.Text += "<strong>İlan Başlık:</strong> " + item.Baslik + "<br />";
                        ilan_bilgi.Text += "<strong>Şehir:</strong> " + item.Semt + "/" + item.Ilce + "/" + item.Il + "</div></fieldset><div class=\"h10\"></div>";
                        kayitbilgi_ekleyen.Text = item.Ekleyen;
                        kayitbilgi_gucelleyen.Text = item.Guncelleyen;
                        kayitbilgi_kayittarih.Text = item.KayitTarih.ToString();
                        kayitbilgi_guncellemetarih.Text = item.DegisTarih.ToString();
                    }
                }
            }
        }
    }
}