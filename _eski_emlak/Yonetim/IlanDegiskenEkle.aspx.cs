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

        if (!Page.IsPostBack)
        {
            Kayit();
        }
    }

    protected void Kayit()
    {
        using (BaglantiCumlesi db = new BaglantiCumlesi())
        {
            var SQL = from a in db.ilan_degisken
                      where a.UstID == 0
                      orderby a.Baslik ascending
                      select new
                      {
                          a.ID,
                          a.Baslik
                      };

            form_katid.DataSource = SQL;
            form_katid.DataBind();
        }
    }

    protected void btn_kayitekle_Click(object sender, EventArgs e)
    {
        try
        {
            using (BaglantiCumlesi db = new BaglantiCumlesi())
            {
                ilan_degisken TblEkle = new ilan_degisken();
                TblEkle.UstID = int.Parse(form_katid.SelectedValue);
                TblEkle.Baslik = Class.Fonksiyonlar.Genel.SQLTemizle(form_baslik.Text);
                TblEkle.Onay = int.Parse(form_onay.SelectedValue);
                TblEkle.EkleyenID = int.Parse(HttpContext.Current.Request.Cookies["" + Class.Fonksiyonlar.Genel.ParametreAl("GuvenlikKodu") + "KullaniciID"].Value);
                TblEkle.KayitTarih = DateTime.Now;
                db.AddToilan_degisken(TblEkle);
                db.SaveChanges();
            }

            Yonetim.Olay.Islem("ilan_degisken", "Yeni Kayıt", "");
            Class.Fonksiyonlar.JavaScript.MesajKutusuVeYonlendir("İlan değişkeni başarıyla eklenmiştir. İlan değişkenleri listesine yönlendiriliyorsunuz.", "IlanDegisken.aspx");
        }
        catch (Exception ex)
        {
            Class.Fonksiyonlar.JavaScript.MesajKutusuVeYonlendir(Yonetim.Degiskenler.Hata + ex.Message, "IlanDegiskenEkle.aspx");
        }
    }
}