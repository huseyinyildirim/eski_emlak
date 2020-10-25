using System;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace emlak.admin
{
    public partial class sayfa_duzenle : System.Web.UI.Page
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
                var SQL = from a in db.tbl_sayfa
                          where a.ust_id == 0
                          orderby a.baslik ascending
                          select new
                          {
                              a.id,
                              a.baslik
                          };

                if (SQL.Any())
                {
                    form_katid.Items.Add(new ListItem("Ana Kategori", "0"));

                    foreach (var item in SQL)
                    {
                        form_katid.Items.Add(new ListItem(item.baslik, item.id.ToString()));
                    }
                }
            }

            if (Request.QueryString["ID"] != null && Class.Fonksiyonlar.Genel.NumerikKontrol(Request.QueryString["ID"].ToString()))
            {
                int ID = int.Parse(Request.QueryString["ID"]);

                using (BaglantiCumlesi db = new BaglantiCumlesi())
                {
                    var SQL = (from a in db.tbl_sayfa
                               where a.id == ID
                               select new
                               {
                                   a.id,
                                   a.baslik,
                                   a.ozet,
                                   a.detay,
                                   a.alt_menu,
                                   a.ana_menu,
                                   a.ust_id,
                                   a.sira,
                                   a.onay,
                                   a.tarih_ek,
                                   a.tarih_gun,
                                   Ekleyen = db.tbl_admin.Where(b => b.id == a.admin_id_ek).Select(b => b.ad).FirstOrDefault(),
                                   Guncelleyen = db.tbl_admin.Where(b => b.id == a.admin_id_gun).Select(b => b.ad).FirstOrDefault()
                               }).AsEnumerable();

                    if (SQL.Any())
                    {
                        foreach (var item in SQL)
                        {
                            form_katid.Text = item.ust_id.ToString();
                            form_onay.Text = item.onay.ToString();
                            form_baslik.Text = item.baslik;
                            form_sira.Text = item.sira.ToString();
                            form_altmenu.Text = item.alt_menu.ToString();
                            form_anamenu.Text = item.ana_menu.ToString();
                            form_ozet.Text = item.ozet;
                            form_detay.Text = item.detay;

                            kayitbilgi_ekleyen.Text = item.Ekleyen;
                            kayitbilgi_kayittarih.Text = item.tarih_ek.ToString();
                            kayitbilgi_gucelleyen.Text = item.Guncelleyen;
                            kayitbilgi_guncellemetarih.Text = item.tarih_gun.ToString();
                        }
                    }
                }
            }
        }

        protected void btn_kayitekle_Click(object sender, EventArgs e)
        {
            if (Request.QueryString["ID"] != null && Class.Fonksiyonlar.Genel.NumerikKontrol(Request.QueryString["ID"].ToString()))
            {
                int ID = int.Parse(Request.QueryString["ID"]);

                try
                {
                    using (BaglantiCumlesi db = new BaglantiCumlesi())
                    {
                        tbl_sayfa TblEkle = db.tbl_sayfa.First(a => a.id == ID);
                        TblEkle.ust_id = int.Parse(form_katid.SelectedValue);
                        TblEkle.baslik = Class.Fonksiyonlar.Genel.SQLTemizle(form_baslik.Text);
                        TblEkle.ozet = form_ozet.Text;
                        TblEkle.detay = form_detay.Text;
                        TblEkle.ana_menu = Class.Fonksiyonlar.Genel.StringToBool(form_anamenu.Text);
                        TblEkle.alt_menu = Class.Fonksiyonlar.Genel.StringToBool(form_altmenu.Text);
                        TblEkle.sira = int.Parse(form_sira.Text);
                        TblEkle.onay = Class.Fonksiyonlar.Genel.StringToBool(form_onay.SelectedValue);
                        TblEkle.admin_id_gun = int.Parse(HttpContext.Current.Request.Cookies["" + Class.Fonksiyonlar.Genel.Parametre().Select(b => b.guvenlik_kodu).FirstOrDefault() + "KullaniciID"].Value);
                        db.SaveChanges();
                    }

                    Yonetim.Olay.Islem("sayfa", "Güncellendi", ID.ToString());
                    Class.Fonksiyonlar.JavaScript.MesajKutusuVeYonlendir("Sayfa başarıyla düzenlenmiştir.", "sayfa-duzenle.aspx?ID=" + ID + "");
                }
                catch (Exception ex)
                {
                    Class.Fonksiyonlar.JavaScript.MesajKutusuVeYonlendir(Yonetim.Degiskenler.Hata + ex.Message, "sayfa.aspx");
                }
            }
        }
    }
}