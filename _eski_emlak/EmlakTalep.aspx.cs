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

        Page.Title = "Emlak Talebinde Bulun | " + Class.Fonksiyonlar.Genel.ParametreAl("Baslik");
        Page.MetaDescription = Class.Fonksiyonlar.Genel.ParametreAl("Aciklama");
        Page.MetaKeywords = Class.Fonksiyonlar.Genel.ParametreAl("Anahtar");

        VitrinIlan();

        if (!Page.IsPostBack)
        {
            Kayitlar();
        }
        
    }

    protected void Kayitlar()
    {
        // kategori dropbox
        using (BaglantiCumlesi db = new BaglantiCumlesi())
        {
            var SQL = from a in db.kategori where a.Onay == 1 orderby a.Baslik ascending select new { a.ID, a.Baslik };

            if (SQL.AsEnumerable().Count() > 0)
            {
                form_kategori.Items.Clear();
                form_kategori.Items.Add(new ListItem("Seçiniz", "0"));
                foreach (var item in SQL)
                {
                    form_kategori.Items.Add(new ListItem(item.Baslik, item.ID.ToString()));
                }
            }
        }

        // il dropbox
        using (BaglantiCumlesi db = new BaglantiCumlesi())
        {
            var SQL = from a in db.sehir_il where a.Onay == 1 orderby a.Baslik ascending select new { a.ID, a.Baslik };

            if (SQL.AsEnumerable().Count() > 0)
            {
                form_il.Items.Clear();
                form_il.Items.Add(new ListItem("İl Seçiniz", "0"));
                foreach (var item in SQL)
                {
                    form_il.Items.Add(new ListItem(item.Baslik, item.ID.ToString()));
                }
            }
        }
    }

    protected void form_il_SelectedIndexChanged(object sender, EventArgs e)
    {
        // ilçe dropbox
        int IlID = int.Parse(form_il.SelectedValue);
        using (BaglantiCumlesi db = new BaglantiCumlesi())
        {
            var SQL = from a in db.sehir_ilce where a.Onay == 1 && a.IlID == IlID orderby a.Baslik ascending select new { a.ID, a.Baslik };

            if (SQL.AsEnumerable().Count() > 0)
            {
                form_ilce.Items.Add(new ListItem("İlçe Seçiniz", "0"));
                foreach (var item in SQL)
                {
                    form_ilce.Items.Add(new ListItem(item.Baslik, item.ID.ToString()));
                }
            }
        }

        form_ilce.Enabled = true;
    }

    protected void form_ilce_SelectedIndexChanged(object sender, EventArgs e)
    {
        // semt dropbox
        int IlceID = int.Parse(form_ilce.SelectedValue);
        using (BaglantiCumlesi db = new BaglantiCumlesi())
        {
            var SQL = from a in db.sehir_semt where a.Onay == 1 && a.IlceID == IlceID orderby a.Baslik ascending select new { a.ID, a.Baslik };

            if (SQL.AsEnumerable().Count() > 0)
            {
                form_semt.Items.Add(new ListItem("Semt Seçiniz"));
                foreach (var item in SQL)
                {
                    form_semt.Items.Add(new ListItem(item.Baslik, item.ID.ToString()));
                }
            }
        }

        form_semt.Enabled = true;
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

    protected void btn_emlak_talep_Click(object sender, EventArgs e)
    {
        try
        {
            using (BaglantiCumlesi db=new BaglantiCumlesi())
            {
                talep Tbl = new talep();
                Tbl.IlanTur = form_ilantur.SelectedValue;
                Tbl.KatID = int.Parse(form_kategori.SelectedValue);
                Tbl.Il = int.Parse(form_il.SelectedValue);
                Tbl.Ilce = int.Parse(form_ilce.SelectedValue);
                Tbl.Semt = int.Parse(form_semt.SelectedValue);
                Tbl.Adi = form_ad.Text;
                Tbl.Telefon = form_telefon.Text;
                Tbl.EPosta = form_eposta.Text;
                Tbl.Mesaj = form_mesaj.Text;
                Tbl.Durum = "Bekliyor";
                Tbl.IPAdres = Request.ServerVariables["REMOTE_ADDR"].ToString();
                Tbl.KayitTarih = DateTime.Now;
                db.AddTotalep(Tbl);
                db.SaveChanges();
            }
            Class.Fonksiyonlar.JavaScript.MesajKutusuVeYonlendir("Emlak talebiniz tarafımıza ulaşmıştır. Tarafınıza en kısa sürede cevap verilecektir.","EmlakTalep.aspx");
        }
        catch (Exception ex)
        {
            Class.Fonksiyonlar.JavaScript.MesajKutusuVeYonlendir("Beklenmedik bir hata oluştu. Hata: " + ex.Message + "", "EmlakTalep.aspx");
        }
    }
}