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
            YuklenecekAlanlar();
            Kayit();
        }
    }

    protected void YuklenecekAlanlar()
    {
        kayitsayi.Items.Clear();
        kayitsayi.Items.Add(new ListItem("10", "10"));
        kayitsayi.Items.Add(new ListItem("20", "20"));
        kayitsayi.Items.Add(new ListItem("30", "30"));
        kayitsayi.Items.Add(new ListItem("50", "50"));
        kayitsayi.Items.Add(new ListItem("75", "75"));
        kayitsayi.Items.Add(new ListItem("100", "100"));
        kayitsayi.Items.Add(new ListItem("125", "125"));
        kayitsayi.Items.Add(new ListItem("150", "150"));
    }

    protected void Kayit()
    {
        using (BaglantiCumlesi db = new BaglantiCumlesi())
        {
            var SQL = from a in db.parametre
                      where a.ID == 1
                      select new
                      {
                          a.SiteAdres,
                          a.GuvenlikKodu,
                          a.KayitTarih,
                          a.DegisTarih,
                          a.GoogleMapApi,
                          a.Facebook,
                          a.Twitter,
                          a.ReCaptchaPublicKey,
                          a.ReCaptchaPrivateKey,
                          Ekleyen = db.kullanici.Where(b => b.ID == a.EkleyenID).Select(b => b.Adi).FirstOrDefault(),
                          Guncelleyen = db.kullanici.Where(b => b.ID == a.GuncelleyenID).Select(b => b.Adi).FirstOrDefault()
                      };

            if (SQL.AsEnumerable().Count() > 0)
            {
                foreach (var item in SQL)
                {
                    form_siteadres.Text = item.SiteAdres;
                    form_guvenlikkod.Text = item.GuvenlikKodu;
                    form_mapkey.Text = item.GoogleMapApi;

                    form_facebook.Text = item.Facebook;
                    form_twitter.Text = item.Twitter;

                    form_publickey.Text = item.ReCaptchaPublicKey;
                    form_privatekey.Text = item.ReCaptchaPrivateKey;

                    kayitsayi.Text = Class.Fonksiyonlar.Genel.ParametreAl("YoneticiListeKayitSayi");

                    kayitbilgi_ekleyen.Text = item.Ekleyen;
                    kayitbilgi_kayittarih.Text = item.KayitTarih.ToString();
                    kayitbilgi_gucelleyen.Text = item.Guncelleyen;
                    kayitbilgi_guncellemetarih.Text = item.DegisTarih.ToString();
                }
            }
            else
            {
                Response.Redirect("Default.aspx");
            }
        }
    }

    protected void btn_kayitekle_Click(object sender, EventArgs e)
    {
        try
        {
            using (BaglantiCumlesi db = new BaglantiCumlesi())
            {
                parametre TblEkle = db.parametre.First(a => a.ID == 1);
                TblEkle.SiteAdres = Class.Fonksiyonlar.Genel.SQLTemizle(form_siteadres.Text);
                TblEkle.GuvenlikKodu = Class.Fonksiyonlar.Genel.SQLTemizle(form_guvenlikkod.Text);
                TblEkle.GoogleMapApi = Class.Fonksiyonlar.Genel.SQLTemizle(form_mapkey.Text);
                TblEkle.Facebook = Class.Fonksiyonlar.Genel.SQLTemizle(form_facebook.Text);
                TblEkle.Twitter = Class.Fonksiyonlar.Genel.SQLTemizle(form_twitter.Text);
                TblEkle.ReCaptchaPrivateKey = Class.Fonksiyonlar.Genel.SQLTemizle(form_privatekey.Text);
                TblEkle.ReCaptchaPublicKey = Class.Fonksiyonlar.Genel.SQLTemizle(form_publickey.Text);
                TblEkle.YoneticiListeKayitSayi = kayitsayi.SelectedValue;
                TblEkle.GuncelleyenID = int.Parse(HttpContext.Current.Request.Cookies["" + Class.Fonksiyonlar.Genel.ParametreAl("GuvenlikKodu") + "KullaniciID"].Value);
                TblEkle.DegisTarih = DateTime.Now;
                db.SaveChanges();
            }

            Yonetim.Olay.Islem("parametre", "Güncellendi", "1");
            Class.Fonksiyonlar.JavaScript.MesajKutusuVeYonlendir("Parametreler başarıyla düzenlenmiştir.", "AyarParametre.aspx");
        }
        catch (Exception ex)
        {
            Class.Fonksiyonlar.JavaScript.MesajKutusuVeYonlendir(Yonetim.Degiskenler.Hata + ex.Message, "AyarParametre.aspx");
        }
    }
}