using System;
using System.Linq;
using System.Web;
using System.Web.UI;

namespace emlak.admin
{
    public partial class giris : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btn_GirisYap_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                KullaniciDenetle();
            }
            else
            {
                Class.Fonksiyonlar.JavaScript.MesajKutusuVeYonlendir("Güvenlik kodunu kontrol ediniz.", "giris.aspx");
                Yonetim.Olay.GirisHata("Güvenlik Kodu Hatası", form_kullanici.Text);
            }
        }

        protected void KullaniciDenetle()
        {
            string KullaniciAdi = Class.Fonksiyonlar.Genel.SQLTemizle(form_kullanici.Text);

            using (BaglantiCumlesi db = new BaglantiCumlesi())
            {
                var SQL = (from a in db.tbl_admin
                           where a.eposta == KullaniciAdi
                           select new
                           {
                               a.id
                           }).AsEnumerable();

                if (SQL.Any())
                {
                    SifreDenetle();
                }
                else
                {
                    Class.Fonksiyonlar.JavaScript.MesajKutusu("Kullanıcı adı bulunamadı!");
                    Yonetim.Olay.GirisHata("Geçersiz Kullanıcı", form_kullanici.Text);
                }
            }
        }

        protected void SifreDenetle()
        {
            string KullaniciAdi = Class.Fonksiyonlar.Genel.SQLTemizle(form_kullanici.Text);
            string Sifre = Class.Fonksiyonlar.Genel.SQLTemizle(form_sifre.Text);
            Sifre = Class.Fonksiyonlar.Genel.Sifrele(Sifre);

            using (BaglantiCumlesi db = new BaglantiCumlesi())
            {
                var SQL = (from a in db.tbl_admin
                           where a.eposta == KullaniciAdi && a.sifre == Sifre
                           select new
                           {
                               a.id
                           }).AsEnumerable();

                if (SQL.Any())
                {
                    Class.Fonksiyonlar.Genel.OturumIslemleri.CookieOlustur("" + Class.Fonksiyonlar.Genel.Parametre().Select(b => b.guvenlik_kodu).FirstOrDefault() + "giris", "7777777");
                    Class.Fonksiyonlar.JavaScript.MesajKutusuVeYonlendir("Kimlik doğrulaması başarılı. Kontrol paneline yönlendiriliyorsunuz!", "Default.aspx");

                    foreach (var item in SQL)
                    {
                        Class.Fonksiyonlar.Genel.OturumIslemleri.CookieOlustur("" + Class.Fonksiyonlar.Genel.Parametre().Select(b => b.guvenlik_kodu).FirstOrDefault() + "KullaniciID", item.id.ToString());

                        BaglantiCumlesi dbu = new BaglantiCumlesi();
                        tbl_admin TblKullanici = dbu.tbl_admin.First(p => p.id == item.id);
                        TblKullanici.son_giris = DateTime.Now;
                        TblKullanici.son_ip = HttpContext.Current.Request.ServerVariables["REMOTE_ADDR"];
                        dbu.SaveChanges();

                        Yonetim.Olay.GirisCikis("Giriş");
                    }
                }
                else
                {
                    Class.Fonksiyonlar.JavaScript.MesajKutusu("Şifreniz hatalıdır!");
                    Yonetim.Olay.GirisHata("Geçersiz Şifre", form_kullanici.Text);
                }
            }
        }
    }
}