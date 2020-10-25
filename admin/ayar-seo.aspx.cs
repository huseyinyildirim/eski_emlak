using System;
using System.Linq;
using System.Web;
using System.Web.UI;

namespace emlak.admin
{
    public partial class ayar_seo : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Class.Fonksiyonlar.Genel.OturumIslemleri.CookieKontrol();

            if (!Page.IsPostBack)
            {
                Kayit();
            }
        }

        protected void Kayit()
        {
            using (BaglantiCumlesi db = new BaglantiCumlesi())
            {
                var SQL = from a in db.tbl_parametre
                          where a.id == 1
                          select new
                          {
                              a.seo_baslik,
                              a.seo_anahtar,
                              a.seo_aciklama,
                              a.tarih_ek,
                              a.tarih_gun,
                              Ekleyen = db.tbl_admin.Where(b => b.id == a.admin_id_ek).Select(b => b.ad).FirstOrDefault(),
                              Guncelleyen = db.tbl_admin.Where(b => b.id == a.admin_id_gun).Select(b => b.ad).FirstOrDefault()
                          };

                if (SQL.Any())
                {
                    foreach (var item in SQL)
                    {
                        form_baslik.Text = item.seo_baslik;
                        form_aciklama.Text = item.seo_aciklama;
                        form_anahtar.Text = item.seo_anahtar;

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
                    TblEkle.seo_baslik = Class.Fonksiyonlar.Genel.SQLTemizle(form_baslik.Text);
                    TblEkle.seo_aciklama = Class.Fonksiyonlar.Genel.SQLTemizle(form_aciklama.Text);
                    TblEkle.seo_anahtar = Class.Fonksiyonlar.Genel.SQLTemizle(form_anahtar.Text);
                    TblEkle.admin_id_gun = int.Parse(HttpContext.Current.Request.Cookies["" + Class.Fonksiyonlar.Genel.Parametre().Select(b => b.guvenlik_kodu).FirstOrDefault() + "KullaniciID"].Value);
                    db.SaveChanges();
                }

                Yonetim.Olay.Islem("parametre", "Güncellendi", "1");
                Class.Fonksiyonlar.JavaScript.MesajKutusuVeYonlendir("SEO ayarları başarıyla düzenlenmiştir.", "AyarSeo.aspx");
            }
            catch (Exception ex)
            {
                Class.Fonksiyonlar.JavaScript.MesajKutusuVeYonlendir(Yonetim.Degiskenler.Hata + ex.Message, "AyarSeo.aspx");
            }
        }
    }
}