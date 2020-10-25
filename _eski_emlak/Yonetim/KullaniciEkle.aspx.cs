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
                kullanici TblEkle = new kullanici();
                TblEkle.Adi = Class.Fonksiyonlar.Genel.SQLTemizle(form_ad.Text);
                TblEkle.EPosta = Class.Fonksiyonlar.Genel.SQLTemizle(form_eposta.Text);
                TblEkle.Telefon = Class.Fonksiyonlar.Genel.SQLTemizle(form_telefon.Text);
                TblEkle.Sifre = Class.Fonksiyonlar.Genel.Sifrele(form_sifre.Text);
                TblEkle.Onay = int.Parse(form_onay.SelectedValue);
                TblEkle.EkleyenID = int.Parse(HttpContext.Current.Request.Cookies["" + Class.Fonksiyonlar.Genel.ParametreAl("GuvenlikKodu") + "KullaniciID"].Value);
                TblEkle.KayitTarih = DateTime.Now;
                db.AddTokullanici(TblEkle);
                db.SaveChanges();
            }

            Yonetim.Olay.Islem("kullanici", "Yeni Kayıt", "");
            Class.Fonksiyonlar.JavaScript.MesajKutusuVeYonlendir("Kullanıcı başarıyla eklenmiştir. Kullanıcı listesine yönlendiriliyorsunuz.", "Kullanici.aspx");
        }
        catch (Exception ex)
        {
            Class.Fonksiyonlar.JavaScript.MesajKutusuVeYonlendir(Yonetim.Degiskenler.Hata + ex.Message, "KullaniciEkle.aspx");
        }
    }
}