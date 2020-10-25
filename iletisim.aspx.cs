using System;
using System.Linq;
using System.Text;
using System.Web.UI;

namespace emlak
{
    public partial class iletisim : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Class.Fonksiyonlar.Sayac();

            Page.MetaDescription = Class.Fonksiyonlar.Genel.Parametre().Select(b => b.seo_aciklama).FirstOrDefault();
            Page.MetaKeywords = Class.Fonksiyonlar.Genel.Parametre().Select(b => b.seo_anahtar).FirstOrDefault();

            VitrinIlan();
            Page.Title = "İletişim | " + Class.Fonksiyonlar.Genel.Parametre().Select(b => b.seo_baslik).FirstOrDefault();
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