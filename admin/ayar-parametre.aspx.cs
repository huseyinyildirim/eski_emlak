using System;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace emlak.admin
{
    public partial class ayar_parametre : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Class.Fonksiyonlar.Genel.OturumIslemleri.CookieKontrol();

            if (!Page.IsPostBack)
            {
                YuklenecekAlanlar();
                Kayit();
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
        }

        protected void Kayit()
        {
            using (BaglantiCumlesi db = new BaglantiCumlesi())
            {
                var SQL = (from a in db.tbl_parametre
                           where a.id == 1
                           select new
                           {
                               a.site_adres,
                               a.guvenlik_kodu,
                               a.tarih_ek,
                               a.tarih_gun,
                               a.google_map_api,
                               a.facebook,
                               a.twitter,
                               a.recaptcha_public_key,
                               a.recaptcha_private_key,
                               Ekleyen = db.tbl_admin.Where(b => b.id == a.admin_id_ek).Select(b => b.ad).FirstOrDefault(),
                               Guncelleyen = db.tbl_admin.Where(b => b.id == a.admin_id_gun).Select(b => b.ad).FirstOrDefault()
                           }).AsEnumerable();

                if (SQL.Any())
                {
                    foreach (var item in SQL)
                    {
                        form_siteadres.Text = item.site_adres;
                        form_guvenlikkod.Text = item.guvenlik_kodu;
                        form_mapkey.Text = item.google_map_api;

                        form_facebook.Text = item.facebook;
                        form_twitter.Text = item.twitter;

                        form_publickey.Text = item.recaptcha_public_key;
                        form_privatekey.Text = item.recaptcha_private_key;

                        kayitsayi.Text = Class.Fonksiyonlar.Genel.Parametre().Select(b => b.yonetici_liste_kayit_sayi).FirstOrDefault();

                        kayitbilgi_ekleyen.Text = item.Ekleyen;
                        kayitbilgi_kayittarih.Text = item.tarih_ek.ToString();
                        kayitbilgi_gucelleyen.Text = item.Guncelleyen;
                        kayitbilgi_guncellemetarih.Text = item.tarih_gun.ToString();
                    }
                }
                else
                {
                    Response.Redirect("default.aspx");
                }
            }
        }

        protected void btn_kayitekle_Click(object sender, EventArgs e)
        {
            try
            {
                using (BaglantiCumlesi db = new BaglantiCumlesi())
                {
                    tbl_parametre TblEkle = db.tbl_parametre.First(a => a.id == 1);
                    TblEkle.site_adres = Class.Fonksiyonlar.Genel.SQLTemizle(form_siteadres.Text);
                    TblEkle.guvenlik_kodu = Class.Fonksiyonlar.Genel.SQLTemizle(form_guvenlikkod.Text);
                    TblEkle.google_map_api = Class.Fonksiyonlar.Genel.SQLTemizle(form_mapkey.Text);
                    TblEkle.facebook = Class.Fonksiyonlar.Genel.SQLTemizle(form_facebook.Text);
                    TblEkle.twitter = Class.Fonksiyonlar.Genel.SQLTemizle(form_twitter.Text);
                    TblEkle.recaptcha_private_key = Class.Fonksiyonlar.Genel.SQLTemizle(form_privatekey.Text);
                    TblEkle.recaptcha_public_key = Class.Fonksiyonlar.Genel.SQLTemizle(form_publickey.Text);
                    TblEkle.yonetici_liste_kayit_sayi = kayitsayi.SelectedValue;
                    TblEkle.admin_id_gun = int.Parse(HttpContext.Current.Request.Cookies["" + Class.Fonksiyonlar.Genel.Parametre().Select(b => b.guvenlik_kodu).FirstOrDefault() + "KullaniciID"].Value);
                    db.SaveChanges();
                }

                Yonetim.Olay.Islem("parametre", "Güncellendi", "1");
                Class.Fonksiyonlar.JavaScript.MesajKutusuVeYonlendir("Parametreler başarıyla düzenlenmiştir.", "ayar-parametre.aspx");
            }
            catch (Exception ex)
            {
                Class.Fonksiyonlar.JavaScript.MesajKutusuVeYonlendir(Yonetim.Degiskenler.Hata + ex.Message, "ayar-parametre.aspx");
            }
        }
    }
}