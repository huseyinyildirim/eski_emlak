using System;
using System.Linq;
using System.Web;
using System.Web.UI;

namespace emlak.admin
{
    public partial class musteri_duzenle : System.Web.UI.Page
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
                    var SQL = (from a in db.tbl_musteri
                               where a.id == ID
                               select new
                               {
                                   a.ad,
                                   a.adres,
                                   a.telefon,
                                   a.not,
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
                            form_adres.Text = item.adres;
                            form_telefon.Text = item.telefon;
                            form_not.Text = item.not;

                            kayitbilgi_ekleyen.Text = item.Ekleyen;
                            kayitbilgi_kayittarih.Text = item.tarih_ek.ToString();
                            kayitbilgi_gucelleyen.Text = item.Guncelleyen;
                            kayitbilgi_guncellemetarih.Text = item.tarih_gun.ToString();
                        }
                    }
                    else
                    {
                        Response.Redirect("musteri.aspx");
                    }
                }
            }
            else
            {
                Response.Redirect("musteri.aspx");
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
                        tbl_musteri TblEkle = db.tbl_musteri.First(a => a.id == ID);
                        TblEkle.ad = Class.Fonksiyonlar.Genel.SQLTemizle(form_ad.Text);
                        TblEkle.adres = Class.Fonksiyonlar.Genel.SQLTemizle(form_adres.Text);
                        TblEkle.telefon = Class.Fonksiyonlar.Genel.SQLTemizle(form_telefon.Text);
                        TblEkle.not = Class.Fonksiyonlar.Genel.SQLTemizle(form_not.Text);
                        TblEkle.admin_id_gun = int.Parse(HttpContext.Current.Request.Cookies["" + Class.Fonksiyonlar.Genel.Parametre().Select(b => b.guvenlik_kodu).FirstOrDefault() + "KullaniciID"].Value);
                        TblEkle.tarih_gun = DateTime.Now;
                        db.SaveChanges();
                    }

                    Yonetim.Olay.Islem("musteri", "Güncellendi", ID.ToString());
                    Class.Fonksiyonlar.JavaScript.MesajKutusuVeYonlendir("Müşteri bilgileri başarıyla düzenlenmiştir.", "musteri-duzenle.aspx?ID=" + Request.QueryString["ID"] + "");
                }
                catch (Exception ex)
                {
                    Class.Fonksiyonlar.JavaScript.MesajKutusuVeYonlendir(Yonetim.Degiskenler.Hata + ex.Message, "musteri-duzenle.aspx?ID=" + Request.QueryString["ID"] + "");
                }
            }
        }
    }
}