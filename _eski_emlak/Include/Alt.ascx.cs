using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySQLDataModel;

public partial class Include_Alt : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        AltMenuSayfa();
        AltMenuKategori();
    }

    protected void AltMenuSayfa()
    {
        using (BaglantiCumlesi db=new BaglantiCumlesi())
        {
            var SQL = from a in db.sayfa
                      where a.Onay == 1 && a.AltMenu == 1
                      orderby a.Sira ascending
                      select new
                      {
                          a.ID,
                          a.Baslik
                      };

            if (SQL.AsEnumerable().Count()>0)
            {
                altmenusayfa.Text = "";
                foreach (var item in SQL)
                {
                    altmenusayfa.Text += "<li><a href=\"" + Class.Fonksiyonlar.Genel.SeoLinkOlustur("sayfa", item.ID.ToString(), item.Baslik) + "\">" + item.Baslik.ToLower() + "</a></li>";
                }
            }
        }
    }

    protected void AltMenuKategori()
    {
        using (BaglantiCumlesi db = new BaglantiCumlesi())
        {
            var SQL = from a in db.kategori
                      where a.Onay == 1 && a.AltMenu == 1
                      orderby a.Sira ascending
                      select new
                      {
                          a.ID,
                          a.Baslik
                      };

            if (SQL.AsEnumerable().Count() > 0)
            {
                altmenukategori.Text = "";
                foreach (var item in SQL)
                {
                    altmenukategori.Text += "<li><a href=\"" + Class.Fonksiyonlar.Genel.SeoLinkOlustur("kategori", item.ID.ToString(), item.Baslik) + "\">" + item.Baslik.ToLower() + "</a></li>";
                }
            }
        }
    }
}