using System;
using System.Linq;
using System.Web.UI.WebControls;
using MySQLDataModel;

public partial class Yonetim_Kullanici : System.Web.UI.Page
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

        kayitsayi.Text = Class.Fonksiyonlar.Genel.ParametreAl("YoneticiListeKayitSayi");
    }

    protected void Sayfalama()
    {
        sayfa.Items.Clear();

        int ToplamKayitSayisi = 0;
        using (BaglantiCumlesi db=new BaglantiCumlesi())
        {
            var SQL = db.talep.Count();
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

        using (BaglantiCumlesi db = new BaglantiCumlesi())
        {
            var SQL = (from a in db.talep
                       orderby a.KayitTarih descending
                       select new
                       {
                           a.ID,
                           Il = db.sehir_il.Where(b => b.ID == a.Il).Select(b => b.Baslik).FirstOrDefault(),
                           Ilce = db.sehir_ilce.Where(b => b.ID == a.Ilce).Select(b => b.Baslik).FirstOrDefault(),
                           Semt = db.sehir_semt.Where(b => b.ID == a.Semt).Select(b => b.Baslik).FirstOrDefault(),
                           Kategori = db.kategori.Where(b => b.ID == a.KatID).Select(b => b.Baslik).FirstOrDefault(),
                           a.Adi,
                           a.Telefon,
                           a.EPosta,
                           a.Mesaj,
                           a.IPAdres,
                           a.Durum,
                           a.IlanTur,
                           a.KayitTarih,
                           a.DegisTarih,
                           Guncelleyen = db.kullanici.Where(b => b.ID == a.GuncelleyenID).Select(b => b.Adi).FirstOrDefault()
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
            e.Row.Cells[11].Text = "<a href=\"MusteriTalepDuzenle.aspx?ID=" + e.Row.Cells[1].Text + "\"><img src=\"Image/komut-duzenle.png\" /></a>";
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
                    talep TblKullanici = db.talep.First(a => a.ID == ID);
                    db.DeleteObject(TblKullanici);
                    db.SaveChanges();
                }
                Yonetim.Olay.Islem("talep", "Silindi", ID.ToString());
            }
        }

        KayitYukle("");
    }

    protected void kayitlar_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        System.Threading.Thread.Sleep(100);

        int ID = int.Parse(e.CommandArgument.ToString());

        if (e.CommandName == "Sil")
        {
            using (BaglantiCumlesi db = new BaglantiCumlesi())
            {
                talep TblSil = db.talep.First(a => a.ID == ID);
                db.DeleteObject(TblSil);
                db.SaveChanges();
            }
            Yonetim.Olay.Islem("talep", "Silindi", ID.ToString());
        }

        KayitYukle("");
    }
}