using System;
using System.Linq;
using System.Web;
using System.Web.UI;

namespace emlak.admin
{
    public partial class kullanici_duzenle : System.Web.UI.Page
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
                    var SQL = from a in db.tbl_admin
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
                              };

                    if (SQL.Any())
                    {
                        foreach (var item in SQL)
                        {
                            form_ad.Text = item.ad;
                            form_eposta.Text = item.eposta;
                            form_telefon.Text = item.telefon;
                            form_onay.Text = item.onay.ToString();

                            kayitbilgi_ekleyen.Text = item.Ekleyen;
                            kayitbilgi_kayittarih.Text = item.tarih_ek.ToString();
                            kayitbilgi_gucelleyen.Text = item.Guncelleyen;
                            kayitbilgi_guncellemetarih.Text = item.tarih_gun.ToString();
                        }
                    }
                    else
                    {
                        Response.Redirect("kullanici.aspx");
                    }
                }
            }
            else
            {
                Response.Redirect("kullanici.aspx");
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
                        tbl_admin TblEkle = db.tbl_admin.First(a => a.id == ID);
                        TblEkle.ad = Class.Fonksiyonlar.Genel.SQLTemizle(form_ad.Text);
                        TblEkle.eposta = Class.Fonksiyonlar.Genel.SQLTemizle(form_eposta.Text);
                        TblEkle.telefon = Class.Fonksiyonlar.Genel.SQLTemizle(form_telefon.Text);

                        if (form_sifre.Text != "")
                        {
                            TblEkle.sifre = Class.Fonksiyonlar.Genel.Sifrele(form_sifre.Text);
                        }

                        TblEkle.onay = Class.Fonksiyonlar.Genel.StringToBool(form_onay.SelectedValue);
                        TblEkle.admin_id_gun = int.Parse(HttpContext.Current.Request.Cookies["" + Class.Fonksiyonlar.Genel.Parametre().Select(b => b.guvenlik_kodu).FirstOrDefault() + "KullaniciID"].Value);
                        db.SaveChanges();
                    }

                    Yonetim.Olay.Islem("kullanici", "Güncellendi", ID.ToString());
                    Class.Fonksiyonlar.JavaScript.MesajKutusuVeYonlendir("Kullanıcı bilgileri başarıyla düzenlenmiştir.", "kullanici-duzenle.aspx?ID=" + Request.QueryString["ID"] + "");
                }
                catch (Exception ex)
                {
                    Class.Fonksiyonlar.JavaScript.MesajKutusuVeYonlendir(Yonetim.Degiskenler.Hata + ex.Message, "kullanici-duzenle.aspx?ID=" + Request.QueryString["ID"] + "");
                }
            }
        }
    }
}