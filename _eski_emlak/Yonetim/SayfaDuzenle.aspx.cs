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
            var SQL = from a in db.sayfa
                      where a.UstID == 0
                      orderby a.Baslik ascending
                      select new
                      {
                          a.ID,
                          a.Baslik
                      };

            if (SQL.AsEnumerable().Count() > 0)
            {
                form_katid.Items.Add(new ListItem("Ana Kategori", "0"));

                foreach (var item in SQL)
                {
                    form_katid.Items.Add(new ListItem(item.Baslik, item.ID.ToString()));
                }
            }
        }

        if (Request.QueryString["ID"] != null && Class.Fonksiyonlar.Genel.NumerikKontrol(Request.QueryString["ID"].ToString()))
        {
            int ID = int.Parse(Request.QueryString["ID"]);

            using (BaglantiCumlesi db = new BaglantiCumlesi())
            {
                var SQL = from a in db.sayfa
                          where a.ID == ID
                          select new
                          {
                              a.ID,
                              a.Baslik,
                              a.Ozet,
                              a.Detay,
                              a.AltMenu,
                              a.AnaMenu,
                              a.UstID,
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
                        form_katid.Text = item.UstID.ToString();
                        form_onay.Text = item.Onay.ToString();
                        form_baslik.Text = item.Baslik;
                        form_sira.Text = item.Sira.ToString();
                        form_altmenu.Text = item.AltMenu.ToString();
                        form_anamenu.Text = item.AnaMenu.ToString();
                        form_ozet.Text = item.Ozet;
                        form_detay.Text = item.Detay;

                        kayitbilgi_ekleyen.Text = item.Ekleyen;
                        kayitbilgi_kayittarih.Text = item.KayitTarih.ToString();
                        kayitbilgi_gucelleyen.Text = item.Guncelleyen;
                        kayitbilgi_guncellemetarih.Text = item.DegisTarih.ToString();
                    }
                }
            }
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
                    sayfa TblEkle = db.sayfa.First(a => a.ID == ID);
                    TblEkle.UstID = int.Parse(form_katid.SelectedValue);
                    TblEkle.Baslik = Class.Fonksiyonlar.Genel.SQLTemizle(form_baslik.Text);
                    TblEkle.Ozet = form_ozet.Text;
                    TblEkle.Detay = form_detay.Text;
                    TblEkle.AnaMenu = int.Parse(form_anamenu.Text);
                    TblEkle.AltMenu = int.Parse(form_altmenu.Text);
                    TblEkle.Sira = int.Parse(form_sira.Text);
                    TblEkle.Onay = int.Parse(form_onay.SelectedValue);
                    TblEkle.GuncelleyenID = int.Parse(HttpContext.Current.Request.Cookies["" + Class.Fonksiyonlar.Genel.ParametreAl("GuvenlikKodu") + "KullaniciID"].Value);
                    TblEkle.DegisTarih = DateTime.Now;
                    db.SaveChanges();
                }

                Yonetim.Olay.Islem("sayfa", "Güncellendi", ID.ToString());
                Class.Fonksiyonlar.JavaScript.MesajKutusuVeYonlendir("Sayfa başarıyla düzenlenmiştir.", "SayfaDuzenle.aspx?ID=" + ID + "");
            }
            catch (Exception ex)
            {
                Class.Fonksiyonlar.JavaScript.MesajKutusuVeYonlendir(Yonetim.Degiskenler.Hata + ex.Message, "Sayfa.aspx");
            }
        }
    }
}