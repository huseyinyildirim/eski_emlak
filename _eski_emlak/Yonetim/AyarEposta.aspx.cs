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
            var SQL = from a in db.parametre
                      where a.ID == 1
                      select new
                      {
                          a.Smtp,
                          a.SmtpEPosta,
                          a.SmtpEPostaSifre,
                          a.SmtpPort,
                          a.KayitTarih,
                          a.DegisTarih,
                          Ekleyen = db.kullanici.Where(b => b.ID == a.EkleyenID).Select(b => b.Adi).FirstOrDefault(),
                          Guncelleyen = db.kullanici.Where(b => b.ID == a.GuncelleyenID).Select(b => b.Adi).FirstOrDefault()
                      };

            if (SQL.AsEnumerable().Count() > 0)
            {
                foreach (var item in SQL)
                {
                    form_smtp.Text = item.Smtp;
                    form_smtpeposta.Text = item.SmtpEPosta;
                    form_smtpepostasifre.Text = item.SmtpEPostaSifre;
                    form_smtpport.Text = item.SmtpPort;

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
                TblEkle.Smtp = Class.Fonksiyonlar.Genel.SQLTemizle(form_smtp.Text);
                TblEkle.SmtpEPosta = Class.Fonksiyonlar.Genel.SQLTemizle(form_smtpeposta.Text);
                TblEkle.SmtpEPostaSifre = Class.Fonksiyonlar.Genel.SQLTemizle(form_smtpepostasifre.Text);
                TblEkle.SmtpPort = Class.Fonksiyonlar.Genel.SQLTemizle(form_smtpport.Text);
                TblEkle.GuncelleyenID = int.Parse(HttpContext.Current.Request.Cookies["" + Class.Fonksiyonlar.Genel.ParametreAl("GuvenlikKodu") + "KullaniciID"].Value);
                TblEkle.DegisTarih = DateTime.Now;
                db.SaveChanges();
            }

            Yonetim.Olay.Islem("parametre", "Güncellendi", "1");
            Class.Fonksiyonlar.JavaScript.MesajKutusuVeYonlendir("E-posta ayarları başarıyla düzenlenmiştir.", "AyarEposta.aspx");
        }
        catch (Exception ex)
        {
            Class.Fonksiyonlar.JavaScript.MesajKutusuVeYonlendir(Yonetim.Degiskenler.Hata + ex.Message, "AyarEposta.aspx");
        }
    }
}