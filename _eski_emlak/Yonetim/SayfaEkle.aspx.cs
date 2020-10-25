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
    }

    protected void btn_kayitekle_Click(object sender, EventArgs e)
    {
        try
        {
            using (BaglantiCumlesi db = new BaglantiCumlesi())
            {
                sayfa TblEkle = new sayfa();
                TblEkle.UstID = int.Parse(form_katid.SelectedValue);
                TblEkle.Baslik = Class.Fonksiyonlar.Genel.SQLTemizle(form_baslik.Text);
                TblEkle.Ozet = form_ozet.Text;
                TblEkle.Detay = form_detay.Text;
                TblEkle.AnaMenu = int.Parse(form_anamenu.Text);
                TblEkle.AltMenu = int.Parse(form_altmenu.Text);
                TblEkle.Sira = int.Parse(form_sira.Text);
                TblEkle.Onay = int.Parse(form_onay.SelectedValue);
                TblEkle.EkleyenID = int.Parse(HttpContext.Current.Request.Cookies["" + Class.Fonksiyonlar.Genel.ParametreAl("GuvenlikKodu") + "KullaniciID"].Value);
                TblEkle.KayitTarih = DateTime.Now;
                db.AddTosayfa(TblEkle);
                db.SaveChanges();
            }

            Yonetim.Olay.Islem("sayfa", "Yeni Kayıt", "");
            Class.Fonksiyonlar.JavaScript.MesajKutusuVeYonlendir("Sayfa başarıyla eklenmiştir. Sayfa listesine yönlendiriliyorsunuz.", "Sayfa.aspx");
        }
        catch (Exception ex)
        {
            Class.Fonksiyonlar.JavaScript.MesajKutusuVeYonlendir(Yonetim.Degiskenler.Hata + ex.Message, "Sayfa.aspx");
        }
    }
}