using System;
using System.Linq;
using System.Text;
using System.Web.UI;

namespace emlak
{
    public partial class ilan : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Class.Fonksiyonlar.Sayac();

            Page.MetaDescription = Class.Fonksiyonlar.Genel.Parametre().Select(b => b.seo_aciklama).FirstOrDefault();
            Page.MetaKeywords = Class.Fonksiyonlar.Genel.Parametre().Select(b => b.seo_anahtar).FirstOrDefault();

            VitrinIlan();
            Ilan();
        }

        protected void Ilan()
        {
            int ID = 0;

            if (RouteData.Values["IlanID"] != null && Class.Fonksiyonlar.Genel.NumerikKontrol(RouteData.Values["IlanID"].ToString()))
            {
                ID = int.Parse(RouteData.Values["IlanID"].ToString());
            }
            else
            {
                Response.Redirect("/default.aspx");
            }

            using (BaglantiCumlesi db = new BaglantiCumlesi())
            {
                var SQL = (from a in db.tbl_ilan
                           where a.onay == true && a.id == ID && a.arsiv == false
                           select new
                           {
                               a.id,
                               Kategori = db.tbl_kategori.Where(k => k.id == a.kat_id).Select(k => k.baslik).FirstOrDefault(),
                               a.ilan_tur,
                               a.kod,
                               a.baslik,
                               a.fiyat,
                               a.fiyat_tur,
                               a.ilan_sure,
                               Il = db.tbl_sehir_il.Where(k => k.id == a.il_id).Select(k => k.baslik).FirstOrDefault(),
                               Ilce = db.tbl_sehir_ilce.Where(k => k.id == a.ilce_id).Select(k => k.baslik).FirstOrDefault(),
                               Semt = db.tbl_sehir_semt.Where(k => k.id == a.semt_id).Select(k => k.baslik).FirstOrDefault(),
                               a.mevki,
                               a.adres,
                               a.ozellik,
                               a.koordinat,
                               a.adres_goster,
                               a.tarih_ek,
                               a.tarih_gun
                           }).AsEnumerable();

                if (SQL.Any())
                {
                    foreach (var item in SQL)
                    {
                        Page.Title = item.baslik + " | " + Class.Fonksiyonlar.Genel.Parametre().Select(b => b.seo_baslik).FirstOrDefault();
                        kategoriadi.Text = item.baslik;
                        nerdesin.Text = item.Kategori + " &raquo; " + item.baslik;
                        IlanNo.Text = item.kod;

                        StringBuilder sb = new StringBuilder();
                        sb.Append("<table width=\"100%\"><tr>");
                        string[] DiziOzellik = item.ozellik.Split(',');
                        int x = 0;
                        for (int i = 0; i < DiziOzellik.Length; i++)
                        {
                            sb.Append("<td><img src=\"/img/ozellik_icon.jpg\" alt=\"" + OzellikCagir(int.Parse(DiziOzellik[i])) + "\" /> " + OzellikCagir(int.Parse(DiziOzellik[i])) + "</td>");

                            if (x == 4)
                            {
                                sb.Append("</tr><tr>");
                                x = 0;
                            }
                            else
                            {
                                x++;
                            }
                        }
                        sb.Append("</tr></table>");
                        ozellik2.Text = sb.ToString();

                        if (item.koordinat != "39.368279, 35.657959")
                        {
                            kategoriilanbaslik.Text += "<li><a href=\"#tab2\">Civar Bilgisi</a></li>";
                            kategoriilandetay.Text += "<div class=\"tablar\" id=\"tab2\"><div id=\"map_canvas\" style=\"height:400px; width:100%;\"></div></div>";
                            mapkoordinat.Text = item.koordinat;
                            mapzoom.Text = "15";
                        }

                        StringBuilder sb1 = new StringBuilder();
                        sb.Append("<h3 class=\"ilandetayfiyat\">" + String.Format("{0:N0}", item.fiyat) + " " + item.fiyat_tur + "</h3><br />");
                        sb.Append("<table width=\"100%\">");
                        sb.Append("<tr><td height=\"20px\"><strong>İlan Tarihi</strong></td><td>" + item.tarih_ek.ToLongDateString() + "</td></tr>");

                        if (item.tarih_gun.ToString() != "")
                        {
                            sb.Append("<tr><td height=\"20px\"><strong>Güncelleme Tarihi</strong></td><td>" + item.tarih_gun.Value.ToLongDateString() + "</td></tr>");
                        }

                        using (BaglantiCumlesi db2 = new BaglantiCumlesi())
                        {
                            var SQL2 = (from a in db2.tbl_ilan_detay
                                        where a.ilan_id == item.id
                                        select new
                                        {
                                            Deger1 = db2.tbl_ilan_sabit.Where(b => b.id == a.sabit_id).Select(b => b.sabit).FirstOrDefault(),
                                            a.deger
                                        }).AsEnumerable();

                            if (SQL2.Any())
                            {
                                foreach (var item2 in SQL2)
                                {
                                    sb.Append("<tr><td height=\"20px\"><strong>" + item2.Deger1 + "</strong></td><td>" + item2.deger + "</td></tr>");
                                }
                            }
                        }

                        sb.Append("</table>");
                        ozellik1.Text = sb1.ToString();
                    }
                }
            }

            using (BaglantiCumlesi db = new BaglantiCumlesi())
            {
                var SQL = (from a in db.tbl_ilan_resim
                           where a.onay == true && a.ilan_id == ID
                           select new
                           {
                               a.id,
                               a.resim,
                               IlanTur = db.tbl_ilan.Where(k => k.id == ID).Select(k => k.ilan_tur).FirstOrDefault(),
                               Kategori = db.tbl_kategori.Where(k => k.id == (db.tbl_ilan.Where(c => c.id == ID).Select(c => c.kat_id).FirstOrDefault())).Select(k => k.baslik).FirstOrDefault(),
                               Baslik = db.tbl_ilan.Where(k => k.id == ID).Select(k => k.baslik).FirstOrDefault()
                           }).AsEnumerable();

                if (SQL.Any())
                {
                    StringBuilder sb = new StringBuilder();
                    sb.Append("<div id=\"gallery\" class=\"ad-gallery\">\r\n<div class=\"ad-image-wrapper\"></div>\r\n<div class=\"ad-controls\"></div>\r\n<div class=\"ad-nav\">\r\n<div class=\"ad-thumbs\">\r\n<ul class=\"ad-thumb-list\">");
                    foreach (var item in SQL)
                    {
                        sb.Append("<li><a href=\"/Include/ResimGoster.aspx?R=/upload/ilan/" + item.resim + "&G=1024&Y=1024\"><img style=\"height:60px; width:90px;\" src=\"/Include/ResimGoster.aspx?R=/upload/ilan/" + item.resim + "&G=100&Y=60\" title=\"" + item.IlanTur + " " + item.Kategori + "\" alt=\"" + item.Baslik + "\" /></a></li>");
                    }
                    sb.Append("</ul></div></div></div>");
                    ilanresim.Text = sb.ToString();
                }
            }
        }

        protected string OzellikCagir(int ID)
        {
            string str = string.Empty;
            using (BaglantiCumlesi db = new BaglantiCumlesi())
            {
                var SQL = from a in db.tbl_ilan_ozellik where a.id == ID select new { a.baslik };
                if (SQL.Any())
                {
                    foreach (var item in SQL)
                    {
                        str = item.baslik;
                    }
                }
            }
            return str;
        }

        protected void VitrinIlan()
        {
            using (BaglantiCumlesi db = new BaglantiCumlesi())
            {
                var SQL = (from a in db.tbl_ilan
                           where a.onay == true && a.vitrin == true && a.arsiv == false
                           orderby a.tarih_ek descending
                           select new
                           {
                               a.id,
                               a.baslik,
                               a.fiyat,
                               a.fiyat_tur,
                               a.ilan_tur,
                               Kategori = db.tbl_kategori.Where(k => k.id == a.kat_id).Select(k => k.baslik).FirstOrDefault(),
                               Il = db.tbl_sehir_il.Where(k => k.id == a.il_id).Select(k => k.baslik).FirstOrDefault(),
                               Ilce = db.tbl_sehir_ilce.Where(k => k.id == a.ilce_id).Select(k => k.baslik).FirstOrDefault(),
                               Resim = db.tbl_ilan_resim.Where(k => k.ilan_id == a.id && k.varsayilan == true && k.onay == true).Select(k => k.resim).FirstOrDefault()
                           }).AsEnumerable().Take(15);

                if (SQL.Any())
                {
                    StringBuilder sb = new StringBuilder();
                    foreach (var item in SQL)
                    {
                        sb.Append("<li class=\"vitrinilanitem\">");
                        sb.Append("<div class=\"vitrinilanresim\" style=\"background:url(/Include/ResimGoster.aspx?R=/upload/ilan/" + item.Resim + "&G=200&Y=160) no-repeat center;\"></div>");
                        sb.Append("<div class=\"clear h10\"></div>");
                        sb.Append("<div class=\"ilandetay\">");
                        sb.Append("<span class=\"ilanbaslik\">" + item.ilan_tur + " " + item.Kategori + "</span><br />");
                        sb.Append("" + item.Il + "/" + item.Ilce + "<br />");
                        sb.Append("<span class=\"ilanfiyat\">" + String.Format("{0:N0}", item.fiyat) + " " + item.fiyat_tur + "</span><br />");
                        sb.Append("" + item.baslik + "<br /><br />");
                        sb.Append("<img src=\"/imge/iconbina.png\" alt=\"" + item.baslik + "\" /> <a href=\"" + Class.Fonksiyonlar.Genel.SeoLinkOlustur("ilan", item.id.ToString(), item.baslik) + "\">İlanı detayları</a><br />");
                        sb.Append("</div>");
                        sb.Append("</li>");
                    }
                    vitrinilan.Text = sb.ToString();
                }
            }
        }
    }
}