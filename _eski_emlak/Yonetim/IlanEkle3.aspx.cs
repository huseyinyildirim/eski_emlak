using System;
using System.IO;
using System.Linq;
using MySQLDataModel;

public partial class Yonetim_Kullanici : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Class.Fonksiyonlar.Genel.OturumIslemleri.CookieKontrol();

        Islemler();
        Kayitlar();
    }

    protected void Islemler()
    {
        if (Request.QueryString["Islem"] != null && Request.QueryString["ID"] != null && Request.QueryString["ResimID"] != null)
        {
            int ID = int.Parse(Request.QueryString["ID"].ToString());
            int ResimID = int.Parse(Request.QueryString["ResimID"].ToString());
            switch (Request.QueryString["Islem"].ToString())
            {
                case "Varsayilan":
                    /*using (BaglantiCumlesi db = new BaglantiCumlesi())
                    {
                        var SQL = from a in db.ilan_resim where a.ID == ResimID select a;
                        if (SQL.AsEnumerable().Count() > 0)
                        {
                            foreach (var item in SQL)
                            {
                                db.ilan_resim.DeleteObject(item);
                            }
                        }
                        db.SaveChanges();
                    }
                    Class.Fonksiyonlar.JavaScript.MesajKutusuVeYonlendir("Seçtiğiniz resim varsayılan seçilmiştir!", "IlanEkle3.aspx?ID=" + Request.QueryString["ID"].ToString() + "");*/
                    break;

                case "Sil":
                    using (BaglantiCumlesi db = new BaglantiCumlesi())
                    {
                        var SQL = from a in db.ilan_resim where a.ID == ResimID select a;
                        if (SQL.AsEnumerable().Count() > 0)
                        {
                            foreach (var item in SQL)
                            {
                                if (File.Exists(Server.MapPath("~/Upload/Ilan/" + item.Resim + "")))
                                {
                                    File.Delete(Server.MapPath("~/Upload/Ilan/" + item.Resim + ""));
                                    Yonetim.Olay.Islem("ilan_resim", "Silindi", item.ID.ToString());
                                }
                                db.ilan_resim.DeleteObject(item);
                            }
                        }
                        db.SaveChanges();
                    }
                    Class.Fonksiyonlar.JavaScript.MesajKutusuVeYonlendir("Seçtiğiniz resim silinmiştir!", "IlanEkle3.aspx?ID=" + Request.QueryString["ID"].ToString() + "");
                    break;
            }
        }
    }

    protected void Kayitlar()
    {
        if (Request.QueryString["ID"] != null && Class.Fonksiyonlar.Genel.NumerikKontrol(Request.QueryString["ID"].ToString()))
        {
            int ID = int.Parse(Request.QueryString["ID"].ToString());
            int KatID = 0;

            using (BaglantiCumlesi db=new BaglantiCumlesi())
            {
                var SQL = from a in db.ilan_resim where a.IlanID == ID select new { a.ID, a.Resim, IlanID = ID };
                dtResimler.DataSource = SQL;
                dtResimler.DataBind();
            }

            using (BaglantiCumlesi db = new BaglantiCumlesi())
            {
                var SQL = from a in db.ilan
                          where a.ID == ID
                          select new
                          {
                              a.Kod,
                              a.Baslik,
                              a.KatID,
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
                        KatID = int.Parse(item.KatID.ToString());
                        kayitbilgi_ekleyen.Text = item.Ekleyen;
                        kayitbilgi_gucelleyen.Text = item.Guncelleyen;
                        kayitbilgi_kayittarih.Text = item.KayitTarih.ToString();
                        kayitbilgi_guncellemetarih.Text = item.DegisTarih.ToString();
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
        Response.Redirect("IlanEkle2.aspx?ID=" + Request.QueryString["ID"].ToString() + "");
    }

    protected void Button2_Click(object sender, EventArgs e)
    {
        Response.Redirect("IlanEkle4.aspx?ID=" + Request.QueryString["ID"] + "");
    }
}