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

        Page.MetaDescription = Class.Fonksiyonlar.Genel.ParametreAl("Aciklama");
        Page.MetaKeywords = Class.Fonksiyonlar.Genel.ParametreAl("Anahtar");

        VitrinIlan();
        Ilan();
    }

    protected void Ilan()
    {
        int ID = 0;

        if (RouteData.Values["KategoriID"] != null && Class.Fonksiyonlar.Genel.NumerikKontrol(RouteData.Values["KategoriID"].ToString()))
        {
            ID = int.Parse(RouteData.Values["KategoriID"].ToString());
        }
        else
        {
            Response.Redirect("/Default.aspx");
        }

        using (BaglantiCumlesi db = new BaglantiCumlesi())
        {
            var SQL = from a in db.kategori
                      where a.Onay == 1 && a.ID == ID
                      select new
                      {
                          a.Baslik
                      };

            if (SQL.AsEnumerable().Count()>0)
            {
                foreach (var item in SQL)
                {
                    Page.Title = item.Baslik + " | " + Class.Fonksiyonlar.Genel.ParametreAl("Baslik");
                    kategoriadi.Text = item.Baslik;
                    nerdesin.Text = item.Baslik;
                }
            }
        }

        using (BaglantiCumlesi db = new BaglantiCumlesi())
        {
            var SQL = from a in db.ilan
                      where a.Onay == 1 && a.KatID == ID && a.Arsiv == 0
                      orderby a.IlanTur descending
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

            if (SQL.AsEnumerable().Count() == 0)
            {
                datalistbos.Text = "Eklenmiş ilan bulunmuyor!<br /><br />Daha detaylı bilgi almak için bizimle <a href=\"/Iletisim.aspx\">iletişime</a> geçiniz.";
            }

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