using System;
using System.Linq;
using System.Web;

namespace emlak.admin
{
    public partial class mesaj_yeni : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Class.Fonksiyonlar.Genel.OturumIslemleri.CookieKontrol();

            if (!Page.IsPostBack)
            {
                Kullanicilar();
                Kayitlar();
            }
        }

        protected void Kayitlar()
        {
            if (Request.QueryString["KID"] != null && Request.QueryString["KID"] != "")
            {
                form_aliciID.Text = Request.QueryString["KID"].ToString();
            }

            if (Request.QueryString["MID"] != null && Request.QueryString["MID"] != "")
            {
                int ID = int.Parse(Request.QueryString["MID"]);
                using (BaglantiCumlesi db = new BaglantiCumlesi())
                {
                    var SQL = (from a in db.tbl_mesaj_kutu
                               where a.id == ID
                               select new
                               {
                                   a.detay,
                                   Gonderen = db.tbl_admin.Where(p => p.id == a.gonderen_id).Select(p => p.ad).FirstOrDefault()
                               }).AsEnumerable();

                    if (SQL.Any())
                    {
                        foreach (var item in SQL)
                        {
                            form_detay.Text = "<br /><br /><em>Alıntı ----------------------------------------</em><br /><br />";
                            form_detay.Text += "<strong>Gönderen:</strong> " + item.Gonderen + "<br /><br />" + item.detay;
                        }
                    }
                }
            }
        }

        protected void Kullanicilar()
        {
            using (BaglantiCumlesi db = new BaglantiCumlesi())
            {
                var SQL = from a in db.tbl_admin select new { a.id, a.ad };
                form_aliciID.DataSource = SQL;
                form_aliciID.DataBind();
            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            try
            {
                using (BaglantiCumlesi db = new BaglantiCumlesi())
                {
                    tbl_mesaj_kutu Tbl = new tbl_mesaj_kutu();
                    Tbl.alici_id = int.Parse(form_aliciID.SelectedValue);
                    Tbl.gonderen_id = int.Parse(HttpContext.Current.Request.Cookies["" + Class.Fonksiyonlar.Genel.Parametre().Select(b => b.guvenlik_kodu).FirstOrDefault() + "KullaniciID"].Value);
                    Tbl.baslik = form_konu.Text;
                    Tbl.detay = form_detay.Text;
                    Tbl.okundu = false;
                    db.AddTotbl_mesaj_kutu(Tbl);
                    db.SaveChanges();
                }

                Yonetim.Olay.Islem("mesaj", "Yeni Kayıt", "");
                Class.Fonksiyonlar.JavaScript.MesajKutusuVeYonlendir("Mesaj başarıyla gönderilmiştir. Mesaj kutusuna yönlendiriliyorsunuz.", "mesaj-kutu.aspx");
            }
            catch (Exception ex)
            {
                Class.Fonksiyonlar.JavaScript.MesajKutusuVeYonlendir(Yonetim.Degiskenler.Hata + ex.Message, "mesaj-yeni.aspx");
            }
        }
    }
}