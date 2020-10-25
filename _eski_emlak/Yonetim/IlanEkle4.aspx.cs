using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Dynamic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySQLDataModel;
using System.Data;

public partial class Yonetim_Kullanici : System.Web.UI.Page
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
                var SQL = from a in db.ilan
                          where a.ID == ID
                          select new
                          {
                              a.Kod,
                              a.Baslik,
                              a.KatID,
                              a.Onay,
                              a.Vitrin,
                              a.Koordinat,
                              Il = db.sehir_il.Where(b => b.ID == a.Il).Select(b => b.Baslik).FirstOrDefault(),
                              Ilce = db.sehir_ilce.Where(b => b.ID == a.Ilce).Select(b => b.Baslik).FirstOrDefault(),
                              Semt = db.sehir_semt.Where(b => b.ID == a.Semt).Select(b => b.Baslik).FirstOrDefault(),
                              a.KayitTarih,
                              a.DegisTarih,
                              Ekleyen = db.kullanici.Where(b => b.ID == a.EkleyenID).Select(b => b.Adi).FirstOrDefault(),
                              Guncelleyen = db.kullanici.Where(b => b.ID == a.GuncelleyenID).Select(b => b.Adi).FirstOrDefault()
                          };

                if (SQL.AsEnumerable().Count() > 0)
                {
                    foreach (var item in SQL)
                    {
                        ilan_bilgi.Text = "<strong>İlan Kodu:</strong> " + item.Kod + "<br />";
                        ilan_bilgi.Text += "<strong>İlan Başlık:</strong> " + item.Baslik + "<br />";
                        ilan_bilgi.Text += "<strong>Şehir:</strong> " + item.Semt + "/" + item.Ilce + "/" + item.Il + "";
                        form_onay.Text = item.Onay.ToString();
                        form_vitrin.Text = item.Vitrin.ToString();
                        kayitbilgi_ekleyen.Text = item.Ekleyen;
                        kayitbilgi_gucelleyen.Text = item.Guncelleyen;
                        kayitbilgi_kayittarih.Text = item.KayitTarih.ToString();
                        kayitbilgi_guncellemetarih.Text = item.DegisTarih.ToString();

                        if (item.Koordinat == "39.368279, 35.657959")
                        {
                            mapkoordinat.Text = "39.368279, 35.657959";
                            mapzoom.Text = "6";
                        }
                        else
                        {
                            mapkoordinat.Text = item.Koordinat;
                            mapkoordinat2.Text = item.Koordinat;
                            mapzoom.Text = "15";
                        }
                    }
                }
            }
        }
        else
        {
            Response.Redirect("IlanEkle.aspx");
        }
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        Response.Redirect("IlanEkle3.aspx?ID=" + Request.QueryString["ID"].ToString() + "");
    }

    protected void Button2_Click(object sender, EventArgs e)
    {
        try
        {
            int ID = int.Parse(Request.QueryString["ID"].ToString());
            using (BaglantiCumlesi db = new BaglantiCumlesi())
            {
                ilan Tbl = db.ilan.First(a => a.ID == ID);
                Tbl.Koordinat = Request.Form["koordinat"].Replace("(", "").Replace(")", "");
                Tbl.Onay = int.Parse(form_onay.SelectedValue);
                Tbl.Vitrin = int.Parse(form_vitrin.SelectedValue);
                Tbl.DegisTarih = DateTime.Now;
                Tbl.GuncelleyenID = int.Parse(HttpContext.Current.Request.Cookies["" + Class.Fonksiyonlar.Genel.ParametreAl("GuvenlikKodu") + "KullaniciID"].Value);
                db.SaveChanges();
            }

            if (form_onay.Text == "1")
            {
                Class.Fonksiyonlar.JavaScript.MesajKutusuVeYonlendir("İlanınız başarıyla eklenmiş ve yayına alınmıştır. İlanlar listesine yönlendiriliyorsunuz!", "Ilan.aspx");
            }
            else
            {
                Class.Fonksiyonlar.JavaScript.MesajKutusuVeYonlendir("İlanınız başarıyla eklenmiştir. Onay vermek için Onaysız İlanlar listesine yönlendiriliyorsunuz!", "IlanOnaysiz.aspx");
            }
        }
        catch (Exception ex)
        {
            Class.Fonksiyonlar.JavaScript.MesajKutusuVeYonlendir(Yonetim.Degiskenler.Hata + ex.Message, "IlanEkle.aspx");
        }
    }
}