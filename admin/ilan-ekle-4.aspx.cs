using System;
using System.Linq;
using System.Web;

namespace emlak.admin
{
    public partial class ilan_ekle_4 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Class.Fonksiyonlar.Genel.OturumIslemleri.CookieKontrol();

            Kayitlar();
        }

        protected void Kayitlar()
        {
            if (Request.QueryString["ID"] != null && Class.Fonksiyonlar.Genel.NumerikKontrol(Request.QueryString["ID"].ToString()))
            {
                int ID = int.Parse(Request.QueryString["ID"].ToString());

                using (BaglantiCumlesi db = new BaglantiCumlesi())
                {
                    var SQL = (from a in db.tbl_ilan
                               where a.id == ID
                               select new
                               {
                                   a.kod,
                                   a.baslik,
                                   a.kat_id,
                                   a.onay,
                                   a.vitrin,
                                   a.koordinat,
                                   Il = db.tbl_sehir_il.Where(b => b.id == a.il_id).Select(b => b.baslik).FirstOrDefault(),
                                   Ilce = db.tbl_sehir_ilce.Where(b => b.id == a.ilce_id).Select(b => b.baslik).FirstOrDefault(),
                                   Semt = db.tbl_sehir_semt.Where(b => b.id == a.semt_id).Select(b => b.baslik).FirstOrDefault(),
                                   a.tarih_ek,
                                   a.tarih_gun,
                                   Ekleyen = db.tbl_admin.Where(b => b.id == a.admin_id_ek).Select(b => b.ad).FirstOrDefault(),
                                   Guncelleyen = db.tbl_admin.Where(b => b.id == a.admin_id_gun).Select(b => b.ad).FirstOrDefault()
                               }).AsEnumerable();

                    if (SQL.Any())
                    {
                        foreach (var item in SQL)
                        {
                            ilan_bilgi.Text = "<strong>İlan Kodu:</strong> " + item.kod + "<br />";
                            ilan_bilgi.Text += "<strong>İlan Başlık:</strong> " + item.baslik + "<br />";
                            ilan_bilgi.Text += "<strong>Şehir:</strong> " + item.Semt + "/" + item.Ilce + "/" + item.Il + "";
                            form_onay.Text = item.onay.ToString();
                            form_vitrin.Text = item.vitrin.ToString();
                            kayitbilgi_ekleyen.Text = item.Ekleyen;
                            kayitbilgi_gucelleyen.Text = item.Guncelleyen;
                            kayitbilgi_kayittarih.Text = item.tarih_ek.ToString();
                            kayitbilgi_guncellemetarih.Text = item.tarih_gun.ToString();

                            if (item.koordinat == "39.368279, 35.657959")
                            {
                                mapkoordinat.Text = "39.368279, 35.657959";
                                mapzoom.Text = "6";
                            }
                            else
                            {
                                mapkoordinat.Text = item.koordinat;
                                mapkoordinat2.Text = item.koordinat;
                                mapzoom.Text = "15";
                            }
                        }
                    }
                }
            }
            else
            {
                Response.Redirect("ilan-ekle.aspx");
            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            Response.Redirect("ilan-ekle-3.aspx?ID=" + Request.QueryString["ID"].ToString() + "");
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            try
            {
                int ID = int.Parse(Request.QueryString["ID"].ToString());
                using (BaglantiCumlesi db = new BaglantiCumlesi())
                {
                    tbl_ilan Tbl = db.tbl_ilan.First(a => a.id == ID);
                    Tbl.koordinat = Request.Form["koordinat"].Replace("(", "").Replace(")", "");
                    Tbl.onay = Class.Fonksiyonlar.Genel.StringToBool(form_onay.SelectedValue);
                    Tbl.vitrin = Class.Fonksiyonlar.Genel.StringToBool(form_vitrin.SelectedValue);
                    Tbl.admin_id_gun = int.Parse(HttpContext.Current.Request.Cookies["" + Class.Fonksiyonlar.Genel.Parametre().Select(b => b.guvenlik_kodu).FirstOrDefault() + "KullaniciID"].Value);
                    db.SaveChanges();
                }

                if (form_onay.Text == "1")
                {
                    Class.Fonksiyonlar.JavaScript.MesajKutusuVeYonlendir("İlanınız başarıyla eklenmiş ve yayına alınmıştır. İlanlar listesine yönlendiriliyorsunuz!", "ilan.aspx");
                }
                else
                {
                    Class.Fonksiyonlar.JavaScript.MesajKutusuVeYonlendir("İlanınız başarıyla eklenmiştir. Onay vermek için Onaysız İlanlar listesine yönlendiriliyorsunuz!", "ilan-onaysiz.aspx");
                }
            }
            catch (Exception ex)
            {
                Class.Fonksiyonlar.JavaScript.MesajKutusuVeYonlendir(Yonetim.Degiskenler.Hata + ex.Message, "ilan-ekle.aspx");
            }
        }
    }
}