using System;
using System.Linq;
using System.Web;
using System.Web.UI.WebControls;

namespace emlak.admin
{
    public partial class sayfa : System.Web.UI.Page
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
        }

        protected void Sayfalama()
        {
            sayfa2.Items.Clear();

            int ToplamKayitSayisi = 0;
            using (BaglantiCumlesi db = new BaglantiCumlesi())
            {
                var SQL = db.tbl_sayfa.Count();
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
                sayfa2.Items.Add(new ListItem(i.ToString(), i.ToString()));
            }
        }

        protected void KayitYukle(string SqlCumle)
        {
            System.Threading.Thread.Sleep(100);

            int Limit;
            if (sayfa2.Text == "1")
            {
                Limit = 0;
            }
            else if (sayfa2.SelectedValue == "")
            {
                Limit = 0;
            }
            else
            {
                Limit = (int.Parse(sayfa2.Text) - 1) * int.Parse(kayitsayi.Text);
            }

            using (BaglantiCumlesi db = new BaglantiCumlesi())
            {
                var SQL = (from a in db.tbl_sayfa
                           select new
                           {
                               a.id,
                               a.baslik,
                               a.onay,
                               Kategori = db.tbl_sayfa.Where(b => b.id == a.ust_id).Select(b => b.baslik).FirstOrDefault(),
                               a.tarih_ek,
                               a.tarih_gun,
                               Ekleyen = db.tbl_admin.Where(b => b.id == a.admin_id_ek).Select(b => b.ad).FirstOrDefault(),
                               Guncelleyen = db.tbl_admin.Where(b => b.id == a.admin_id_gun).Select(b => b.ad).FirstOrDefault()
                           }).OrderBy(k => k.Kategori).Skip(Limit).Take(int.Parse(kayitsayi.Text));

                Cache["icerik"] = SQL;

                kayitlar.DataSource = SQL;
                kayitlar.DataBind();
            }
        }

        protected void kayitlar_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                switch (e.Row.Cells[4].Text)
                {
                    case "1":
                        e.Row.Cells[4].Text = "<img src=\"img/komut-aktif.png\" />";
                        break;

                    case "0":
                        e.Row.Cells[4].Text = "<img src=\"img/komut-pasif.png\" />";
                        break;
                }

                e.Row.Cells[6].Text = "<a href=\"sayfa-duzenle.aspx?ID=" + e.Row.Cells[1].Text + "\"><img src=\"img/komut-duzenle.png\" /></a>";

                int ID = int.Parse(e.Row.Cells[1].Text);
                using (BaglantiCumlesi db = new BaglantiCumlesi())
                {
                    var SQL = (from a in db.tbl_sayfa where a.ust_id == 0 && a.id == ID select a);

                    if (SQL.Any())
                    {
                        e.Row.Cells[2].Text = "";
                    }
                }
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
                        tbl_sayfa TblKullanici = db.tbl_sayfa.First(a => a.id == ID);
                        db.DeleteObject(TblKullanici);
                        db.SaveChanges();
                    }
                    Yonetim.Olay.Islem("sayfa", "Silindi", ID.ToString());
                }
            }

            KayitYukle("");
        }

        protected void yeniekle_Click(object sender, EventArgs e)
        {
            Response.Redirect("sayfa-ekle.aspx");
        }

        protected void kayitlar_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            System.Threading.Thread.Sleep(100);

            int ID = int.Parse(e.CommandArgument.ToString());

            if (e.CommandName == "Onay")
            {
                using (BaglantiCumlesi db = new BaglantiCumlesi())
                {
                    var SQL = (from a in db.tbl_sayfa
                               where a.id == ID
                               select new
                               {
                                   a.onay
                               });

                    if (SQL.Any())
                    {
                        foreach (var item in SQL)
                        {
                            switch (item.onay)
                            {
                                case true:
                                    using (BaglantiCumlesi dbOnay = new BaglantiCumlesi())
                                    {
                                        tbl_sayfa TblOnay = dbOnay.tbl_sayfa.First(a => a.id == ID);
                                        TblOnay.onay = false;
                                        TblOnay.admin_id_gun = int.Parse(HttpContext.Current.Request.Cookies["" + Class.Fonksiyonlar.Genel.Parametre().Select(b => b.guvenlik_kodu).FirstOrDefault() + "KullaniciID"].Value);
                                        dbOnay.SaveChanges();
                                    }
                                    break;
                                case false:
                                    using (BaglantiCumlesi dbOnay = new BaglantiCumlesi())
                                    {
                                        tbl_sayfa TblOnay = dbOnay.tbl_sayfa.First(a => a.id == ID);
                                        TblOnay.onay = true;
                                        TblOnay.admin_id_gun = int.Parse(HttpContext.Current.Request.Cookies["" + Class.Fonksiyonlar.Genel.Parametre().Select(b => b.guvenlik_kodu).FirstOrDefault() + "KullaniciID"].Value);
                                        dbOnay.SaveChanges();
                                    }
                                    break;
                            }
                            Yonetim.Olay.Islem("sayfa", "Güncellendi", ID.ToString());
                        }
                    }
                }
            }

            if (e.CommandName == "Sil")
            {
                using (BaglantiCumlesi db = new BaglantiCumlesi())
                {
                    tbl_sayfa TblSil = db.tbl_sayfa.First(a => a.id == ID);
                    db.DeleteObject(TblSil);
                    db.SaveChanges();
                }
                Yonetim.Olay.Islem("sayfa", "Silindi", ID.ToString());
            }

            KayitYukle("");
        }
    }
}