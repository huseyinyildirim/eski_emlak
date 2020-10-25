using System;
using System.Linq;
using System.Web;
using System.Web.UI.WebControls;

namespace emlak.admin
{
    public partial class ilan_ozellik : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Class.Fonksiyonlar.Genel.OturumIslemleri.CookieKontrol();

            if (!IsPostBack)
            {
                YuklenecekAlanlar();
                Sayfalama();
                KayitYukle("");
            }
        }

        protected void YuklenecekAlanlar()
        {
            kayitsayi.Items.Clear();
            kayitsayi.Items.Add(new ListItem("10", "10"));
            kayitsayi.Items.Add(new ListItem("20", "20"));
            kayitsayi.Items.Add(new ListItem("30", "30"));
            kayitsayi.Items.Add(new ListItem("50", "50"));
            kayitsayi.Items.Add(new ListItem("75", "75"));
            kayitsayi.Items.Add(new ListItem("100", "100"));
            kayitsayi.Items.Add(new ListItem("125", "125"));
            kayitsayi.Items.Add(new ListItem("150", "150"));

            kayitsayi.Text = Class.Fonksiyonlar.Genel.Parametre().Select(b => b.yonetici_liste_kayit_sayi).FirstOrDefault();

            using (BaglantiCumlesi db = new BaglantiCumlesi())
            {
                var SQL = from a in db.tbl_ilan_ozellik
                          where a.ust_id == 0
                          orderby a.baslik ascending
                          select new
                          {
                              a.id,
                              a.baslik
                          };

                kategori.DataSource = SQL;
                kategori.DataBind();
            }
        }

        protected void Sayfalama()
        {
            sayfa.Items.Clear();

            int ToplamKayitSayisi = 0;
            using (BaglantiCumlesi db = new BaglantiCumlesi())
            {
                var SQL = db.tbl_ilan_ozellik.Where(b => b.ust_id == 0).Count();
                ToplamKayitSayisi = SQL;
            }

            int ToplamSayfaSayisi = 0;

            if ((ToplamKayitSayisi % int.Parse(kayitsayi.Text)) == 0)
            {
                ToplamSayfaSayisi = ToplamKayitSayisi / int.Parse(kayitsayi.Text);
            }
            else
            {
                ToplamSayfaSayisi = (ToplamKayitSayisi / int.Parse(kayitsayi.Text)) + 1;
            }

            for (int i = 1; i <= ToplamSayfaSayisi; i++)
            {
                sayfa.Items.Add(new ListItem(i.ToString(), i.ToString()));
            }
        }

        protected void KayitYukle(string SqlCumle)
        {
            System.Threading.Thread.Sleep(100);

            int Limit;
            if (sayfa.Text == "1")
            {
                Limit = 0;
            }
            else if (sayfa.SelectedValue == "")
            {
                Limit = 0;
            }
            else
            {
                Limit = (int.Parse(sayfa.Text) - 1) * int.Parse(kayitsayi.Text);
            }

            int UstID = int.Parse(kategori.SelectedValue);

            using (BaglantiCumlesi db = new BaglantiCumlesi())
            {
                var SQL = (from a in db.tbl_ilan_ozellik
                           where a.ust_id == UstID
                           orderby a.baslik ascending
                           select new
                           {
                               a.id,
                               a.baslik,
                               a.onay,
                               a.tarih_ek,
                               a.tarih_gun,
                               Ekleyen = db.tbl_admin.Where(b => b.id == a.admin_id_ek).Select(b => b.ad).FirstOrDefault(),
                               Guncelleyen = db.tbl_admin.Where(b => b.id == a.admin_id_gun).Select(b => b.ad).FirstOrDefault()
                           }).Skip(Limit).Take(int.Parse(kayitsayi.Text));

                Cache["icerik"] = SQL;

                kayitlar.DataSource = SQL;
                kayitlar.DataBind();
            }
        }

        protected void kayitlar_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                switch (e.Row.Cells[3].Text)
                {
                    case "1":
                        e.Row.Cells[3].Text = "<img src=\"img/komut-aktif.png\" />";
                        break;

                    case "0":
                        e.Row.Cells[3].Text = "<img src=\"img/komut-pasif.png\" />";
                        break;
                }

                e.Row.Cells[5].Text = "<a href=\"ilan-ozellik-duzenle.aspx?ID=" + e.Row.Cells[1].Text + "\"><img src=\"img/komut-duzenle.png\" /></a>";
            }
        }

        protected void kayitsayisec(object sender, EventArgs e)
        {
            System.Threading.Thread.Sleep(100);
            Sayfalama();
            KayitYukle("");
        }

        protected void sayfasec(object sender, EventArgs e)
        {
            System.Threading.Thread.Sleep(100);
            KayitYukle("");
        }

        protected void secilenlerisil_Click(object sender, EventArgs e)
        {
            System.Threading.Thread.Sleep(100);

            foreach (GridViewRow satir in kayitlar.Rows)
            {
                CheckBox kutu = (CheckBox)satir.FindControl("secim");
                if (kutu.Checked)
                {
                    int ID = int.Parse(kayitlar.DataKeys[satir.RowIndex].Value.ToString());

                    using (BaglantiCumlesi db = new BaglantiCumlesi())
                    {
                        tbl_ilan_ozellik TblKullanici = db.tbl_ilan_ozellik.First(a => a.id == ID);
                        db.DeleteObject(TblKullanici);
                        db.SaveChanges();
                    }
                    Yonetim.Olay.Islem("ilan_ozellik", "Silindi", ID.ToString());
                }
            }

            KayitYukle("");
        }

        protected void yeniekle_Click(object sender, EventArgs e)
        {
            Response.Redirect("ilan-ozellik-ekle.aspx");
        }

        protected void kayitlar_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            System.Threading.Thread.Sleep(100);

            int ID = int.Parse(e.CommandArgument.ToString());

            if (e.CommandName == "Onay")
            {
                using (BaglantiCumlesi db = new BaglantiCumlesi())
                {
                    var SQL = from a in db.tbl_ilan_ozellik where a.id == ID select new { a.onay };

                    if (SQL.Any())
                    {
                        foreach (var item in SQL)
                        {
                            switch (item.onay)
                            {
                                case true:
                                    using (BaglantiCumlesi dbOnay = new BaglantiCumlesi())
                                    {
                                        tbl_ilan_ozellik TblOnay = dbOnay.tbl_ilan_ozellik.First(a => a.id == ID);
                                        TblOnay.onay = false;
                                        TblOnay.admin_id_gun = int.Parse(HttpContext.Current.Request.Cookies["" + Class.Fonksiyonlar.Genel.Parametre().Select(b => b.guvenlik_kodu).FirstOrDefault() + "KullaniciID"].Value);
                                        dbOnay.SaveChanges();
                                    }
                                    break;

                                case false:
                                    using (BaglantiCumlesi dbOnay = new BaglantiCumlesi())
                                    {
                                        tbl_ilan_ozellik TblOnay = dbOnay.tbl_ilan_ozellik.First(a => a.id == ID);
                                        TblOnay.onay = true;
                                        TblOnay.admin_id_gun = int.Parse(HttpContext.Current.Request.Cookies["" + Class.Fonksiyonlar.Genel.Parametre().Select(b => b.guvenlik_kodu).FirstOrDefault() + "KullaniciID"].Value);
                                        dbOnay.SaveChanges();
                                    }
                                    break;
                            }
                            Yonetim.Olay.Islem("ilan_ozellik", "Güncellendi", ID.ToString());
                        }
                    }
                }
            }

            if (e.CommandName == "Sil")
            {
                using (BaglantiCumlesi db = new BaglantiCumlesi())
                {
                    tbl_ilan_ozellik TblSil = db.tbl_ilan_ozellik.First(a => a.id == ID);
                    db.DeleteObject(TblSil);
                    db.SaveChanges();
                }
                Yonetim.Olay.Islem("ilan_ozellik", "Silindi", ID.ToString());
            }

            KayitYukle("");
        }

        protected void kategorisec(object sender, EventArgs e)
        {
            System.Threading.Thread.Sleep(100);
            KayitYukle("");
        }

        protected void btn_sabit_adi_ekle_Click(object sender, EventArgs e)
        {
            try
            {
                using (BaglantiCumlesi db = new BaglantiCumlesi())
                {
                    tbl_ilan_ozellik TblEkle = new tbl_ilan_ozellik();
                    TblEkle.ust_id = 0;
                    TblEkle.baslik = form_degeradi.Text;
                    TblEkle.onay = true;
                    TblEkle.admin_id_ek = int.Parse(HttpContext.Current.Request.Cookies["" + Class.Fonksiyonlar.Genel.Parametre().Select(b => b.guvenlik_kodu).FirstOrDefault() + "KullaniciID"].Value);
                    db.AddTotbl_ilan_ozellik(TblEkle);
                    db.SaveChanges();
                }

                Yonetim.Olay.Islem("ilan_ozellik", "Yeni Kayıt", "");
                Class.Fonksiyonlar.JavaScript.MesajKutusuVeYonlendir("İlan özellik kategorisi başarıyla eklenmiştir. İlan özellikleri listesine yönlendiriliyorsunuz.", "ilan-ozellik.aspx");
            }
            catch (Exception ex)
            {
                Class.Fonksiyonlar.JavaScript.MesajKutusuVeYonlendir(Yonetim.Degiskenler.Hata + ex.Message, "ilan-ozellik.aspx");
            }
        }
    }
}