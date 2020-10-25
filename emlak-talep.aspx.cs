using System;
using System.Linq;
using System.Text;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace emlak
{
    public partial class emlak_talep : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Class.Fonksiyonlar.Sayac();

            Page.Title = "Emlak Talebinde Bulun | " + Class.Fonksiyonlar.Genel.Parametre().Select(b => b.seo_baslik).FirstOrDefault();
            Page.MetaDescription = Class.Fonksiyonlar.Genel.Parametre().Select(b => b.seo_aciklama).FirstOrDefault();
            Page.MetaKeywords = Class.Fonksiyonlar.Genel.Parametre().Select(b => b.seo_anahtar).FirstOrDefault();

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
                var SQL = (from a in db.tbl_kategori
                           where a.onay == true
                           orderby a.baslik ascending
                           select new
                           {
                               a.id,
                               a.baslik
                           }).AsEnumerable();

                if (SQL.Any())
                {
                    form_kategori.Items.Clear();
                    form_kategori.Items.Add(new ListItem("Seçiniz", "0"));
                    foreach (var item in SQL)
                    {
                        form_kategori.Items.Add(new ListItem(item.baslik, item.id.ToString()));
                    }
                }
            }

            // il dropbox
            using (BaglantiCumlesi db = new BaglantiCumlesi())
            {
                var SQL = (from a in db.tbl_sehir_il
                           where a.onay == true
                           orderby a.baslik ascending
                           select new
                           {
                               a.id,
                               a.baslik
                           }).AsEnumerable();

                if (SQL.Any())
                {
                    form_il.Items.Clear();
                    form_il.Items.Add(new ListItem("İl Seçiniz", "0"));
                    foreach (var item in SQL)
                    {
                        form_il.Items.Add(new ListItem(item.baslik, item.id.ToString()));
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
                var SQL = (from a in db.tbl_sehir_ilce
                           where a.onay == true && a.il_id == IlID
                           orderby a.baslik ascending
                           select new
                           {
                               a.id,
                               a.baslik
                           }).AsEnumerable();

                if (SQL.Any())
                {
                    form_ilce.Items.Add(new ListItem("İlçe Seçiniz", "0"));
                    foreach (var item in SQL)
                    {
                        form_ilce.Items.Add(new ListItem(item.baslik, item.id.ToString()));
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
                var SQL = (from a in db.tbl_sehir_semt
                           where a.onay == true && a.ilce_id == IlceID
                           orderby a.baslik ascending
                           select new
                           {
                               a.id,
                               a.baslik
                           }).AsEnumerable();

                if (SQL.Any())
                {
                    form_semt.Items.Add(new ListItem("Semt Seçiniz"));
                    foreach (var item in SQL)
                    {
                        form_semt.Items.Add(new ListItem(item.baslik, item.id.ToString()));
                    }
                }
            }

            form_semt.Enabled = true;
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
                        sb.Append("<img src=\"/Image/iconbina.png\" alt=\"" + item.baslik + "\" /> <a href=\"" + Class.Fonksiyonlar.Genel.SeoLinkOlustur("ilan", item.id.ToString(), item.baslik) + "\">İlanı detayları</a><br />");
                        sb.Append("</div>");
                        sb.Append("</li>");
                    }
                    vitrinilan.Text = sb.ToString();
                }
            }
        }

        protected void btn_emlak_talep_Click(object sender, EventArgs e)
        {
            try
            {
                using (BaglantiCumlesi db = new BaglantiCumlesi())
                {
                    tbl_talep Tbl = new tbl_talep();
                    Tbl.ilan_tur = form_ilantur.SelectedValue;
                    Tbl.kat_id = int.Parse(form_kategori.SelectedValue);
                    Tbl.il_id = int.Parse(form_il.SelectedValue);
                    Tbl.ilce_id = int.Parse(form_ilce.SelectedValue);
                    Tbl.semt_id = int.Parse(form_semt.SelectedValue);
                    Tbl.ad = form_ad.Text;
                    Tbl.telefon = form_telefon.Text;
                    Tbl.eposta = form_eposta.Text;
                    Tbl.mesaj = form_mesaj.Text;
                    Tbl.durum = "Bekliyor";
                    Tbl.ip = Request.ServerVariables["REMOTE_ADDR"].ToString();
                    db.AddTotbl_talep(Tbl);
                    db.SaveChanges();
                }
                Class.Fonksiyonlar.JavaScript.MesajKutusuVeYonlendir("Emlak talebiniz tarafımıza ulaşmıştır. Tarafınıza en kısa sürede cevap verilecektir.", "emlak-talep.aspx");
            }
            catch (Exception ex)
            {
                Class.Fonksiyonlar.JavaScript.MesajKutusuVeYonlendir("Beklenmedik bir hata oluştu. Hata: " + ex.Message + "", "emlak-talep.aspx");
            }
        }
    }
}