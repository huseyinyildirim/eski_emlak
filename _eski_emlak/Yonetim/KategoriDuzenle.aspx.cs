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
                var SQL = from a in db.kategori
                          where a.ID == ID
                          select new
                          {
                              a.Baslik,
                              a.AltMenu,
                              a.Sira,
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
                        form_baslik.Text = item.Baslik;
                        form_altmenu.Text = item.AltMenu.ToString();
                        form_sira.Text = item.Sira.ToString();
                        form_onay.Text = item.Onay.ToString();

                        kayitbilgi_ekleyen.Text = item.Ekleyen;
                        kayitbilgi_kayittarih.Text = item.KayitTarih.ToString();
                        kayitbilgi_gucelleyen.Text = item.Guncelleyen;
                        kayitbilgi_guncellemetarih.Text = item.DegisTarih.ToString();
                    }
                }
                else
                {
                    Response.Redirect("Kategori.aspx");
                }
            }
        }
        else
        {
            Response.Redirect("Kategori.aspx");
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
                    kategori TblEkle = db.kategori.First(a => a.ID == ID);
                    TblEkle.Baslik = Class.Fonksiyonlar.Genel.SQLTemizle(form_baslik.Text);
                    TblEkle.Sira = int.Parse(Class.Fonksiyonlar.Genel.SQLTemizle(form_sira.Text));
                    TblEkle.AltMenu = int.Parse(form_altmenu.SelectedValue);
                    TblEkle.Onay = int.Parse(form_onay.SelectedValue);
                    TblEkle.GuncelleyenID = int.Parse(HttpContext.Current.Request.Cookies["" + Class.Fonksiyonlar.Genel.ParametreAl("GuvenlikKodu") + "KullaniciID"].Value);
                    TblEkle.DegisTarih = DateTime.Now;
                    db.SaveChanges();
                }

                Yonetim.Olay.Islem("kategori", "Güncellendi", ID.ToString());
                Class.Fonksiyonlar.JavaScript.MesajKutusuVeYonlendir("Kategori bilgileri başarıyla düzenlenmiştir.", "KategoriDuzenle.aspx?ID=" + Request.QueryString["ID"] + "");
            }
            catch (Exception ex)
            {
                Class.Fonksiyonlar.JavaScript.MesajKutusuVeYonlendir(Yonetim.Degiskenler.Hata + ex.Message, "KategoriDuzenle.aspx?ID=" + Request.QueryString["ID"] + "");
            }
        }
    }
}