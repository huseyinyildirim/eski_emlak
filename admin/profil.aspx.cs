using System;
using System.Linq;
using System.Web;
using System.Web.UI;

namespace emlak.admin
{
    public partial class profil : System.Web.UI.Page
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
            int ID = int.Parse(HttpContext.Current.Request.Cookies["" + Class.Fonksiyonlar.Genel.Parametre().Select(b => b.guvenlik_kodu).FirstOrDefault() + "KullaniciID"].Value);
            using (BaglantiCumlesi db = new BaglantiCumlesi())
            {
                var SQL = (from a in db.tbl_admin
                           where a.id == ID
                           select new
                           {
                               a.ad,
                               a.eposta,
                               a.telefon,
                               a.onay,
                               a.tarih_ek,
                               a.tarih_gun,
                               Ekleyen = db.tbl_admin.Where(b => b.id == a.admin_id_ek).Select(b => b.ad).FirstOrDefault(),
                               Guncelleyen = db.tbl_admin.Where(b => b.id == a.admin_id_gun).Select(b => b.ad).FirstOrDefault()
                           }).AsEnumerable();

                if (SQL.Any())
                {
                    foreach (var item in SQL)
                    {
                        form_ad.Text = item.ad;
                        form_eposta.Text = item.eposta;
                        form_telefon.Text = item.telefon;

                        kayitbilgi_ekleyen.Text = item.Ekleyen;
                        kayitbilgi_kayittarih.Text = item.tarih_ek.ToString();
                        kayitbilgi_gucelleyen.Text = item.Guncelleyen;
                        kayitbilgi_guncellemetarih.Text = item.tarih_gun.ToString();
                    }
                }
                else
                {
                    Response.Redirect("profil.aspx");
                }
            }
        }

        protected void btn_kayitekle_Click(object sender, EventArgs e)
        {
            int ID = int.Parse(HttpContext.Current.Request.Cookies["" + Class.Fonksiyonlar.Genel.Parametre().Select(b => b.guvenlik_kodu).FirstOrDefault() + "KullaniciID"].Value);
            try
            {
                using (BaglantiCumlesi db = new BaglantiCumlesi())
                {
                    tbl_admin TblEkle = db.tbl_admin.First(a => a.id == ID);
                    TblEkle.ad = Class.Fonksiyonlar.Genel.SQLTemizle(form_ad.Text);
                    TblEkle.eposta = Class.Fonksiyonlar.Genel.SQLTemizle(form_eposta.Text);
                    TblEkle.telefon = Class.Fonksiyonlar.Genel.SQLTemizle(form_telefon.Text);

                    if (form_sifre.Text != "")
                    {
                        TblEkle.sifre = Class.Fonksiyonlar.Genel.Sifrele(form_sifre.Text);
                    }

                    TblEkle.admin_id_gun = int.Parse(HttpContext.Current.Request.Cookies["" + Class.Fonksiyonlar.Genel.Parametre().Select(b => b.guvenlik_kodu).FirstOrDefault() + "KullaniciID"].Value);
                    db.SaveChanges();
                }

                Yonetim.Olay.Islem("kullanici", "Güncellendi", ID.ToString());
                Class.Fonksiyonlar.JavaScript.MesajKutusuVeYonlendir("Profiliniz başarıyla düzenlenmiştir.", "profil.aspx");
            }
            catch (Exception ex)
            {
                Class.Fonksiyonlar.JavaScript.MesajKutusuVeYonlendir(Yonetim.Degiskenler.Hata + ex.Message, "profil.aspx");
            }
        }
    }
}