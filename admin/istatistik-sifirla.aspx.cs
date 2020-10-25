using System;
using System.Linq;

namespace emlak.admin
{
    public partial class istatistik_sifirla : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Class.Fonksiyonlar.Genel.OturumIslemleri.CookieKontrol();
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            using (BaglantiCumlesi db = new BaglantiCumlesi())
            {
                var SQL = from a in db.tbl_sayac select a;
                foreach (var item in SQL)
                {
                    db.tbl_sayac.DeleteObject(item);
                }
                db.SaveChanges();
            }
            Yonetim.Olay.Islem("sayac", "Silindi", "Hepsi");

            using (BaglantiCumlesi db = new BaglantiCumlesi())
            {
                var SQL = from a in db.tbl_sayac_sayfa select a;
                foreach (var item in SQL)
                {
                    db.tbl_sayac_sayfa.DeleteObject(item);
                }
                db.SaveChanges();
            }
            Yonetim.Olay.Islem("sayac_sayfa", "Silindi", "Hepsi");

            Class.Fonksiyonlar.JavaScript.MesajKutusuVeYonlendir("Bütün istatistikler başarıyla sıfırlanmıştır.", "istatistik-sifirla.aspx");
        }
    }
}