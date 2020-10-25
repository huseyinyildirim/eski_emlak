using System;
using System.Linq;
using System.Web;
using System.Web.UI.WebControls;

namespace emlak.admin
{
    public partial class mesaj_oku : System.Web.UI.Page
    {
        static string KID = string.Empty;
        static string MID = string.Empty;

        protected void Page_Load(object sender, EventArgs e)
        {
            Class.Fonksiyonlar.Genel.OturumIslemleri.CookieKontrol();

            if (!IsPostBack)
            {
                MesajDetay();
                YuklenecekAlanlar();
                Sayfalama();
                KayitYukle("");
            }
        }

        protected void MesajDetay()
        {
            if (Request.QueryString["ID"] != null && Request.QueryString["ID"] != "")
            {
                int ID = int.Parse(Request.QueryString["ID"]);
                using (BaglantiCumlesi db = new BaglantiCumlesi())
                {
                    var SQL = (from a in db.tbl_mesaj_kutu
                               where a.id == ID
                               select new
                               {
                                   a.id,
                                   a.gonderen_id,
                                   a.baslik,
                                   a.detay,
                                   a.tarih_ek,
                                   Gonderen = db.tbl_admin.Where(b => b.id == a.gonderen_id).Select(b => b.ad).FirstOrDefault()
                               }).AsEnumerable();

                    if (SQL.Any())
                    {
                        foreach (var item in SQL)
                        {
                            mesajdetay.Text = "<strong>Gönderen Kullanıcı:</strong> " + item.Gonderen + "<br /><br />";
                            mesajdetay.Text += "<strong>Konu:</strong> " + item.baslik + "<br /><br /><br />";
                            mesajdetay.Text += item.detay + "<br /><br /><br />";
                            mesajdetay.Text += "<strong>Mesaj Tarihi:</strong> " + item.tarih_ek.ToLongDateString() + " " + item.tarih_ek.ToShortTimeString();
                            KID = item.gonderen_id.ToString();
                            MID = item.id.ToString();
                        }
                    }
                }

                using (BaglantiCumlesi db = new BaglantiCumlesi())
                {
                    tbl_mesaj_kutu Tbl = db.tbl_mesaj_kutu.First(p => p.id == ID);
                    Tbl.okundu = true;
                    db.SaveChanges();
                }
            }
            else
            {
                Response.Redirect("mesaj-kutu.aspx");
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
            sayfa.Items.Clear();

            int ToplamKayitSayisi = 0;
            int ID = int.Parse(HttpContext.Current.Request.Cookies["" + Class.Fonksiyonlar.Genel.Parametre().Select(b => b.guvenlik_kodu).FirstOrDefault() + "KullaniciID"].Value);
            using (BaglantiCumlesi db = new BaglantiCumlesi())
            {
                var SQL = db.tbl_mesaj_kutu.Where(a => a.alici_id == ID).Count();
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

            int ID = int.Parse(HttpContext.Current.Request.Cookies["" + Class.Fonksiyonlar.Genel.Parametre().Select(b => b.guvenlik_kodu).FirstOrDefault() + "KullaniciID"].Value);
            using (BaglantiCumlesi db = new BaglantiCumlesi())
            {
                var SQL = (from a in db.tbl_mesaj_kutu
                           where a.alici_id == ID
                           select new
                           {
                               a.id,
                               a.baslik,
                               a.tarih_ek,
                               a.okundu,
                               Gonderen = db.tbl_admin.Where(b => b.id == a.gonderen_id).Select(b => b.ad).FirstOrDefault()
                           }).OrderByDescending(k => k.tarih_ek).Skip(Limit).Take(int.Parse(kayitsayi.Text));

                Cache["icerik"] = SQL;

                kayitlar.DataSource = SQL;
                kayitlar.DataBind();
            }
        }

        protected void kayitlar_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                switch (e.Row.Cells[2].Text)
                {
                    case "1":
                        e.Row.Cells[2].Text = "<img src=\"img/mesaj.png\" />";
                        break;

                    case "0":
                        e.Row.Cells[2].Text = "<img src=\"img/mesajvar.png\" />";
                        break;
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
                        tbl_mesaj_kutu TblKullanici = db.tbl_mesaj_kutu.First(a => a.id == ID);
                        db.DeleteObject(TblKullanici);
                        db.SaveChanges();
                    }
                    Yonetim.Olay.Islem("mesaj", "Silindi", ID.ToString());
                }
            }

            KayitYukle("");
        }

        protected void yeniekle_Click(object sender, EventArgs e)
        {
            Response.Redirect("mesaj-yeni.aspx");
        }

        protected void kayitlar_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            System.Threading.Thread.Sleep(100);

            int ID = int.Parse(e.CommandArgument.ToString());

            if (e.CommandName == "Sil")
            {
                using (BaglantiCumlesi db = new BaglantiCumlesi())
                {
                    tbl_mesaj_kutu TblSil = db.tbl_mesaj_kutu.First(a => a.id == ID);
                    db.DeleteObject(TblSil);
                    db.SaveChanges();
                }
                Yonetim.Olay.Islem("mesaj", "Silindi", ID.ToString());
            }

            KayitYukle("");
        }
        protected void btn_cevap_Click(object sender, EventArgs e)
        {
            Response.Redirect("mesaj-yeni.aspx?KID=" + KID + "");
        }

        protected void btn_alinti_cevap_Click(object sender, EventArgs e)
        {
            Response.Redirect("mesaj-yeni.aspx?MID=" + MID + "&KID=" + KID + "");
        }
    }
}