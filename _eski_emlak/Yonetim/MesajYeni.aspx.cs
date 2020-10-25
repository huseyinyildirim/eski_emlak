using System;
using System.Linq;
using System.Web;
using System.Web.UI;
using MySQLDataModel;

public partial class Yonetim_Kullanici : System.Web.UI.Page
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
            int ID=int.Parse(Request.QueryString["MID"]);
            using (BaglantiCumlesi db=new BaglantiCumlesi())
            {
                var SQL = from a in db.mesaj_kutu
                          where a.ID == ID
                          select new
                          {
                              a.Detay,
                              Gonderen = db.kullanici.Where(p => p.ID == a.GonderenID).Select(p => p.Adi).FirstOrDefault()
                          };

                if (SQL.AsEnumerable().Count() > 0)
                {
                    foreach (var item in SQL)
                    {
                        form_detay.Text = "<br /><br /><em>Alıntı ----------------------------------------</em><br /><br />";
                        form_detay.Text += "<strong>Gönderen:</strong> " + item.Gonderen + "<br /><br />" + item.Detay;
                    }
                }
            }
        }
    }

    protected void Kullanicilar()
    {
        using (BaglantiCumlesi db = new BaglantiCumlesi())
        {
            var SQL = from a in db.kullanici select new { a.ID, a.Adi };
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
                mesaj_kutu Tbl = new mesaj_kutu();
                Tbl.AliciID = int.Parse(form_aliciID.SelectedValue);
                Tbl.GonderenID = int.Parse(HttpContext.Current.Request.Cookies["" + Class.Fonksiyonlar.Genel.ParametreAl("GuvenlikKodu") + "KullaniciID"].Value);
                Tbl.KayitTarih = DateTime.Now;
                Tbl.Baslik = form_konu.Text;
                Tbl.Detay = form_detay.Text;
                Tbl.Okundu = 0;
                db.AddTomesaj_kutu(Tbl);
                db.SaveChanges();
            }

            Yonetim.Olay.Islem("mesaj", "Yeni Kayıt", "");
            Class.Fonksiyonlar.JavaScript.MesajKutusuVeYonlendir("Mesaj başarıyla gönderilmiştir. Mesaj kutusuna yönlendiriliyorsunuz.", "MesajKutu.aspx");
        }
        catch (Exception ex)
        {
            Class.Fonksiyonlar.JavaScript.MesajKutusuVeYonlendir(Yonetim.Degiskenler.Hata + ex.Message, "MesajYeni.aspx");
        }
    }
}