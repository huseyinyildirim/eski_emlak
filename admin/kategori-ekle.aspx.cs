using System;
using System.Linq;
using System.Web;

namespace emlak.admin
{
    public partial class kategori_ekle : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Class.Fonksiyonlar.Genel.OturumIslemleri.CookieKontrol();
        }

        protected void btn_kayitekle_Click(object sender, EventArgs e)
        {
            try
            {
                using (BaglantiCumlesi db = new BaglantiCumlesi())
                {
                    tbl_kategori TblEkle = new tbl_kategori();
                    TblEkle.baslik = Class.Fonksiyonlar.Genel.SQLTemizle(form_baslik.Text);
                    TblEkle.sira = int.Parse(Class.Fonksiyonlar.Genel.SQLTemizle(form_sira.Text));
                    TblEkle.alt_menu = Class.Fonksiyonlar.Genel.StringToBool(form_altmenu.SelectedValue);
                    TblEkle.onay = Class.Fonksiyonlar.Genel.StringToBool(form_onay.SelectedValue);
                    TblEkle.admin_id_ek = int.Parse(HttpContext.Current.Request.Cookies["" + Class.Fonksiyonlar.Genel.Parametre().Select(b => b.guvenlik_kodu).FirstOrDefault() + "KullaniciID"].Value);
                    db.AddTotbl_kategori(TblEkle);
                    db.SaveChanges();
                }

                Yonetim.Olay.Islem("kategori", "Yeni Kayıt", "");
                Class.Fonksiyonlar.JavaScript.MesajKutusuVeYonlendir("Kategori başarıyla eklenmiştir. Kategori listesine yönlendiriliyorsunuz.", "kategori.aspx");
            }
            catch (Exception ex)
            {
                Class.Fonksiyonlar.JavaScript.MesajKutusuVeYonlendir(Yonetim.Degiskenler.Hata + ex.Message, "kategori-ekle.aspx");
            }
        }
    }
}