using System;
using System.Linq;
using System.Web;
using System.Web.UI;

namespace emlak.admin
{
    public partial class ayar_eposta : System.Web.UI.Page
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
                var SQL = (from a in db.tbl_parametre
                           where a.id == 1
                           select new
                           {
                               a.smtp,
                               a.smtp_eposta,
                               a.smtp_eposta_sifre,
                               a.smtp_port,
                               a.tarih_ek,
                               a.tarih_gun,
                               Ekleyen = db.tbl_admin.Where(b => b.id == a.admin_id_ek).Select(b => b.ad).FirstOrDefault(),
                               Guncelleyen = db.tbl_admin.Where(b => b.id == a.admin_id_gun).Select(b => b.ad).FirstOrDefault()
                           }).AsEnumerable();

                if (SQL.Any())
                {
                    foreach (var item in SQL)
                    {
                        form_smtp.Text = item.smtp;
                        form_smtpeposta.Text = item.smtp_eposta;
                        form_smtpepostasifre.Text = item.smtp_eposta_sifre;
                        form_smtpport.Text = item.smtp_port;

                        kayitbilgi_ekleyen.Text = item.Ekleyen;
                        kayitbilgi_kayittarih.Text = item.tarih_ek.ToString();
                        kayitbilgi_gucelleyen.Text = item.Guncelleyen;
                        kayitbilgi_guncellemetarih.Text = item.tarih_gun.ToString();
                    }
                }
                else
                {
                    Response.Redirect("default.aspx");
                }
            }
        }

        protected void btn_kayitekle_Click(object sender, EventArgs e)
        {
            try
            {
                using (BaglantiCumlesi db = new BaglantiCumlesi())
                {
                    tbl_parametre TblEkle = db.tbl_parametre.First(a => a.id == 1);
                    TblEkle.smtp = Class.Fonksiyonlar.Genel.SQLTemizle(form_smtp.Text);
                    TblEkle.smtp_eposta = Class.Fonksiyonlar.Genel.SQLTemizle(form_smtpeposta.Text);
                    TblEkle.smtp_eposta_sifre = Class.Fonksiyonlar.Genel.SQLTemizle(form_smtpepostasifre.Text);
                    TblEkle.smtp_port = Class.Fonksiyonlar.Genel.SQLTemizle(form_smtpport.Text);
                    TblEkle.admin_id_gun = int.Parse(HttpContext.Current.Request.Cookies["" + Class.Fonksiyonlar.Genel.Parametre().Select(b => b.guvenlik_kodu).FirstOrDefault() + "KullaniciID"].Value);
                    db.SaveChanges();
                }

                Yonetim.Olay.Islem("parametre", "Güncellendi", "1");
                Class.Fonksiyonlar.JavaScript.MesajKutusuVeYonlendir("E-posta ayarları başarıyla düzenlenmiştir.", "ayar-eposta.aspx");
            }
            catch (Exception ex)
            {
                Class.Fonksiyonlar.JavaScript.MesajKutusuVeYonlendir(Yonetim.Degiskenler.Hata + ex.Message, "ayar-eposta.aspx");
            }
        }
    }
}