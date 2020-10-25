using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Dynamic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySQLDataModel;
using System.Data;

public partial class Yonetim_Kullanici : System.Web.UI.Page
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
                var SQL = from a in db.mesaj_kutu
                          where a.ID == ID
                          select new
                          {
                              a.ID,
                              a.GonderenID,
                              a.Baslik,
                              a.Detay,
                              a.KayitTarih,
                              Gonderen = db.kullanici.Where(b => b.ID == a.GonderenID).Select(b => b.Adi).FirstOrDefault()
                          };

                if (SQL.AsEnumerable().Count() > 0)
                {
                    foreach (var item in SQL)
                    {
                        mesajdetay.Text = "<strong>Gönderen Kullanıcı:</strong> " +item.Gonderen + "<br /><br />";
                        mesajdetay.Text += "<strong>Konu:</strong> " + item.Baslik + "<br /><br /><br />";
                        mesajdetay.Text += item.Detay + "<br /><br /><br />";
                        mesajdetay.Text += "<strong>Mesaj Tarihi:</strong> " + item.KayitTarih.Value.ToLongDateString() + " " + item.KayitTarih.Value.ToShortTimeString();
                        KID = item.GonderenID.ToString();
                        MID = item.ID.ToString();
                    }
                }
            }

            using (BaglantiCumlesi db=new BaglantiCumlesi())
            {
                mesaj_kutu Tbl = db.mesaj_kutu.First(p => p.ID == ID);
                Tbl.Okundu = 1;
                db.SaveChanges();
            }
        }
        else
        {
            Response.Redirect("MesajKutu.aspx");
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

        kayitsayi.Text = Class.Fonksiyonlar.Genel.ParametreAl("YoneticiListeKayitSayi");
    }

    protected void Sayfalama()
    {
        sayfa.Items.Clear();

        int ToplamKayitSayisi = 0;
        int ID = int.Parse(HttpContext.Current.Request.Cookies["" + Class.Fonksiyonlar.Genel.ParametreAl("GuvenlikKodu") + "KullaniciID"].Value);
        using (BaglantiCumlesi db = new BaglantiCumlesi())
        {
            var SQL = db.mesaj_kutu.Where(a => a.AliciID == ID).Count();
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

        int ID = int.Parse(HttpContext.Current.Request.Cookies["" + Class.Fonksiyonlar.Genel.ParametreAl("GuvenlikKodu") + "KullaniciID"].Value);
        using (BaglantiCumlesi db = new BaglantiCumlesi())
        {
            var SQL = (from a in db.mesaj_kutu
                       where a.AliciID == ID
                       select new
                       {
                           a.ID,
                           a.Baslik,
                           a.KayitTarih,
                           a.Okundu,
                           Gonderen = db.kullanici.Where(b => b.ID == a.GonderenID).Select(b => b.Adi).FirstOrDefault()
                       }).OrderByDescending(k => k.KayitTarih).Skip(Limit).Take(int.Parse(kayitsayi.Text));

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
                    e.Row.Cells[2].Text = "<img src=\"Image/mesaj.png\" />";
                    break;

                case "0":
                    e.Row.Cells[2].Text = "<img src=\"Image/mesajvar.png\" />";
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
                    mesaj_kutu TblKullanici = db.mesaj_kutu.First(a => a.ID == ID);
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
        Response.Redirect("MesajYeni.aspx");
    }

    protected void kayitlar_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        System.Threading.Thread.Sleep(100);

        int ID = int.Parse(e.CommandArgument.ToString());

        if (e.CommandName == "Sil")
        {
            using (BaglantiCumlesi db = new BaglantiCumlesi())
            {
                mesaj_kutu TblSil = db.mesaj_kutu.First(a => a.ID == ID);
                db.DeleteObject(TblSil);
                db.SaveChanges();
            }
            Yonetim.Olay.Islem("mesaj", "Silindi", ID.ToString());
        }

        KayitYukle("");
    }
    protected void btn_cevap_Click(object sender, EventArgs e)
    {
        Response.Redirect("MesajYeni.aspx?KID=" + KID + "");
    }

    protected void btn_alinti_cevap_Click(object sender, EventArgs e)
    {
        Response.Redirect("MesajYeni.aspx?MID=" + MID + "&KID=" + KID + "");
    }
}