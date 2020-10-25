using System;
using System.Linq;
using System.Web;

namespace emlak.admin.ascx
{
    public partial class ust : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Kayitlar();
        }

        protected void Kayitlar()
        {
            int ID = int.Parse(HttpContext.Current.Request.Cookies["" + Class.Fonksiyonlar.Genel.Parametre().Select(b => b.guvenlik_kodu).FirstOrDefault() + "KullaniciID"].Value);
            using (BaglantiCumlesi db = new BaglantiCumlesi())
            {
                var SQL = (from a in db.tbl_admin
                           where a.id == ID
                           select new
                           {
                               a.ad,
                               a.eposta
                           }).AsEnumerable();

                if (SQL.Any())
                {
                    foreach (var item in SQL)
                    {
                        kullaniciadi.Text = item.ad + " (" + item.eposta + ")";
                    }
                }
            }

            using (BaglantiCumlesi db = new BaglantiCumlesi())
            {
                var SQL = (from a in db.tbl_mesaj_kutu
                           where a.alici_id == ID && a.okundu == false
                           select new
                           {
                               a.id
                           }).Count();

                if (SQL > 0)
                {
                    mesaj.Text = "<img src=\"img/mesajvar.png\" alt=\"" + SQL + " Yeni mesajınız var!\" /> <a href=\"mesaj-kutu.aspx\">" + SQL + " Yeni mesajınız var!</a>";
                }
                else
                {
                    mesaj.Text = "<img src=\"img/mesaj.png\" alt=\"Hiç mesajınız yok.\" /> <a href=\"mesaj-kutu.aspx\">Hiç mesajınız yok.</a>";
                }
            }
        }
    }
}