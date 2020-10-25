using System;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace emlak.admin
{
    public partial class sayfa_ekle : System.Web.UI.Page
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
                var SQL = from a in db.tbl_sayfa
                          where a.ust_id == 0
                          orderby a.baslik ascending
                          select new
                          {
                              a.id,
                              a.baslik
                          };

                if (SQL.Any())
                {
                    form_katid.Items.Add(new ListItem("Ana Kategori", "0"));

                    foreach (var item in SQL)
                    {
                        form_katid.Items.Add(new ListItem(item.baslik, item.id.ToString()));
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
                    tbl_sayfa TblEkle = new tbl_sayfa();
                    TblEkle.ust_id = int.Parse(form_katid.SelectedValue);
                    TblEkle.baslik = Class.Fonksiyonlar.Genel.SQLTemizle(form_baslik.Text);
                    TblEkle.ozet = form_ozet.Text;
                    TblEkle.detay = form_detay.Text;
                    TblEkle.ana_menu = Class.Fonksiyonlar.Genel.StringToBool(form_anamenu.Text);
                    TblEkle.alt_menu = Class.Fonksiyonlar.Genel.StringToBool(form_altmenu.Text);
                    TblEkle.sira = int.Parse(form_sira.Text);
                    TblEkle.onay = Class.Fonksiyonlar.Genel.StringToBool(form_onay.SelectedValue);
                    TblEkle.admin_id_ek = int.Parse(HttpContext.Current.Request.Cookies["" + Class.Fonksiyonlar.Genel.Parametre().Select(b => b.guvenlik_kodu).FirstOrDefault() + "KullaniciID"].Value);
                    db.AddTotbl_sayfa(TblEkle);
                    db.SaveChanges();
                }

                Yonetim.Olay.Islem("sayfa", "Yeni Kayıt", "");
                Class.Fonksiyonlar.JavaScript.MesajKutusuVeYonlendir("Sayfa başarıyla eklenmiştir. Sayfa listesine yönlendiriliyorsunuz.", "sayfa.aspx");
            }
            catch (Exception ex)
            {
                Class.Fonksiyonlar.JavaScript.MesajKutusuVeYonlendir(Yonetim.Degiskenler.Hata + ex.Message, "sayfa.aspx");
            }
        }
    }
}