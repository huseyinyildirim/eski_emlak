using System;
using System.Linq;
using System.Web;

namespace emlak.admin
{
    public partial class kullanici_ekle : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Class.Fonksiyonlar.Genel.OturumIslemleri.CookieKontrol();
        }

        protected void btn_kayitekle_Click(object sender, EventArgs e)
        {
            try
            {
                using (BaglantiCumlesi db = new BaglantiCumlesi())
                {
                    tbl_admin TblEkle = new tbl_admin();
                    TblEkle.ad = Class.Fonksiyonlar.Genel.SQLTemizle(form_ad.Text);
                    TblEkle.eposta = Class.Fonksiyonlar.Genel.SQLTemizle(form_eposta.Text);
                    TblEkle.telefon = Class.Fonksiyonlar.Genel.SQLTemizle(form_telefon.Text);
                    TblEkle.sifre = Class.Fonksiyonlar.Genel.Sifrele(form_sifre.Text);
                    TblEkle.onay = Class.Fonksiyonlar.Genel.StringToBool(form_onay.SelectedValue);
                    TblEkle.admin_id_ek = int.Parse(HttpContext.Current.Request.Cookies["" + Class.Fonksiyonlar.Genel.Parametre().Select(b => b.guvenlik_kodu).FirstOrDefault() + "KullaniciID"].Value);
                    db.AddTotbl_admin(TblEkle);
                    db.SaveChanges();
                }

                Yonetim.Olay.Islem("kullanici", "Yeni Kayıt", "");
                Class.Fonksiyonlar.JavaScript.MesajKutusuVeYonlendir("Kullanıcı başarıyla eklenmiştir. Kullanıcı listesine yönlendiriliyorsunuz.", "kullanici.aspx");
            }
            catch (Exception ex)
            {
                Class.Fonksiyonlar.JavaScript.MesajKutusuVeYonlendir(Yonetim.Degiskenler.Hata + ex.Message, "kullanici-ekle.aspx");
            }
        }
    }
}