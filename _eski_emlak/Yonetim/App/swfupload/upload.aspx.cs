using System;
using System.IO;
using System.Linq;
using System.Web;
using MySQLDataModel;

public partial class upload : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            int IlanID = int.Parse(Request["id"]);
            HttpPostedFile postedFile = Request.Files["Filedata"];
            string ResimAdi = Guid.NewGuid().ToString() + Path.GetExtension(postedFile.FileName);

            postedFile.SaveAs(Server.MapPath("/Upload/Ilan/" + ResimAdi + ""));

            using (BaglantiCumlesi db = new BaglantiCumlesi())
            {
                ilan_resim Tbl = new ilan_resim();
                Tbl.IlanID = IlanID;
                Tbl.Resim = ResimAdi;

                if (db.ilan_resim.Where(b => b.IlanID == IlanID && b.Varsayilan == 1).Count() == 0)
                {
                    Tbl.Varsayilan = 1;
                }
                else
                {
                    Tbl.Varsayilan = 0;
                }

                Tbl.Onay = 1;
                Tbl.KayitTarih = DateTime.Now;
                //Tbl.EkleyenID = int.Parse(HttpContext.Current.Request.Cookies["" + Class.Fonksiyonlar.Genel.ParametreAl("GuvenlikKodu") + "KullaniciID"].Value);
                db.AddToilan_resim(Tbl);
                db.SaveChanges();
                Yonetim.Olay.Islem("ilan_resim", "Yeni Kayýt", "");
            }
        }
        catch
        {
            Response.End();
        }
    }
}
