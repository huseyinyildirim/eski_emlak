using System;
using System.Linq;
using System.Text;
using System.Web.UI.WebControls;

namespace emlak.ascx
{
    public partial class logo : System.Web.UI.UserControl
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
                    form_kategori.Items.Add(new ListItem("Seçiniz"));
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
                    form_il.Items.Add(new ListItem("İl Seçiniz"));
                    foreach (var item in SQL)
                    {
                        form_il.Items.Add(new ListItem(item.baslik, item.id.ToString()));
                    }
                }
            }
        }

        protected void UstMenuSayfa()
        {
            using (BaglantiCumlesi db = new BaglantiCumlesi())
            {
                var SQL = (from a in db.tbl_sayfa
                           where a.onay == true && a.ana_menu == true
                           orderby a.sira ascending
                           select new
                           {
                               a.id,
                               a.baslik
                           }).AsEnumerable();

                if (SQL.Any())
                {
                    StringBuilder sb = new StringBuilder();
                    foreach (var item in SQL)
                    {
                        sb.Append("<li><h3><a href=\"" + Class.Fonksiyonlar.Genel.SeoLinkOlustur("sayfa", item.id.ToString(), item.baslik) + "\">" + item.baslik.ToLower() + "</a></h3></li>");
                    }
                    ustmenusayfa.Text = sb.ToString();
                }
            }
        }

        protected void AnaKategori()
        {
            using (BaglantiCumlesi db = new BaglantiCumlesi())
            {
                var SQL = from a in db.tbl_kategori
                          where a.onay == true
                          orderby a.sira ascending
                          select new
                          {
                              a.id,
                              a.baslik
                          };

                if (SQL.Any())
                {
                    StringBuilder sb = new StringBuilder();
                    sb.Append("<li><h3><a href=\"/\">Ana Sayfa</a></h3></li>");
                    foreach (var item in SQL)
                    {
                        sb.Append("<li><h3><a href=\"" + Class.Fonksiyonlar.Genel.SeoLinkOlustur("kategori", item.id.ToString(), item.baslik) + "\">" + item.baslik + "</a></h3></li>");
                    }
                    sb.Append("<li><h3><a style=\"color:#990000;\" href=\"/emlak-talep.aspx\">Emlak Talebinde Bulun</a></h3></li>");
                    kategori.Text = sb.ToString();
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
                    form_ilce.Items.Add(new ListItem("İlçe Seçiniz"));
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
    }
}