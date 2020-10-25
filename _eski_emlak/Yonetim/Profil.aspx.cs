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
        int ID = int.Parse(HttpContext.Current.Request.Cookies["" + Class.Fonksiyonlar.Genel.ParametreAl("GuvenlikKodu") + "KullaniciID"].Value);
        using (BaglantiCumlesi db = new BaglantiCumlesi())
        {
            var SQL = from a in db.kullanici
                      where a.ID == ID
                      select new
                      {
                          a.Adi,
                          a.EPosta,
                          a.Telefon,
                          a.Onay,
                          a.KayitTarih,
                          a.DegisTarih,
                          Ekleyen = db.kullanici.Where(b => b.ID == a.EkleyenID).Select(b => b.Adi).FirstOrDefault(),
                          Guncelleyen = db.kullanici.Where(b => b.ID == a.GuncelleyenID).Select(b => b.Adi).FirstOrDefault()
                      };

            if (SQL.AsEnumerable().Count() > 0)
            {
                foreach (var item in SQL)
                {
                    form_ad.Text = item.Adi;
                    form_eposta.Text = item.EPosta;
                    form_telefon.Text = item.Telefon;

                    kayitbilgi_ekleyen.Text = item.Ekleyen;
                    kayitbilgi_kayittarih.Text = item.KayitTarih.ToString();
                    kayitbilgi_gucelleyen.Text = item.Guncelleyen;
                    kayitbilgi_guncellemetarih.Text = item.DegisTarih.ToString();
                }
            }
            else
            {
                Response.Redirect("Profil.aspx");
            }
        }
    }

    protected void btn_kayitekle_Click(object sender, EventArgs e)
    {
        int ID = int.Parse(HttpContext.Current.Request.Cookies["" + Class.Fonksiyonlar.Genel.ParametreAl("GuvenlikKodu") + "KullaniciID"].Value);
        try
        {
            using (BaglantiCumlesi db = new BaglantiCumlesi())
            {
                kullanici TblEkle = db.kullanici.First(a => a.ID == ID);
                TblEkle.Adi = Class.Fonksiyonlar.Genel.SQLTemizle(form_ad.Text);
                TblEkle.EPosta = Class.Fonksiyonlar.Genel.SQLTemizle(form_eposta.Text);
                TblEkle.Telefon = Class.Fonksiyonlar.Genel.SQLTemizle(form_telefon.Text);

                if (form_sifre.Text != "")
                {
                    TblEkle.Sifre = Class.Fonksiyonlar.Genel.Sifrele(form_sifre.Text);
                }

                TblEkle.GuncelleyenID = int.Parse(HttpContext.Current.Request.Cookies["" + Class.Fonksiyonlar.Genel.ParametreAl("GuvenlikKodu") + "KullaniciID"].Value);
                TblEkle.DegisTarih = DateTime.Now;
                db.SaveChanges();
            }

            Yonetim.Olay.Islem("kullanici", "Güncellendi", ID.ToString());
            Class.Fonksiyonlar.JavaScript.MesajKutusuVeYonlendir("Profiliniz başarıyla düzenlenmiştir.", "Profil.aspx");
        }
        catch (Exception ex)
        {
            Class.Fonksiyonlar.JavaScript.MesajKutusuVeYonlendir(Yonetim.Degiskenler.Hata + ex.Message, "Profil.aspx");
        }
    }
}