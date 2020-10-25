using System;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySQLDataModel;

public partial class Yonetim_Kullanici : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Class.Fonksiyonlar.Genel.OturumIslemleri.CookieKontrol();

        if (!Page.IsPostBack)
        {
            Kayit();
        }
    }

    protected void Kayit()
    {
        using (BaglantiCumlesi db = new BaglantiCumlesi())
        {
            var SQL = from a in db.kategori
                      orderby a.Baslik ascending
                      select new
                      {
                          a.ID,
                          a.Baslik
                      };

            form_katid.DataSource = SQL;
            form_katid.DataBind();
        }

        using (BaglantiCumlesi db = new BaglantiCumlesi())
        {
            var SQL = from a in db.ilan_sabit
                      orderby a.Sabit ascending
                      select new
                      {
                          a.ID,
                          a.Sabit
                      };

            form_sabitid.DataSource = SQL;
            form_sabitid.DataBind();
        }

        using (BaglantiCumlesi db = new BaglantiCumlesi())
        {
            var SQL = from a in db.ilan_degisken
                      where a.UstID == 0
                      orderby a.Baslik ascending
                      select new
                      {
                          a.ID,
                          a.Baslik
                      };

            if (SQL.AsEnumerable().Count() > 0)
            {
                form_tipdegisken.Items.Add(new ListItem("« Lütfen Seçiniz »", "0"));
                foreach (var item in SQL)
                {
                    form_tipdegisken.Items.Add(new ListItem(item.Baslik, item.ID.ToString()));
                }
            }
        }
    }

    protected void btn_kayitekle_Click(object sender, EventArgs e)
    {
        try
        {
            using (BaglantiCumlesi db = new BaglantiCumlesi())
            {
                ilan_sabit2 TblEkle = new ilan_sabit2();
                TblEkle.KatID = int.Parse(form_katid.SelectedValue);
                TblEkle.SabitID = int.Parse(form_sabitid.SelectedValue);
                TblEkle.Tip = form_tip.SelectedValue;

                if (form_tipdegisken.SelectedValue != "0")
                {
                    TblEkle.IlanDegiskenID = int.Parse(form_tipdegisken.SelectedValue);
                }
                
                TblEkle.Onay = int.Parse(form_onay.SelectedValue);
                TblEkle.EkleyenID = int.Parse(HttpContext.Current.Request.Cookies["" + Class.Fonksiyonlar.Genel.ParametreAl("GuvenlikKodu") + "KullaniciID"].Value);
                TblEkle.KayitTarih = DateTime.Now;
                db.AddToilan_sabit2(TblEkle);
                db.SaveChanges();
            }

            Yonetim.Olay.Islem("ilan_sabit", "Yeni Kayıt", "");
            Class.Fonksiyonlar.JavaScript.MesajKutusuVeYonlendir("İlan sabiti başarıyla eklenmiştir. İlan sabiti listesine yönlendiriliyorsunuz.", "IlanSabit.aspx");
        }
        catch (Exception ex)
        {
            Class.Fonksiyonlar.JavaScript.MesajKutusuVeYonlendir(Yonetim.Degiskenler.Hata + ex.Message, "IlanSabitEkle.aspx");
        }
    }

    protected void btn_sabit_adi_ekle_Click(object sender, EventArgs e)
    {
        if (form_sabitadi.Text != "")
        {
            using (BaglantiCumlesi db=new BaglantiCumlesi())
            {
                ilan_sabit Tbl = new ilan_sabit();
                Tbl.Sabit = form_sabitadi.Text;
                db.AddToilan_sabit(Tbl);
                db.SaveChanges();
            }
            Yonetim.Olay.Islem("ilan_sabit", "Yeni Kayıt", "");
            Class.Fonksiyonlar.JavaScript.MesajKutusuVeYonlendir("Sabit adı başarıyla eklenmiştir.", "IlanSabitEkle.aspx");
        }
        else
        {
            Class.Fonksiyonlar.JavaScript.MesajKutusuVeYonlendir("Lütfen sabit adı yazınız.","IlanSabitEkle.aspx");
        }
    }
}