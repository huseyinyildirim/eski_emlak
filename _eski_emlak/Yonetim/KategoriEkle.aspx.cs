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
                kategori TblEkle = new kategori();
                TblEkle.Baslik = Class.Fonksiyonlar.Genel.SQLTemizle(form_baslik.Text);
                TblEkle.Sira = int.Parse(Class.Fonksiyonlar.Genel.SQLTemizle(form_sira.Text));
                TblEkle.AltMenu = int.Parse(form_altmenu.SelectedValue);
                TblEkle.Onay = int.Parse(form_onay.SelectedValue);
                TblEkle.EkleyenID = int.Parse(HttpContext.Current.Request.Cookies["" + Class.Fonksiyonlar.Genel.ParametreAl("GuvenlikKodu") + "KullaniciID"].Value);
                TblEkle.KayitTarih = DateTime.Now;
                db.AddTokategori(TblEkle);
                db.SaveChanges();
            }

            Yonetim.Olay.Islem("kategori", "Yeni Kayıt", "");
            Class.Fonksiyonlar.JavaScript.MesajKutusuVeYonlendir("Kategori başarıyla eklenmiştir. Kategori listesine yönlendiriliyorsunuz.", "Kategori.aspx");
        }
        catch (Exception ex)
        {
            Class.Fonksiyonlar.JavaScript.MesajKutusuVeYonlendir(Yonetim.Degiskenler.Hata + ex.Message, "KategoriEkle.aspx");
        }
    }
}