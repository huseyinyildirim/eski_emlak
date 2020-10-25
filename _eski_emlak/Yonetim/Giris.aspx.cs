using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySQLDataModel;

public partial class Yonetim_Default : System.Web.UI.Page
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
            Class.Fonksiyonlar.JavaScript.MesajKutusuVeYonlendir("Güvenlik kodunu kontrol ediniz.", "Giris.aspx");
            Yonetim.Olay.GirisHata("Güvenlik Kodu Hatası", form_kullanici.Text);
        }
    }

    protected void KullaniciDenetle()
    {
        string KullaniciAdi = Class.Fonksiyonlar.Genel.SQLTemizle(form_kullanici.Text);

        using (BaglantiCumlesi db = new BaglantiCumlesi())
        {
            var SQL = from a in db.kullanici
                      where a.EPosta == KullaniciAdi
                      select new { a.ID };

            if (SQL.AsEnumerable().Count() == 0)
            {
                Class.Fonksiyonlar.JavaScript.MesajKutusu("Kullanıcı adı bulunamadı!");
                Yonetim.Olay.GirisHata("Geçersiz Kullanıcı", form_kullanici.Text);
            }
            else if (SQL.AsEnumerable().Count() == 1)
            {
                SifreDenetle();
            }
            else
            {
                Class.Fonksiyonlar.JavaScript.MesajKutusu("Bu kullanıcı adından sistemde mükerrer kayıt bulunmaktadır. Lütfen sistem yöneticinizle görüşün!");
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
            var SQL = from a in db.kullanici
                      where a.EPosta == KullaniciAdi && a.Sifre == Sifre
                      select new { a.ID };

            if (SQL.AsEnumerable().Count() == 0)
            {
                Class.Fonksiyonlar.JavaScript.MesajKutusu("Şifreniz hatalıdır!");
                Yonetim.Olay.GirisHata("Geçersiz Şifre", form_kullanici.Text);
            }
            else if (SQL.AsEnumerable().Count() == 1)
            {
                Class.Fonksiyonlar.Genel.OturumIslemleri.CookieOlustur("" + Class.Fonksiyonlar.Genel.ParametreAl("GuvenlikKodu") + "Giris", "7777777");
                Class.Fonksiyonlar.JavaScript.MesajKutusuVeYonlendir("Kimlik doğrulaması başarılı. Kontrol paneline yönlendiriliyorsunuz!", "Default.aspx");

                foreach (var item in SQL)
                {
                    Class.Fonksiyonlar.Genel.OturumIslemleri.CookieOlustur("" + Class.Fonksiyonlar.Genel.ParametreAl("GuvenlikKodu") + "KullaniciID", item.ID.ToString());

                    BaglantiCumlesi dbu = new BaglantiCumlesi();
                    kullanici TblKullanici = dbu.kullanici.First(p => p.ID == item.ID);
                    TblKullanici.SonGiris = DateTime.Now;
                    TblKullanici.SonIP = HttpContext.Current.Request.ServerVariables["REMOTE_ADDR"];
                    dbu.SaveChanges();

                    Yonetim.Olay.GirisCikis("Giriş");
                }
            }
            else
            {
                Class.Fonksiyonlar.JavaScript.MesajKutusu("Bu kullanıcı adından sistemde mükerrer kayıt bulunmaktadır. Lütfen sistem yöneticinizle görüşün!");
            }
        }
    }
}