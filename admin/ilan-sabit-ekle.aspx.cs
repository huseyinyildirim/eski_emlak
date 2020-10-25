using System;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace emlak.admin
{
    public partial class ilan_sabit_ekle : System.Web.UI.Page
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
                var SQL = (from a in db.tbl_kategori
                           orderby a.baslik ascending
                           select new
                           {
                               a.id,
                               a.baslik
                           });

                form_katid.DataSource = SQL;
                form_katid.DataBind();
            }

            using (BaglantiCumlesi db = new BaglantiCumlesi())
            {
                var SQL = (from a in db.tbl_ilan_sabit
                           orderby a.sabit ascending
                           select new
                           {
                               a.id,
                               a.sabit
                           });

                form_sabitid.DataSource = SQL;
                form_sabitid.DataBind();
            }

            using (BaglantiCumlesi db = new BaglantiCumlesi())
            {
                var SQL = (from a in db.tbl_ilan_degisken
                           where a.ust_id == 0
                           orderby a.baslik ascending
                           select new
                           {
                               a.id,
                               a.baslik
                           });

                if (SQL.Any())
                {
                    form_tipdegisken.Items.Add(new ListItem("« Lütfen Seçiniz »", "0"));
                    foreach (var item in SQL)
                    {
                        form_tipdegisken.Items.Add(new ListItem(item.baslik, item.id.ToString()));
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
                    tbl_ilan_sabit_2 TblEkle = new tbl_ilan_sabit_2();
                    TblEkle.kat_id = int.Parse(form_katid.SelectedValue);
                    TblEkle.sabit_id = int.Parse(form_sabitid.SelectedValue);
                    TblEkle.tip = form_tip.SelectedValue;

                    if (form_tipdegisken.SelectedValue != "0")
                    {
                        TblEkle.ilan_degisken_id = int.Parse(form_tipdegisken.SelectedValue);
                    }

                    TblEkle.onay = Class.Fonksiyonlar.Genel.StringToBool(form_onay.SelectedValue);
                    TblEkle.admin_id_ek = int.Parse(HttpContext.Current.Request.Cookies["" + Class.Fonksiyonlar.Genel.Parametre().Select(b => b.guvenlik_kodu).FirstOrDefault() + "KullaniciID"].Value);
                    db.AddTotbl_ilan_sabit_2(TblEkle);
                    db.SaveChanges();
                }

                Yonetim.Olay.Islem("ilan_sabit", "Yeni Kayıt", "");
                Class.Fonksiyonlar.JavaScript.MesajKutusuVeYonlendir("İlan sabiti başarıyla eklenmiştir. İlan sabiti listesine yönlendiriliyorsunuz.", "ilan-sabit.aspx");
            }
            catch (Exception ex)
            {
                Class.Fonksiyonlar.JavaScript.MesajKutusuVeYonlendir(Yonetim.Degiskenler.Hata + ex.Message, "iIlan-sabit-ekle.aspx");
            }
        }

        protected void btn_sabit_adi_ekle_Click(object sender, EventArgs e)
        {
            if (form_sabitadi.Text != "")
            {
                using (BaglantiCumlesi db = new BaglantiCumlesi())
                {
                    tbl_ilan_sabit Tbl = new tbl_ilan_sabit();
                    Tbl.sabit = form_sabitadi.Text;
                    db.AddTotbl_ilan_sabit(Tbl);
                    db.SaveChanges();
                }
                Yonetim.Olay.Islem("ilan_sabit", "Yeni Kayıt", "");
                Class.Fonksiyonlar.JavaScript.MesajKutusuVeYonlendir("Sabit adı başarıyla eklenmiştir.", "ilan-sabit-ekle.aspx");
            }
            else
            {
                Class.Fonksiyonlar.JavaScript.MesajKutusuVeYonlendir("Lütfen sabit adı yazınız.", "ilan-sabit-ekle.aspx");
            }
        }
    }
}