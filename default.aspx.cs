using System;
using System.Linq;
using System.Text;
using System.Web.UI;

namespace emlak
{
    public partial class _default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Class.Fonksiyonlar.Sayac();

            Page.Title = Class.Fonksiyonlar.Genel.Parametre().Select(b => b.seo_baslik).FirstOrDefault();
            Page.MetaDescription = Class.Fonksiyonlar.Genel.Parametre().Select(b => b.seo_aciklama).FirstOrDefault();
            Page.MetaKeywords = Class.Fonksiyonlar.Genel.Parametre().Select(b => b.seo_anahtar).FirstOrDefault();

            VitrinIlan();
            SonEklenenIlan();
            KategoriIlan();
        }

        protected void KategoriIlan()
        {
            using (BaglantiCumlesi db = new BaglantiCumlesi())
            {
                var SQL = (from a in db.tbl_kategori
                           where a.onay == true
                           select new
                           {
                               a.id,
                               a.baslik,
                               IlanSayi = db.tbl_ilan.Where(k => k.kat_id == a.id & k.onay == true).Count()
                           });

                if (SQL.Any())
                {
                    kategoriilanbaslik.Text = "";
                    kategoriilandetay.Text = "";
                    foreach (var item in SQL)
                    {
                        if (item.IlanSayi != 0)
                        {
                            kategoriilanbaslik.Text += "<li><a href=\"#tab" + item.id + "\">" + item.baslik + "</a></li>";
                            kategoriilandetay.Text += "<div class=\"tablar\" id=\"tab" + item.id + "\">" + KategoriIlanGetir(item.id) + "</div>";
                        }
                    }
                }
            }
        }

        private string KategoriIlanGetir(int ID)
        {
            StringBuilder sb = new StringBuilder();

            using (BaglantiCumlesi db = new BaglantiCumlesi())
            {
                var SQL = (from a in db.tbl_ilan
                           where a.onay == true && a.kat_id == ID && a.arsiv == false
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
                           }).AsEnumerable();

                string Html = string.Empty;

                if (SQL.Any())
                {
                    int i = 1;

                    sb.Append("<table><tr>");
                    foreach (var item in SQL)
                    {
                        sb.Append("<td><div class=\"vitrinilanitem\"  style=\"background:#F4F4F4;\">");
                        sb.Append("<div class=\"vitrinilanresim\" style=\"background:url(/Include/ResimGoster.aspx?R=/upload/ilan/" + item.Resim + "&G=200&Y=160) no-repeat center;\"></div>");
                        sb.Append("<div class=\"clear h10\"></div>");
                        sb.Append("<div class=\"ilandetay\">");
                        sb.Append("<span class=\"ilanbaslik\">" + item.ilan_tur + " " + item.Kategori + "</span><br />");
                        sb.Append("" + item.Il + "/" + item.Ilce + "<br />");
                        sb.Append("<span class=\"ilanfiyat\">" + String.Format("{0:N0}", item.fiyat) + " " + item.fiyat_tur + "</span><br />");
                        sb.Append("" + item.baslik + "<br /><br />");
                        sb.Append("<img src=\"/img/iconbina.png\" alt=\"" + item.baslik + "\" /> <a href=\"" + Class.Fonksiyonlar.Genel.SeoLinkOlustur("ilan", item.id.ToString(), item.baslik) + "\">İlanı detayları</a><br />");
                        sb.Append("</div>");
                        sb.Append("</div></td>");

                        if (i == 5)
                        {
                            sb.Append("</tr><tr>");
                            i = 1;
                        }
                        else
                        {
                            i++;
                        }
                    }
                    sb.Append("</tr></table>");
                }

                return sb.ToString();
            }
        }

        protected void SonEklenenIlan()
        {
            using (BaglantiCumlesi db = new BaglantiCumlesi())
            {
                var SQL = (from a in db.tbl_ilan
                           where a.onay == true && a.arsiv == true
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
                           }).AsEnumerable().Take(10);

                soneklenenilan.DataSource = SQL;
                soneklenenilan.DataBind();
            }
        }

        protected void VitrinIlan()
        {
            using (BaglantiCumlesi db = new BaglantiCumlesi())
            {
                var SQL = (from a in db.tbl_ilan
                           where a.onay == true && a.vitrin == true
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
                               resim = (db.tbl_ilan_resim.Where(k => k.ilan_id == a.id && k.varsayilan == true && k.onay == true).Select(k => k.resim).FirstOrDefault())
                           }).AsEnumerable().Take(15);

                if (SQL.Any())
                {
                    StringBuilder sb = new StringBuilder();
                    foreach (var item in SQL)
                    {
                        sb.Append("<li class=\"vitrinilanitem\">");
                        sb.Append("<div class=\"vitrinilanresim\" style=\"background:url(/Include/ResimGoster.aspx?R=/upload/ilan/" + item.resim + "&G=200&Y=160) no-repeat center;\"></div>");
                        sb.Append("<div class=\"clear h10\"></div>");
                        sb.Append("<div class=\"ilandetay\">");
                        sb.Append("<span class=\"ilanbaslik\">" + item.ilan_tur + " " + item.Kategori + "</span><br />");
                        sb.Append("" + item.Il + "/" + item.Ilce + "<br />");
                        sb.Append("<span class=\"ilanfiyat\">" + String.Format("{0:N0}", item.fiyat) + " " + item.fiyat_tur + "</span><br />");
                        sb.Append("" + item.baslik + "<br /><br />");
                        sb.Append("<img src=\"/Image/iconbina.png\" alt=\"" + item.baslik + "\" /> <a href=\"" + Class.Fonksiyonlar.Genel.SeoLinkOlustur("ilan", item.id.ToString(), item.baslik) + "\">İlanı detayları</a><br />");
                        sb.Append("</div>");
                        sb.Append("</li>");
                    }
                    vitrinilan.Text = sb.ToString();
                }
            }
        }
    }
}