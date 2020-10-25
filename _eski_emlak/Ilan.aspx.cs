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

        if (RouteData.Values["IlanID"] != null && Class.Fonksiyonlar.Genel.NumerikKontrol(RouteData.Values["IlanID"].ToString()))
        {
            ID = int.Parse(RouteData.Values["IlanID"].ToString());
        }
        else
        {
            Response.Redirect("/Default.aspx");
        }

        using (BaglantiCumlesi db = new BaglantiCumlesi())
        {
            var SQL = from a in db.ilan
                      where a.Onay == 1 && a.ID == ID && a.Arsiv == 0
                      select new
                      {
                          a.ID,
                          Kategori = db.kategori.Where(k => k.ID == a.KatID).Select(k => k.Baslik).FirstOrDefault(),
                          a.IlanTur,
                          a.Kod,
                          a.Baslik,
                          a.Fiyat,
                          a.FiyatTur,
                          a.IlanSure,
                          Il = db.sehir_il.Where(k => k.ID == a.Il).Select(k => k.Baslik).FirstOrDefault(),
                          Ilce = db.sehir_ilce.Where(k => k.ID == a.Ilce).Select(k => k.Baslik).FirstOrDefault(),
                          Semt = db.sehir_semt.Where(k => k.ID == a.Semt).Select(k => k.Baslik).FirstOrDefault(),
                          a.Mevki,
                          a.Adres,
                          a.Ozellik,
                          a.Koordinat,
                          a.AdresGoster,
                          a.KayitTarih,
                          a.DegisTarih
                      };

            if (SQL.AsEnumerable().Count() > 0)
            {
                foreach (var item in SQL)
                {
                    Page.Title = item.Baslik + " | " + Class.Fonksiyonlar.Genel.ParametreAl("Baslik");
                    kategoriadi.Text = item.Baslik;
                    nerdesin.Text = item.Kategori + " &raquo; " + item.Baslik;
                    IlanNo.Text = item.Kod;

                    ozellik2.Text = "<table width=\"100%\"><tr>";
                    string[] DiziOzellik = item.Ozellik.Split(',');
                    int x = 0;
                    for (int i = 0; i < DiziOzellik.Length; i++)
                    {
                        ozellik2.Text += "<td><img src=\"/Image/ozellik_icon.jpg\" alt=\"" + OzellikCagir(int.Parse(DiziOzellik[i])) + "\" /> " + OzellikCagir(int.Parse(DiziOzellik[i])) + "</td>";

                        if (x==4)
                        {
                            ozellik2.Text += "</tr><tr>";
                            x = 0;
                        }
                        else
                        {
                            x++;
                        }
                    }
                    ozellik2.Text += "</tr></table>";

                    if (item.Koordinat != "39.368279, 35.657959")
                    {
                        kategoriilanbaslik.Text += "<li><a href=\"#tab2\">Civar Bilgisi</a></li>";
                        kategoriilandetay.Text += "<div class=\"tablar\" id=\"tab2\"><div id=\"map_canvas\" style=\"height:400px; width:100%;\"></div></div>";
                        mapkoordinat.Text = item.Koordinat;
                        mapzoom.Text = "15";
                    }

                    ozellik1.Text = "<h3 class=\"ilandetayfiyat\">" + String.Format("{0:N0}", item.Fiyat) + " " + item.FiyatTur + "</h3><br />";
                    ozellik1.Text += "<table width=\"100%\">";
                    ozellik1.Text += "<tr><td height=\"20px\"><strong>İlan Tarihi</strong></td><td>" + item.KayitTarih.Value.ToLongDateString() + "</td></tr>";

                    if (item.DegisTarih.ToString() != "")
                    {
                        ozellik1.Text += "<tr><td height=\"20px\"><strong>Güncelleme Tarihi</strong></td><td>" + item.DegisTarih.Value.ToLongDateString() + "</td></tr>";
                    }

                    using (BaglantiCumlesi db2 = new BaglantiCumlesi())
                    {
                        var SQL2 = from a in db2.ilan_detay
                                   where a.IlanID == item.ID
                                   select new
                                   {
                                       Deger1 = db2.ilan_sabit.Where(b => b.ID == a.SabitID).Select(b => b.Sabit).FirstOrDefault(),
                                       a.Deger
                                   };

                        if (SQL2.AsEnumerable().Count() > 0)
                        {
                            foreach (var item2 in SQL2)
                            {
                                ozellik1.Text += "<tr><td height=\"20px\"><strong>" + item2.Deger1 + "</strong></td><td>" + item2.Deger + "</td></tr>";
                            }
                        }
                    }

                    ozellik1.Text += "</table>";
                }
            }
        }

        using (BaglantiCumlesi db = new BaglantiCumlesi())
        {
            var SQL = from a in db.ilan_resim
                      where a.Onay == 1 && a.IlanID == ID
                      select new
                      {
                          a.ID,
                          a.Resim,
                          IlanTur = db.ilan.Where(k => k.ID == ID).Select(k => k.IlanTur).FirstOrDefault(),
                          Kategori = db.kategori.Where(k => k.ID == (db.ilan.Where(c => c.ID == ID).Select(c => c.KatID).FirstOrDefault())).Select(k => k.Baslik).FirstOrDefault(),
                          Baslik = db.ilan.Where(k => k.ID == ID).Select(k => k.Baslik).FirstOrDefault()
                      };

            if (SQL.AsEnumerable().Count() > 0)
            {
                ilanresim.Text = "<div id=\"gallery\" class=\"ad-gallery\">\r\n<div class=\"ad-image-wrapper\"></div>\r\n<div class=\"ad-controls\"></div>\r\n<div class=\"ad-nav\">\r\n<div class=\"ad-thumbs\">\r\n<ul class=\"ad-thumb-list\">";
                foreach (var item in SQL)
                {
                    ilanresim.Text += "<li><a href=\"/Include/ResimGoster.aspx?R=/Upload/Ilan/" + item.Resim + "&G=1024&Y=1024\"><img style=\"height:60px; width:90px;\" src=\"/Include/ResimGoster.aspx?R=/Upload/Ilan/" + item.Resim + "&G=100&Y=60\" title=\"" + item.IlanTur + " " + item.Kategori + "\" alt=\"" + item.Baslik + "\" /></a></li>";
                }
                ilanresim.Text += "</ul></div></div></div>";
            }
        }
    }

    protected string OzellikCagir(int ID)
    {
        string str = string.Empty;
        using (BaglantiCumlesi db=new BaglantiCumlesi())
        {
            var SQL = from a in db.ilan_ozellik where a.ID == ID select new { a.Baslik };
            if (SQL.AsEnumerable().Count() > 0)
            {
                foreach (var item in SQL)
                {
                    str = item.Baslik;
                }
            }
        }
        return str;
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
                           Kategori= db.kategori.Where(k => k.ID == a.KatID).Select(k => k.Baslik).FirstOrDefault(),
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