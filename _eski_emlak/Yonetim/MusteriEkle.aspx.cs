using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Dynamic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySQLDataModel;
using System.Data;

public partial class Yonetim_Kullanici : System.Web.UI.Page
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
                musteri TblEkle = new musteri();
                TblEkle.Ad = Class.Fonksiyonlar.Genel.SQLTemizle(form_ad.Text);
                TblEkle.Adres = Class.Fonksiyonlar.Genel.SQLTemizle(form_adres.Text);
                TblEkle.Telefon = Class.Fonksiyonlar.Genel.SQLTemizle(form_telefon.Text);
                TblEkle.Not = Class.Fonksiyonlar.Genel.SQLTemizle(form_not.Text);
                TblEkle.EkleyenID = int.Parse(HttpContext.Current.Request.Cookies["" + Class.Fonksiyonlar.Genel.ParametreAl("GuvenlikKodu") + "KullaniciID"].Value);
                TblEkle.KayitTarih = DateTime.Now;
                db.AddTomusteri(TblEkle);
                db.SaveChanges();
            }

            Yonetim.Olay.Islem("musteri", "Yeni Kayıt", "");
            Class.Fonksiyonlar.JavaScript.MesajKutusuVeYonlendir("Müşteri başarıyla eklenmiştir. Müşteri listesine yönlendiriliyorsunuz.", "Musteri.aspx");
        }
        catch (Exception ex)
        {
            Class.Fonksiyonlar.JavaScript.MesajKutusuVeYonlendir(Yonetim.Degiskenler.Hata + ex.Message, "MusteriEkle.aspx");
        }
    }
}