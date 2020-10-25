using System;
using System.Linq;
using System.Web;
using System.Web.UI;

namespace emlak.admin
{
    public partial class kategori_duzenle : System.Web.UI.Page
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
                    var SQL = (from a in db.tbl_kategori
                               where a.id == ID
                               select new
                               {
                                   a.baslik,
                                   a.alt_menu,
                                   a.sira,
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
                            form_baslik.Text = item.baslik;
                            form_altmenu.Text = item.alt_menu.ToString();
                            form_sira.Text = item.sira.ToString();
                            form_onay.Text = item.onay.ToString();

                            kayitbilgi_ekleyen.Text = item.Ekleyen;
                            kayitbilgi_kayittarih.Text = item.tarih_ek.ToString();
                            kayitbilgi_gucelleyen.Text = item.Guncelleyen;
                            kayitbilgi_guncellemetarih.Text = item.tarih_gun.ToString();
                        }
                    }
                    else
                    {
                        Response.Redirect("kategori.aspx");
                    }
                }
            }
            else
            {
                Response.Redirect("kategori.aspx");
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
                        tbl_kategori TblEkle = db.tbl_kategori.First(a => a.id == ID);
                        TblEkle.baslik = Class.Fonksiyonlar.Genel.SQLTemizle(form_baslik.Text);
                        TblEkle.sira = int.Parse(Class.Fonksiyonlar.Genel.SQLTemizle(form_sira.Text));
                        TblEkle.alt_menu = Class.Fonksiyonlar.Genel.StringToBool(form_altmenu.SelectedValue);
                        TblEkle.onay = Class.Fonksiyonlar.Genel.StringToBool(form_onay.SelectedValue);
                        TblEkle.admin_id_gun = int.Parse(HttpContext.Current.Request.Cookies["" + Class.Fonksiyonlar.Genel.Parametre().Select(b => b.guvenlik_kodu).FirstOrDefault() + "KullaniciID"].Value);
                        db.SaveChanges();
                    }

                    Yonetim.Olay.Islem("kategori", "Güncellendi", ID.ToString());
                    Class.Fonksiyonlar.JavaScript.MesajKutusuVeYonlendir("Kategori bilgileri başarıyla düzenlenmiştir.", "kategori-duzenle.aspx?ID=" + Request.QueryString["ID"] + "");
                }
                catch (Exception ex)
                {
                    Class.Fonksiyonlar.JavaScript.MesajKutusuVeYonlendir(Yonetim.Degiskenler.Hata + ex.Message, "kategori-duzenle.aspx?ID=" + Request.QueryString["ID"] + "");
                }
            }
        }
    }
}