using System;
using System.Linq;
using System.Text;

namespace emlak.ascx
{
    public partial class alt : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AltMenuSayfa();
            AltMenuKategori();
        }

        protected void AltMenuSayfa()
        {
            using (BaglantiCumlesi db = new BaglantiCumlesi())
            {
                var SQL = (from a in db.tbl_sayfa
                           where a.onay == true && a.alt_menu == true
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
                        sb.Append("<li><a href=\"" + Class.Fonksiyonlar.Genel.SeoLinkOlustur("sayfa", item.id.ToString(), item.baslik) + "\">" + item.baslik.ToLower() + "</a></li>");
                    }
                    altmenusayfa.Text = sb.ToString();
                }
            }
        }

        protected void AltMenuKategori()
        {
            using (BaglantiCumlesi db = new BaglantiCumlesi())
            {
                var SQL = (from a in db.tbl_kategori
                           where a.onay == true && a.alt_menu == true
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
                        sb.Append("<li><a href=\"" + Class.Fonksiyonlar.Genel.SeoLinkOlustur("kategori", item.id.ToString(), item.baslik) + "\">" + item.baslik.ToLower() + "</a></li>");
                    }
                    altmenukategori.Text = sb.ToString();
                }
            }
        }
    }
}