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
        if (Request.QueryString["ID"] != null && Class.Fonksiyonlar.Genel.NumerikKontrol(Request.QueryString["ID"].ToString()))
        {
            int ID = int.Parse(Request.QueryString["ID"]);
            using (BaglantiCumlesi db = new BaglantiCumlesi())
            {
                var SQL = from a in db.musteri
                          where a.ID == ID
                          select new
                          {
                              a.Ad,
                              a.Adres,
                              a.Telefon,
                              a.Not,
                              a.KayitTarih,
                              a.DegisTarih,
                              Ekleyen = db.kullanici.Where(b => b.ID == a.EkleyenID).Select(b => b.Adi).FirstOrDefault(),
                              Guncelleyen = db.kullanici.Where(b => b.ID == a.GuncelleyenID).Select(b => b.Adi).FirstOrDefault()
                          };

                if (SQL.AsEnumerable().Count()>0)
                {
                    foreach (var item in SQL)
                    {
                        form_ad.Text = item.Ad;
                        form_adres.Text = item.Adres;
                        form_telefon.Text = item.Telefon;
                        form_not.Text = item.Not;

                        kayitbilgi_ekleyen.Text = item.Ekleyen;
                        kayitbilgi_kayittarih.Text = item.KayitTarih.ToString();
                        kayitbilgi_gucelleyen.Text = item.Guncelleyen;
                        kayitbilgi_guncellemetarih.Text = item.DegisTarih.ToString();
                    }
                }
                else
                {
                    Response.Redirect("Musteri.aspx");
                }
            }
        }
        else
        {
            Response.Redirect("Musteri.aspx");
        }
    }

    protected void btn_kayitekle_Click(object sender, EventArgs e)
    {
        if (Request.QueryString["ID"] != null && Class.Fonksiyonlar.Genel.NumerikKontrol(Request.QueryString["ID"].ToString()))
        {
            int ID = int.Parse(Request.QueryString["ID"]);
            try
            {
                using (BaglantiCumlesi db = new BaglantiCumlesi())
                {
                    musteri TblEkle = db.musteri.First(a => a.ID == ID);
                    TblEkle.Ad = Class.Fonksiyonlar.Genel.SQLTemizle(form_ad.Text);
                    TblEkle.Adres = Class.Fonksiyonlar.Genel.SQLTemizle(form_adres.Text);
                    TblEkle.Telefon = Class.Fonksiyonlar.Genel.SQLTemizle(form_telefon.Text);
                    TblEkle.Not = Class.Fonksiyonlar.Genel.SQLTemizle(form_not.Text);
                    TblEkle.GuncelleyenID = int.Parse(HttpContext.Current.Request.Cookies["" + Class.Fonksiyonlar.Genel.ParametreAl("GuvenlikKodu") + "KullaniciID"].Value);
                    TblEkle.DegisTarih = DateTime.Now;
                    db.SaveChanges();
                }

                Yonetim.Olay.Islem("musteri", "Güncellendi", ID.ToString());
                Class.Fonksiyonlar.JavaScript.MesajKutusuVeYonlendir("Müşteri bilgileri başarıyla düzenlenmiştir.", "MusteriDuzenle.aspx?ID=" + Request.QueryString["ID"] + "");
            }
            catch (Exception ex)
            {
                Class.Fonksiyonlar.JavaScript.MesajKutusuVeYonlendir(Yonetim.Degiskenler.Hata + ex.Message, "MusteriDuzenle.aspx?ID=" + Request.QueryString["ID"] + "");
            }
        }
    }
}