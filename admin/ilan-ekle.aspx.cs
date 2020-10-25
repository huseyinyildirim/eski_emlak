using System;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace emlak.admin
{
    public partial class ilan_ekle : System.Web.UI.Page
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
                        var SQL = (from a in db.tbl_ilan
                                   where a.id == ID
                                   select new
                                   {
                                       a.kat_id
                                   }).AsEnumerable();

                        if (SQL.Any())
                        {
                            foreach (var item in SQL)
                            {
                                if (form_katid.SelectedValue != item.kat_id.ToString())
                                {
                                    using (BaglantiCumlesi db2 = new BaglantiCumlesi())
                                    {
                                        var SQL2 = (from a in db.tbl_ilan_detay where a.ilan_id == ID select a);

                                        foreach (var item2 in SQL2)
                                        {
                                            db2.tbl_ilan_detay.DeleteObject(item2);
                                        }
                                        db2.SaveChanges();
                                    }
                                }
                            }
                        }
                    }
                    using (BaglantiCumlesi db = new BaglantiCumlesi())
                    {
                        tbl_ilan Tbl = db.tbl_ilan.First(a => a.id == ID);
                        Tbl.ilan_tur = form_ilantur.SelectedValue;
                        Tbl.kat_id = int.Parse(form_katid.SelectedValue);
                        Tbl.kod = Class.Fonksiyonlar.Genel.SQLTemizle(form_ilankod.Text);
                        Tbl.baslik = Class.Fonksiyonlar.Genel.SQLTemizle(form_ilanbaslik.Text);
                        Tbl.fiyat = int.Parse(form_fiyat.Text.Replace(".", "").Replace(",", "").Replace("-", "").Replace("#", ""));
                        Tbl.fiyat_tur = form_fiyattur.SelectedValue;
                        Tbl.ilan_sure = int.Parse(form_ilansure.SelectedValue);
                        Tbl.il_id = int.Parse(form_il.SelectedValue);

                        if (form_ilce.SelectedValue != "0")
                        {
                            Tbl.ilce_id = int.Parse(form_ilce.SelectedValue);
                        }
                        if (form_semt.SelectedValue != "0")
                        {
                            Tbl.semt_id = int.Parse(form_semt.SelectedValue);
                        }

                        Tbl.mevki = Class.Fonksiyonlar.Genel.SQLTemizle(form_mevki.Text);
                        Tbl.adres = Class.Fonksiyonlar.Genel.SQLTemizle(form_adres.Text);
                        Tbl.adres_goster = Class.Fonksiyonlar.Genel.StringToBool(form_adresgoster.SelectedValue);
                        Tbl.satis = Class.Fonksiyonlar.Genel.StringToBool(form_satis.SelectedValue);
                        Tbl.vitrin = Class.Fonksiyonlar.Genel.StringToBool(form_vitrin.SelectedValue);
                        Tbl.onay = Class.Fonksiyonlar.Genel.StringToBool(form_onay.SelectedValue);
                        Tbl.arsiv = false;
                        Tbl.admin_id_gun = int.Parse(HttpContext.Current.Request.Cookies["" + Class.Fonksiyonlar.Genel.Parametre().Select(b => b.guvenlik_kodu).FirstOrDefault() + "KullaniciID"].Value);
                        db.SaveChanges();
                    }
                    Yonetim.Olay.Islem("ilan", "Güncellendi", ID.ToString());
                    Response.Redirect("ilan-ekle-2.aspx?ID=" + Request.QueryString["ID"] + "");
                }
                else
                {
                    using (BaglantiCumlesi db = new BaglantiCumlesi())
                    {
                        tbl_ilan Tbl = new tbl_ilan();
                        Tbl.ilan_tur = form_ilantur.SelectedValue;
                        Tbl.kat_id = int.Parse(form_katid.SelectedValue);
                        Tbl.kod = Class.Fonksiyonlar.Genel.SQLTemizle(form_ilankod.Text);
                        Tbl.baslik = Class.Fonksiyonlar.Genel.SQLTemizle(form_ilanbaslik.Text);
                        Tbl.fiyat = int.Parse(form_fiyat.Text);
                        Tbl.fiyat_tur = form_fiyattur.SelectedValue;
                        Tbl.ilan_sure = int.Parse(form_ilansure.SelectedValue);
                        Tbl.il_id = int.Parse(form_il.SelectedValue);

                        if (form_ilce.SelectedValue != "0")
                        {
                            Tbl.ilce_id = int.Parse(form_ilce.SelectedValue);
                        }
                        if (form_semt.SelectedValue != "0")
                        {
                            Tbl.semt_id = int.Parse(form_semt.SelectedValue);
                        }

                        Tbl.mevki = Class.Fonksiyonlar.Genel.SQLTemizle(form_mevki.Text);
                        Tbl.adres = Class.Fonksiyonlar.Genel.SQLTemizle(form_adres.Text);
                        Tbl.adres_goster = Class.Fonksiyonlar.Genel.StringToBool(form_adresgoster.SelectedValue);
                        Tbl.satis = Class.Fonksiyonlar.Genel.StringToBool(form_satis.SelectedValue);
                        Tbl.vitrin = Class.Fonksiyonlar.Genel.StringToBool(form_vitrin.SelectedValue);
                        Tbl.koordinat = "39.368279, 35.657959";
                        Tbl.onay = false;
                        Tbl.arsiv = false;
                        Tbl.admin_id_ek = int.Parse(HttpContext.Current.Request.Cookies["" + Class.Fonksiyonlar.Genel.Parametre().Select(b => b.guvenlik_kodu).FirstOrDefault() + "KullaniciID"].Value);
                        db.AddTotbl_ilan(Tbl);
                        db.SaveChanges();
                    }
                    Yonetim.Olay.Islem("ilan", "Yeni Kayıt", "");

                    using (BaglantiCumlesi db = new BaglantiCumlesi())
                    {
                        var SQL = (from a in db.tbl_ilan orderby a.id descending select new { a.id }).Take(1);

                        if (SQL.Any())
                        {
                            foreach (var item in SQL)
                            {
                                Response.Redirect("ilan-ekle-2.aspx?ID=" + item.id + "");
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                Class.Fonksiyonlar.JavaScript.MesajKutusuVeYonlendir(Yonetim.Degiskenler.Hata + ex.Message, "ilan-kle.aspx");
            }
        }

        protected void Il_Yukle()
        {
            using (BaglantiCumlesi db = new BaglantiCumlesi())
            {
                var SQL = (from a in db.tbl_sehir_il
                           where a.onay == true
                           orderby a.baslik ascending
                           select new
                           {
                               a.id,
                               a.baslik
                           }).AsEnumerable();

                if (SQL.Any())
                {
                    form_il.Items.Add(new ListItem("« Lütfen İl Seçiniz »", "0"));
                    foreach (var item in SQL)
                    {
                        form_il.Items.Add(new ListItem(item.baslik, item.id.ToString()));
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
                var SQL = (from a in db.tbl_sehir_ilce
                           where a.il_id == IlID && a.onay == true
                           orderby a.baslik ascending
                           select new
                           {
                               a.id,
                               a.baslik
                           }).AsEnumerable();

                if (SQL.Any())
                {
                    form_semt.Enabled = false;
                    form_ilce.Enabled = true;
                    form_ilce.Items.Add(new ListItem("« Lütfen İlçe Seçiniz »", "0"));

                    foreach (var item in SQL)
                    {
                        form_ilce.Items.Add(new ListItem(item.baslik, item.id.ToString()));
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
                var SQL = (from a in db.tbl_sehir_semt
                           where a.ilce_id == IlceID && a.onay == true
                           orderby a.baslik ascending
                           select new
                           {
                               a.id,
                               a.baslik
                           }).AsEnumerable();

                if (SQL.Any())
                {
                    form_semt.Enabled = true;
                    form_semt.Items.Add(new ListItem("« Lütfen Semt Seçiniz »", "0"));
                    foreach (var item in SQL)
                    {
                        form_semt.Items.Add(new ListItem(item.baslik, item.id.ToString()));
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
                var SQL = (from a in db.tbl_kategori
                           where a.onay == true
                           select new
                           {
                               a.id,
                               a.baslik
                           }).AsEnumerable();

                if (SQL.Any())
                {
                    form_katid.Items.Add(new ListItem("« Lütfen Seçiniz »", "0"));
                    foreach (var item in SQL)
                    {
                        form_katid.Items.Add(new ListItem(item.baslik, item.id.ToString()));
                    }
                }
            }

            //Fiyat türü
            using (BaglantiCumlesi db = new BaglantiCumlesi())
            {
                var SQL = (from a in db.tbl_ilan_degisken
                           where a.ust_id == 1 && a.onay == true
                           select new
                           {
                               a.baslik,
                               a.deger
                           }).AsEnumerable();

                if (SQL.Any())
                {
                    form_fiyattur.Items.Add(new ListItem("« Lütfen Seçiniz »", "0"));
                    foreach (var item in SQL)
                    {
                        form_fiyattur.Items.Add(new ListItem(item.baslik, item.deger));
                    }
                }
            }

            //İlan süresi
            using (BaglantiCumlesi db = new BaglantiCumlesi())
            {
                var SQL = (from a in db.tbl_ilan_degisken
                           where a.ust_id == 6 && a.onay == true
                           select new
                           {
                               a.baslik,
                               a.deger
                           }).AsEnumerable();

                if (SQL.Any())
                {
                    form_ilansure.Items.Add(new ListItem("« Lütfen Seçiniz »", "0"));
                    foreach (var item in SQL)
                    {
                        form_ilansure.Items.Add(new ListItem(item.baslik, item.deger));
                    }
                }
            }

            if (Request.QueryString["ID"] != null && Class.Fonksiyonlar.Genel.NumerikKontrol(Request.QueryString["ID"].ToString()))
            {
                kayit_bilgi.Visible = true;
                int ID = int.Parse(Request.QueryString["ID"].ToString());

                using (BaglantiCumlesi db = new BaglantiCumlesi())
                {
                    var SQL = (from a in db.tbl_ilan where a.id == ID select a);
                    if (SQL.Any())
                    {
                        foreach (var item in SQL)
                        {
                            form_ilantur.Text = item.ilan_tur;
                            form_katid.Text = item.kat_id.ToString();
                            form_ilankod.Text = HttpUtility.HtmlDecode(item.kod);
                            form_ilanbaslik.Text = HttpUtility.HtmlDecode(item.baslik);
                            form_fiyat.Text = item.fiyat.ToString();
                            form_fiyattur.Text = item.fiyat_tur;
                            form_ilansure.Text = item.ilan_sure.ToString();
                            form_il.Text = item.il_id.ToString();
                            Ilce_Yukle(form_il.Text);
                            form_ilce.Text = item.ilce_id.ToString();
                            Semt_Yukle(form_ilce.Text);
                            form_semt.Text = item.semt_id.ToString();
                            form_mevki.Text = HttpUtility.HtmlDecode(item.mevki);
                            form_adres.Text = HttpUtility.HtmlDecode(item.adres);
                            form_adresgoster.Text = item.adres_goster.ToString();
                            form_vitrin.Text = item.vitrin.ToString();
                            form_onay.Text = item.onay.ToString();
                            form_satis.Text = item.satis.ToString();
                        }
                    }
                }

                using (BaglantiCumlesi db = new BaglantiCumlesi())
                {
                    var SQL = (from a in db.tbl_ilan
                               where a.id == ID
                               select new
                               {
                                   a.kod,
                                   a.baslik,
                                   a.kat_id,
                                   Il = db.tbl_sehir_il.Where(b => b.id == a.il_id).Select(b => b.baslik).FirstOrDefault(),
                                   Ilce = db.tbl_sehir_ilce.Where(b => b.id == a.ilce_id).Select(b => b.baslik).FirstOrDefault(),
                                   Semt = db.tbl_sehir_semt.Where(b => b.id == a.semt_id).Select(b => b.baslik).FirstOrDefault(),
                                   a.tarih_ek,
                                   a.tarih_gun,
                                   Ekleyen = db.tbl_admin.Where(b => b.id == a.admin_id_ek).Select(b => b.ad).FirstOrDefault(),
                                   Guncelleyen = db.tbl_admin.Where(b => b.id == a.admin_id_gun).Select(b => b.ad).FirstOrDefault()
                               }).AsEnumerable();

                    if (SQL.Any())
                    {
                        foreach (var item in SQL)
                        {
                            ilan_bilgi.Text = "<fieldset><legend>İlan Bilgileri</legend><div><strong>İlan Kodu:</strong> " + item.kod + "<br />";
                            ilan_bilgi.Text += "<strong>İlan Başlık:</strong> " + item.baslik + "<br />";
                            ilan_bilgi.Text += "<strong>Şehir:</strong> " + item.Semt + "/" + item.Ilce + "/" + item.Il + "</div></fieldset><div class=\"h10\"></div>";
                            kayitbilgi_ekleyen.Text = item.Ekleyen;
                            kayitbilgi_gucelleyen.Text = item.Guncelleyen;
                            kayitbilgi_kayittarih.Text = item.tarih_ek.ToString();
                            kayitbilgi_guncellemetarih.Text = item.tarih_gun.ToString();
                        }
                    }
                }
            }
        }
    }
}