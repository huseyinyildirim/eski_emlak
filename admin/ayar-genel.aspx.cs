using System;
using System.Linq;
using System.Web;
using System.Web.UI;

namespace emlak.admin
{
    public partial class ayar_genel : System.Web.UI.Page
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
                var SQL = (from a in db.tbl_parametre
                           where a.id == 1
                           select new
                           {
                               a.firma,
                               a.eposta,
                               a.telefon,
                               a.faks,
                               a.adres,
                               a.cep_telefon,
                               a.tarih_ek,
                               a.tarih_gun,
                               Ekleyen = db.tbl_admin.Where(b => b.id == a.admin_id_ek).Select(b => b.ad).FirstOrDefault(),
                               Guncelleyen = db.tbl_admin.Where(b => b.id == a.admin_id_gun).Select(b => b.ad).FirstOrDefault()
                           }).AsEnumerable();

                if (SQL.Any())
                {
                    foreach (var item in SQL)
                    {
                        form_firma.Text = item.firma;
                        form_ceptelefon.Text = item.cep_telefon;
                        form_telefon.Text = item.telefon;
                        form_adres.Text = item.adres;
                        form_faks.Text = item.faks;
                        form_eposta.Text = item.eposta;

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
                    TblEkle.firma = Class.Fonksiyonlar.Genel.SQLTemizle(form_firma.Text);
                    TblEkle.telefon = Class.Fonksiyonlar.Genel.SQLTemizle(form_telefon.Text);
                    TblEkle.cep_telefon = Class.Fonksiyonlar.Genel.SQLTemizle(form_ceptelefon.Text);
                    TblEkle.adres = Class.Fonksiyonlar.Genel.SQLTemizle(form_adres.Text);
                    TblEkle.faks = Class.Fonksiyonlar.Genel.SQLTemizle(form_faks.Text);
                    TblEkle.eposta = Class.Fonksiyonlar.Genel.SQLTemizle(form_eposta.Text);
                    TblEkle.admin_id_gun = int.Parse(HttpContext.Current.Request.Cookies["" + Class.Fonksiyonlar.Genel.Parametre().Select(b => b.guvenlik_kodu).FirstOrDefault() + "KullaniciID"].Value);
                    db.SaveChanges();
                }

                Yonetim.Olay.Islem("parametre", "Güncellendi", "1");
                Class.Fonksiyonlar.JavaScript.MesajKutusuVeYonlendir("Genel ayarlar başarıyla düzenlenmiştir.", "ayar-genel.aspx");
            }
            catch (Exception ex)
            {
                Class.Fonksiyonlar.JavaScript.MesajKutusuVeYonlendir(Yonetim.Degiskenler.Hata + ex.Message, "ayar-genel.aspx");
            }
        }
    }
}