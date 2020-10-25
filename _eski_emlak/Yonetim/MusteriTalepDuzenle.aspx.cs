using System;
using System.Linq;
using System.Web;
using System.Web.UI;
using MySQLDataModel;

public partial class Yonetim_Kullanici : System.Web.UI.Page
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
                var SQL = from a in db.talep
                          where a.ID == ID
                          select new
                          {
                              a.ID,
                              Il = db.sehir_il.Where(b => b.ID == a.Il).Select(b => b.Baslik).FirstOrDefault(),
                              Ilce = db.sehir_ilce.Where(b => b.ID == a.Ilce).Select(b => b.Baslik).FirstOrDefault(),
                              Semt = db.sehir_semt.Where(b => b.ID == a.Semt).Select(b => b.Baslik).FirstOrDefault(),
                              Kategori = db.kategori.Where(b => b.ID == a.KatID).Select(b => b.Baslik).FirstOrDefault(),
                              a.Adi,
                              a.Telefon,
                              a.EPosta,
                              a.Mesaj,
                              a.YoneticiMesaj,
                              a.IPAdres,
                              a.Durum,
                              a.IlanTur,
                              a.KayitTarih,
                              a.DegisTarih,
                              Guncelleyen = db.kullanici.Where(b => b.ID == a.GuncelleyenID).Select(b => b.Adi).FirstOrDefault()
                          };

                if (SQL.AsEnumerable().Count()>0)
                {
                    foreach (var item in SQL)
                    {
                        form_adi.Text = item.Adi;
                        form_telefon.Text = item.Telefon;
                        form_eposta.Text = item.EPosta;
                        form_il.Text = item.Il;
                        form_ilce.Text = item.Ilce;
                        form_semt.Text = item.Semt;
                        form_ilantur.Text = item.IlanTur;
                        form_kategori.Text = item.Kategori;
                        form_talep.Text = item.Mesaj;
                        form_detay.Text = item.YoneticiMesaj;

                        form_durum.Text = item.Durum;

                        kayitbilgi_gucelleyen.Text = item.Guncelleyen;
                        kayitbilgi_guncellemetarih.Text = item.DegisTarih.ToString();
                    }
                }
                else
                {
                    Response.Redirect("MusteriTalep.aspx");
                }
            }
        }
        else
        {
            Response.Redirect("MusteriTalep.aspx");
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
                    talep TblEkle = db.talep.First(a => a.ID == ID);
                    TblEkle.Durum = form_durum.SelectedValue;
                    TblEkle.YoneticiMesaj = form_detay.Text;
                    TblEkle.GuncelleyenID = int.Parse(HttpContext.Current.Request.Cookies["" + Class.Fonksiyonlar.Genel.ParametreAl("GuvenlikKodu") + "KullaniciID"].Value);
                    TblEkle.DegisTarih = DateTime.Now;
                    db.SaveChanges();
                }

                Yonetim.Olay.Islem("talep", "Güncellendi", ID.ToString());
                Class.Fonksiyonlar.JavaScript.MesajKutusuVeYonlendir("Müşteri talep bilgileri başarıyla düzenlenmiştir.", "MusteriTalepDuzenle.aspx?ID=" + Request.QueryString["ID"] + "");
            }
            catch (Exception ex)
            {
                Class.Fonksiyonlar.JavaScript.MesajKutusuVeYonlendir(Yonetim.Degiskenler.Hata + ex.Message, "MusteriTalepDuzenle.aspx?ID=" + Request.QueryString["ID"] + "");
            }
        }
    }
}