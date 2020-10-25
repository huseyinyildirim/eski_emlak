using System;
using System.Linq;
using System.Web;
using System.Web.UI;

namespace emlak.admin
{
    public partial class musteri_talep_duzenle : System.Web.UI.Page
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
                    var SQL = (from a in db.tbl_talep
                               where a.id == ID
                               select new
                               {
                                   a.id,
                                   Il = db.tbl_sehir_il.Where(b => b.id == a.il_id).Select(b => b.baslik).FirstOrDefault(),
                                   Ilce = db.tbl_sehir_ilce.Where(b => b.id == a.ilce_id).Select(b => b.baslik).FirstOrDefault(),
                                   Semt = db.tbl_sehir_semt.Where(b => b.id == a.semt_id).Select(b => b.baslik).FirstOrDefault(),
                                   Kategori = db.tbl_kategori.Where(b => b.id == a.kat_id).Select(b => b.baslik).FirstOrDefault(),
                                   a.ad,
                                   a.telefon,
                                   a.eposta,
                                   a.mesaj,
                                   a.yonetici_mesaj,
                                   a.ip,
                                   a.durum,
                                   a.ilan_tur,
                                   a.tarih_ek,
                                   a.tarih_gun,
                                   Guncelleyen = db.tbl_admin.Where(b => b.id == a.admin_id_gun).Select(b => b.ad).FirstOrDefault()
                               }).AsEnumerable();

                    if (SQL.Any())
                    {
                        foreach (var item in SQL)
                        {
                            form_adi.Text = item.ad;
                            form_telefon.Text = item.telefon;
                            form_eposta.Text = item.eposta;
                            form_il.Text = item.Il;
                            form_ilce.Text = item.Ilce;
                            form_semt.Text = item.Semt;
                            form_ilantur.Text = item.ilan_tur;
                            form_kategori.Text = item.Kategori;
                            form_talep.Text = item.mesaj;
                            form_detay.Text = item.yonetici_mesaj;

                            form_durum.Text = item.durum;

                            kayitbilgi_gucelleyen.Text = item.Guncelleyen;
                            kayitbilgi_guncellemetarih.Text = item.tarih_gun.ToString();
                        }
                    }
                    else
                    {
                        Response.Redirect("musteri-talep.aspx");
                    }
                }
            }
            else
            {
                Response.Redirect("musteri-talep.aspx");
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
                        tbl_talep TblEkle = db.tbl_talep.First(a => a.id == ID);
                        TblEkle.durum = form_durum.SelectedValue;
                        TblEkle.yonetici_mesaj = form_detay.Text;
                        TblEkle.admin_id_gun = int.Parse(HttpContext.Current.Request.Cookies["" + Class.Fonksiyonlar.Genel.Parametre().Select(b => b.guvenlik_kodu).FirstOrDefault() + "KullaniciID"].Value);
                        TblEkle.tarih_gun = DateTime.Now;
                        db.SaveChanges();
                    }

                    Yonetim.Olay.Islem("talep", "Güncellendi", ID.ToString());
                    Class.Fonksiyonlar.JavaScript.MesajKutusuVeYonlendir("Müşteri talep bilgileri başarıyla düzenlenmiştir.", "musteri-talep-duzenle.aspx?ID=" + Request.QueryString["ID"] + "");
                }
                catch (Exception ex)
                {
                    Class.Fonksiyonlar.JavaScript.MesajKutusuVeYonlendir(Yonetim.Degiskenler.Hata + ex.Message, "musteri-talep-duzenle.aspx?ID=" + Request.QueryString["ID"] + "");
                }
            }
        }
    }
}