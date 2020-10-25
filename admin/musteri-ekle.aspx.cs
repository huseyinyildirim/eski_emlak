using System;
using System.Linq;
using System.Web;

namespace emlak.admin
{
    public partial class musteri_ekle : System.Web.UI.Page
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
                    tbl_musteri TblEkle = new tbl_musteri();
                    TblEkle.ad = Class.Fonksiyonlar.Genel.SQLTemizle(form_ad.Text);
                    TblEkle.adres = Class.Fonksiyonlar.Genel.SQLTemizle(form_adres.Text);
                    TblEkle.telefon = Class.Fonksiyonlar.Genel.SQLTemizle(form_telefon.Text);
                    TblEkle.not = Class.Fonksiyonlar.Genel.SQLTemizle(form_not.Text);
                    TblEkle.admin_id_ek = int.Parse(HttpContext.Current.Request.Cookies["" + Class.Fonksiyonlar.Genel.Parametre().Select(b => b.guvenlik_kodu).FirstOrDefault() + "KullaniciID"].Value);
                    db.AddTotbl_musteri(TblEkle);
                    db.SaveChanges();
                }

                Yonetim.Olay.Islem("musteri", "Yeni Kayıt", "");
                Class.Fonksiyonlar.JavaScript.MesajKutusuVeYonlendir("Müşteri başarıyla eklenmiştir. Müşteri listesine yönlendiriliyorsunuz.", "musteri.aspx");
            }
            catch (Exception ex)
            {
                Class.Fonksiyonlar.JavaScript.MesajKutusuVeYonlendir(Yonetim.Degiskenler.Hata + ex.Message, "musteri-ekle.aspx");
            }
        }
    }
}