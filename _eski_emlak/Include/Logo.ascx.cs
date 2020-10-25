using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySQLDataModel;

public partial class Include_Ust : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        UstMenuSayfa();
        AnaKategori();

        if (!IsPostBack)
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
                form_kategori.Items.Add(new ListItem("Seçiniz"));
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
                form_il.Items.Add(new ListItem("İl Seçiniz"));
                foreach (var item in SQL)
                {
                    form_il.Items.Add(new ListItem(item.Baslik, item.ID.ToString()));
                }
            }
        }
    }

    protected void UstMenuSayfa()
    {
        using (BaglantiCumlesi db = new BaglantiCumlesi())
        {
            var SQL = from a in db.sayfa
                      where a.Onay == 1 && a.AnaMenu == 1
                      orderby a.Sira ascending
                      select new
                      {
                          a.ID,
                          a.Baslik
                      };

            if (SQL.AsEnumerable().Count() > 0)
            {
                ustmenusayfa.Text = "";
                foreach (var item in SQL)
                {
                    ustmenusayfa.Text += "<li><h3><a href=\"" + Class.Fonksiyonlar.Genel.SeoLinkOlustur("sayfa", item.ID.ToString(), item.Baslik) + "\">" + item.Baslik.ToLower() + "</a></h3></li>";
                }
            }
        }
    }

    protected void AnaKategori()
    {
        using (BaglantiCumlesi db = new BaglantiCumlesi())
        {
            var SQL = from a in db.kategori
                      where a.Onay == 1
                      orderby a.Sira ascending
                      select new
                      {
                          a.ID,
                          a.Baslik
                      };

            if (SQL.AsEnumerable().Count() > 0)
            {
                kategori.Text = "<li><h3><a href=\"/\">Ana Sayfa</a></h3></li>";
                foreach (var item in SQL)
                {
                    kategori.Text += "<li><h3><a href=\"" + Class.Fonksiyonlar.Genel.SeoLinkOlustur("kategori", item.ID.ToString(), item.Baslik) + "\">" + item.Baslik + "</a></h3></li>";
                }
                kategori.Text += "<li><h3><a style=\"color:#990000;\" href=\"/EmlakTalep.aspx\">Emlak Talebinde Bulun</a></h3></li>";
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
                form_ilce.Items.Add(new ListItem("İlçe Seçiniz"));
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
}