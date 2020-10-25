using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Dynamic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySQLDataModel;

public partial class _Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Class.Fonksiyonlar.Sayac();

        Page.Title = Class.Fonksiyonlar.Genel.ParametreAl("Baslik");
        Page.MetaDescription = Class.Fonksiyonlar.Genel.ParametreAl("Aciklama");
        Page.MetaKeywords = Class.Fonksiyonlar.Genel.ParametreAl("Anahtar");

        VitrinIlan();
        SonEklenenIlan();
        KategoriIlan();
    }

    protected void KategoriIlan()
    {
        using (BaglantiCumlesi db = new BaglantiCumlesi())
        {
            var SQL = from a in db.kategori
                      where a.Onay == 1
                      select new
                      {
                          a.ID,
                          a.Baslik,
                          IlanSayi = db.ilan.Where(k => k.KatID == a.ID & k.Onay == 1).Count()
                      };

            if (SQL.AsEnumerable().Count() > 0)
            {
                kategoriilanbaslik.Text = "";
                kategoriilandetay.Text = "";
                foreach (var item in SQL)
                {
                    if (item.IlanSayi != 0)
                    {
                        kategoriilanbaslik.Text += "<li><a href=\"#tab" + item.ID + "\">" + item.Baslik + "</a></li>";
                        kategoriilandetay.Text += "<div class=\"tablar\" id=\"tab" + item.ID + "\">" + KategoriIlanGetir(item.ID) + "</div>";
                    }
                }
            }
        }
    }

    private string KategoriIlanGetir(int ID)
    {
        using (BaglantiCumlesi db = new BaglantiCumlesi())
        {
            var SQL = from a in db.ilan
                      where a.Onay == 1 && a.KatID == ID && a.Arsiv == 0
                      orderby a.KayitTarih descending
                      select new
                      {
                          a.ID,
                          a.Baslik,
                          a.Fiyat,
                          a.FiyatTur,
                          a.IlanTur,
                          Kategori = db.kategori.Where(k => k.ID == a.KatID).Select(k => k.Baslik).FirstOrDefault(),
                          Il = db.sehir_il.Where(k => k.ID == a.Il).Select(k => k.Baslik).FirstOrDefault(),
                          Ilce = db.sehir_ilce.Where(k => k.ID == a.Ilce).Select(k => k.Baslik).FirstOrDefault(),
                          Resim = db.ilan_resim.Where(k => k.IlanID == a.ID && k.Varsayilan == 1 && k.Onay == 1).Select(k => k.Resim).FirstOrDefault()
                      };

            string Html = string.Empty;

            if (SQL.AsEnumerable().Count() > 0)
            {
                int i = 1;
                Html += "<table><tr>";
                foreach (var item in SQL)
                {
                    Html += "<td><div class=\"vitrinilanitem\"  style=\"background:#F4F4F4;\">";
                    Html += "<div class=\"vitrinilanresim\" style=\"background:url(/Include/ResimGoster.aspx?R=/Upload/Ilan/" + item.Resim + "&G=200&Y=160) no-repeat center;\"></div>";
                    Html += "<div class=\"clear h10\"></div>";
                    Html += "<div class=\"ilandetay\">";
                    Html += "<span class=\"ilanbaslik\">" + item.IlanTur + " " + item.Kategori + "</span><br />";
                    Html += "" + item.Il + "/" + item.Ilce + "<br />";
                    Html += "<span class=\"ilanfiyat\">" + String.Format("{0:N0}", item.Fiyat) + " " + item.FiyatTur + "</span><br />";
                    Html += "" + item.Baslik + "<br /><br />";
                    Html += "<img src=\"/Image/iconbina.png\" alt=\"" + item.Baslik + "\" /> <a href=\"" + Class.Fonksiyonlar.Genel.SeoLinkOlustur("ilan", item.ID.ToString(), item.Baslik) + "\">İlanı detayları</a><br />";
                    Html += "</div>";
                    Html += "</div></td>";

                    if (i == 5)
                    {
                        Html += "</tr><tr>";
                        i = 1;
                    }
                    else
                    {
                        i++;
                    }
                }
                Html += "</tr></table>";
            }

            return Html;
        }
    }

    protected void SonEklenenIlan()
    {
        using (BaglantiCumlesi db = new BaglantiCumlesi())
        {
            var SQL = (from a in db.ilan
                       where a.Onay == 1 && a.Arsiv == 0
                       orderby a.KayitTarih descending
                       select new
                       {
                           a.ID,
                           a.Baslik,
                           a.Fiyat,
                           a.FiyatTur,
                           a.IlanTur,
                           Kategori = db.kategori.Where(k => k.ID == a.KatID).Select(k => k.Baslik).FirstOrDefault(),
                           Il = db.sehir_il.Where(k => k.ID == a.Il).Select(k => k.Baslik).FirstOrDefault(),
                           Ilce = db.sehir_ilce.Where(k => k.ID == a.Ilce).Select(k => k.Baslik).FirstOrDefault(),
                           Resim = db.ilan_resim.Where(k => k.IlanID == a.ID && k.Varsayilan == 1 && k.Onay == 1).Select(k => k.Resim).FirstOrDefault()
                       }).Take(10);

            soneklenenilan.DataSource = SQL;
            soneklenenilan.DataBind();
        }
    }

    protected void VitrinIlan()
    {
        using (BaglantiCumlesi db = new BaglantiCumlesi())
        {
            var SQL = (from a in db.ilan
                       where a.Onay == 1 && a.Vitrin == 1 && a.Arsiv == 0
                       orderby a.KayitTarih descending
                       select new
                       {
                           a.ID,
                           a.Baslik,
                           a.Fiyat,
                           a.FiyatTur,
                           a.IlanTur,
                           Kategori = db.kategori.Where(k => k.ID == a.KatID).Select(k => k.Baslik).FirstOrDefault(),
                           Il = db.sehir_il.Where(k => k.ID == a.Il).Select(k => k.Baslik).FirstOrDefault(),
                           Ilce = db.sehir_ilce.Where(k => k.ID == a.Ilce).Select(k => k.Baslik).FirstOrDefault(),
                           Resim = db.ilan_resim.Where(k => k.IlanID == a.ID && k.Varsayilan == 1 && k.Onay == 1).Select(k => k.Resim).FirstOrDefault()
                       }).Take(15);

            if (SQL.AsEnumerable().Count() > 0)
            {
                vitrinilan.Text = "";
                foreach (var item in SQL)
                {
                    vitrinilan.Text += "<li class=\"vitrinilanitem\">";
                    vitrinilan.Text += "<div class=\"vitrinilanresim\" style=\"background:url(/Include/ResimGoster.aspx?R=/Upload/Ilan/" + item.Resim + "&G=200&Y=160) no-repeat center;\"></div>";
                    vitrinilan.Text += "<div class=\"clear h10\"></div>";
                    vitrinilan.Text += "<div class=\"ilandetay\">";
                    vitrinilan.Text += "<span class=\"ilanbaslik\">" + item.IlanTur + " " + item.Kategori + "</span><br />";
                    vitrinilan.Text += "" + item.Il + "/" + item.Ilce + "<br />";
                    vitrinilan.Text += "<span class=\"ilanfiyat\">" + String.Format("{0:N0}", item.Fiyat) + " " + item.FiyatTur + "</span><br />";
                    vitrinilan.Text += "" + item.Baslik + "<br /><br />";
                    vitrinilan.Text += "<img src=\"/Image/iconbina.png\" alt=\"" + item.Baslik + "\" /> <a href=\"" + Class.Fonksiyonlar.Genel.SeoLinkOlustur("ilan", item.ID.ToString(), item.Baslik) + "\">İlanı detayları</a><br />";
                    vitrinilan.Text += "</div>";
                    vitrinilan.Text += "</li>";
                }
            }
        }
    }
}