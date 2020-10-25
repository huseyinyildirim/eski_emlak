using System;
using System.IO;
using System.Linq;

namespace emlak.admin
{
    public partial class ilan_ekle_3 : System.Web.UI.Page
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
                            var SQL = from a in db.tbl_ilan_resim where a.id == ResimID select a;
                            if (SQL.Any())
                            {
                                foreach (var item in SQL)
                                {
                                    db.tbl_ilan_resim.DeleteObject(item);
                                }
                            }
                            db.SaveChanges();
                        }
                        Class.Fonksiyonlar.JavaScript.MesajKutusuVeYonlendir("Seçtiğiniz resim varsayılan seçilmiştir!", "IlanEkle3.aspx?ID=" + Request.QueryString["ID"].ToString() + "");*/
                        break;

                    case "Sil":
                        using (BaglantiCumlesi db = new BaglantiCumlesi())
                        {
                            var SQL = (from a in db.tbl_ilan_resim where a.id == ResimID select a);

                            if (SQL.Any())
                            {
                                foreach (var item in SQL)
                                {
                                    if (File.Exists(Server.MapPath("~/upload/ilan/" + item.resim + "")))
                                    {
                                        File.Delete(Server.MapPath("~/upload/ilan/" + item.resim + ""));
                                        Yonetim.Olay.Islem("ilan_resim", "Silindi", item.id.ToString());
                                    }
                                    db.tbl_ilan_resim.DeleteObject(item);
                                }
                            }
                            db.SaveChanges();
                        }
                        Class.Fonksiyonlar.JavaScript.MesajKutusuVeYonlendir("Seçtiğiniz resim silinmiştir!", "ilan-ekle-3.aspx?ID=" + Request.QueryString["ID"].ToString() + "");
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

                using (BaglantiCumlesi db = new BaglantiCumlesi())
                {
                    var SQL = (from a in db.tbl_ilan_resim
                               where a.ilan_id == ID
                               select new
                               {
                                   a.id,
                                   a.resim,
                                   IlanID = ID
                               });

                    dtResimler.DataSource = SQL;
                    dtResimler.DataBind();
                }

                using (BaglantiCumlesi db = new BaglantiCumlesi())
                {
                    var SQL = (from a in db.tbl_ilan
                               where a.id == ID
                               select new
                               {
                                   a.kod,
                                   a.baslik,
                                   a.kat_id,
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
                            KatID = int.Parse(item.kat_id.ToString());
                            kayitbilgi_ekleyen.Text = item.Ekleyen;
                            kayitbilgi_gucelleyen.Text = item.Guncelleyen;
                            kayitbilgi_kayittarih.Text = item.tarih_ek.ToString();
                            kayitbilgi_guncellemetarih.Text = item.tarih_gun.ToString();
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
            Response.Redirect("ilan-ekle-2.aspx?ID=" + Request.QueryString["ID"].ToString() + "");
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            Response.Redirect("ilan-ekle-4.aspx?ID=" + Request.QueryString["ID"] + "");
        }
    }
}