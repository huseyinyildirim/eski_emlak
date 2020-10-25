using System;
using System.Linq;
using System.Web;
using System.Web.UI;

namespace emlak.admin
{
    public partial class ilan_degisken_ekle : System.Web.UI.Page
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
                var SQL = (from a in db.tbl_ilan_degisken
                           where a.ust_id == 0
                           orderby a.baslik ascending
                           select new
                           {
                               a.id,
                               a.baslik
                           });

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
                    tbl_ilan_degisken TblEkle = new tbl_ilan_degisken();
                    TblEkle.ust_id = int.Parse(form_katid.SelectedValue);
                    TblEkle.baslik = Class.Fonksiyonlar.Genel.SQLTemizle(form_baslik.Text);
                    TblEkle.onay = Class.Fonksiyonlar.Genel.StringToBool(form_onay.SelectedValue);
                    TblEkle.admin_id_ek = int.Parse(HttpContext.Current.Request.Cookies["" + Class.Fonksiyonlar.Genel.Parametre().Select(b => b.guvenlik_kodu).FirstOrDefault() + "KullaniciID"].Value);
                    db.AddTotbl_ilan_degisken(TblEkle);
                    db.SaveChanges();
                }

                Yonetim.Olay.Islem("ilan_degisken", "Yeni Kayıt", "");
                Class.Fonksiyonlar.JavaScript.MesajKutusuVeYonlendir("İlan değişkeni başarıyla eklenmiştir. İlan değişkenleri listesine yönlendiriliyorsunuz.", "ilan-degisken.aspx");
            }
            catch (Exception ex)
            {
                Class.Fonksiyonlar.JavaScript.MesajKutusuVeYonlendir(Yonetim.Degiskenler.Hata + ex.Message, "ilan-degisken-ekle.aspx");
            }
        }
    }
}