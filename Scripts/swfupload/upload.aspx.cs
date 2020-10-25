using System;
using System.IO;
using System.Linq;
using System.Web;

namespace emlak.Scripts.swfupload
{
    public partial class upload : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                int IlanID = int.Parse(Request["id"]);
                HttpPostedFile postedFile = Request.Files["Filedata"];
                string ResimAdi = Guid.NewGuid().ToString() + Path.GetExtension(postedFile.FileName);

                postedFile.SaveAs(Server.MapPath("/upload/ilan/" + ResimAdi + ""));

                using (BaglantiCumlesi db = new BaglantiCumlesi())
                {
                    tbl_ilan_resim Tbl = new tbl_ilan_resim();
                    Tbl.ilan_id = IlanID;
                    Tbl.resim = ResimAdi;

                    if (db.tbl_ilan_resim.Where(b => b.ilan_id == IlanID && b.varsayilan == true).Count() == 0)
                    {
                        Tbl.varsayilan = true;
                    }
                    else
                    {
                        Tbl.varsayilan = false;
                    }

                    Tbl.onay = true;
                    //Tbl.EkleyenID = int.Parse(HttpContext.Current.Request.Cookies["" + Class.Fonksiyonlar.Genel.Parametre().Select(b => b.guvenlik_kodu).FirstOrDefault() + "KullaniciID"].Value);
                    db.AddTotbl_ilan_resim(Tbl);
                    db.SaveChanges();
                    Yonetim.Olay.Islem("ilan_resim", "Yeni Kayıt", "");
                }
            }
            catch
            {
                Response.End();
            }
        }
    }
}