using System;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySQLDataModel;

public partial class Yonetim_Kullanici : System.Web.UI.Page
{
    public static string Ozellikler = string.Empty;

    protected void Page_Load(object sender, EventArgs e)
    {
        Class.Fonksiyonlar.Genel.OturumIslemleri.CookieKontrol();

        Kayitlar();
    }

    protected void Kayitlar()
    {
        if (Request.QueryString["ID"] != null && Class.Fonksiyonlar.Genel.NumerikKontrol(Request.QueryString["ID"].ToString()))
        {
            int ID = int.Parse(Request.QueryString["ID"].ToString());
            int KatID = 0;


            using (BaglantiCumlesi db = new BaglantiCumlesi())
            {
                var SQL = from a in db.ilan
                          where a.ID == ID
                          select new
                          {
                              a.Kod,
                              a.Baslik,
                              a.KatID,
                              a.Ozellik,
                              Il = db.sehir_il.Where(b => b.ID == a.Il).Select(b => b.Baslik).FirstOrDefault(),
                              Ilce = db.sehir_ilce.Where(b => b.ID == a.Ilce).Select(b => b.Baslik).FirstOrDefault(),
                              Semt = db.sehir_semt.Where(b => b.ID == a.Semt).Select(b => b.Baslik).FirstOrDefault(),
                              a.KayitTarih,
                              a.DegisTarih,
                              Ekleyen = db.kullanici.Where(b => b.ID == a.EkleyenID).Select(b => b.Adi).FirstOrDefault(),
                              Guncelleyen = db.kullanici.Where(b => b.ID == a.GuncelleyenID).Select(b => b.Adi).FirstOrDefault()
                          };

                if (SQL.AsEnumerable().Count() > 0)
                {
                    foreach (var item in SQL)
                    {
                        ilan_bilgi.Text = "<strong>İlan Kodu:</strong> " + item.Kod + "<br />";
                        ilan_bilgi.Text += "<strong>İlan Başlık:</strong> " + item.Baslik + "<br />";
                        ilan_bilgi.Text += "<strong>Şehir:</strong> " + item.Semt + "/" + item.Ilce + "/" + item.Il + "";
                        KatID = int.Parse(item.KatID.ToString());
                        Ozellikler = item.Ozellik;
                        kayitbilgi_ekleyen.Text = item.Ekleyen;
                        kayitbilgi_gucelleyen.Text = item.Guncelleyen;
                        kayitbilgi_kayittarih.Text = item.KayitTarih.ToString();
                        kayitbilgi_guncellemetarih.Text = item.DegisTarih.ToString();
                    }
                }
            }

            using (BaglantiCumlesi db = new BaglantiCumlesi())
            {
                var SQL = from a in db.ilan_sabit2
                          where a.KatID == KatID
                          select new
                          {
                              a.Tip,
                              a.IlanDegiskenID,
                              a.SabitID,
                              Sabit = db.ilan_sabit.Where(b => b.ID == a.SabitID).Select(b => b.Sabit).FirstOrDefault()
                          };

                Kayit.DataSource = SQL;
                Kayit.DataBind();
            }

            using (BaglantiCumlesi db = new BaglantiCumlesi())
            {
                var SQL = from a in db.ilan_ozellik2
                          where a.KatID == KatID
                          select new
                          {
                              a.ID,
                              Kategori = db.ilan_ozellik.Where(b => b.ID == a.OzellikID).Select(b => b.Baslik).FirstOrDefault(),
                              a.OzellikID
                          };

                if (SQL.AsEnumerable().Count() > 0)
                {
                    kategoriilanbaslik.Text = "";
                    kategoriilandetay.Text = "";
                    foreach (var item in SQL)
                    {
                        kategoriilanbaslik.Text += "<li><a href=\"#tab" + item.ID + "\">" + item.Kategori + "</a></li>";
                        kategoriilandetay.Text += "<div class=\"tablar\" id=\"tab" + item.ID + "\">" + Ozellik(int.Parse(item.OzellikID.ToString())) + "</div>";
                    }
                }
            }
        }
        else
        {
            Response.Redirect("IlanEkle.aspx");
        }
    }

    protected string Ozellik(int ID)
    {
        string Deger = string.Empty;
        using (BaglantiCumlesi db = new BaglantiCumlesi())
        {
            var SQL = from a in db.ilan_ozellik where a.UstID == ID select new { a.ID, a.Baslik };
            if (SQL.AsEnumerable().Count() > 0)
            {
                Deger += "<table width=\"100%\"><tr>";
                int i = 0;
                foreach (var item in SQL)
                {
                    string strChecked = string.Empty;
                    if (Ozellikler != "" && Ozellikler != null)
                    {
                        string[] OzellikDizi = Ozellikler.Split(',');
                        for (int x = 0; x < OzellikDizi.Length; x++)
                        {
                            if (item.ID.ToString() == OzellikDizi[x].ToString())
                            {
                                strChecked += "checked=\"checked\" ";
                            }
                        }
                    }


                    Deger += "<td height=\"30px\"><input id=\"ozellik\" " + strChecked + "name=\"ozellik\" type=\"checkbox\" value=\"" + item.ID + "\" /> " + item.Baslik + "</td>";

                    if (i == 7)
                    {
                        Deger += "</tr><tr>";
                        i = 0;
                    }
                    else
                    {
                        i++;
                    }
                }
                Deger += "</tr></table>";
            }
        }
        return Deger;
    }

    protected void Kayit_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            int SabitID = int.Parse(e.Row.Cells[0].Text);
            using (BaglantiCumlesi db = new BaglantiCumlesi())
            {
                var SQL = from a in db.ilan_sabit where a.ID == SabitID select new { a.Sabit };
                if (SQL.AsEnumerable().Count() > 0)
                {
                    foreach (var item in SQL)
                    {
                        e.Row.Cells[0].Text = item.Sabit;
                    }
                }
            }

            string Deger = "";
            int IlanID = int.Parse(Request.QueryString["ID"].ToString());
            using (BaglantiCumlesi db = new BaglantiCumlesi())
            {
                var SQL = from a in db.ilan_detay where a.IlanID == IlanID && a.SabitID == SabitID select new { a.Deger };
                if (SQL.AsEnumerable().Count() > 0)
                {
                    foreach (var item in SQL)
                    {
                        Deger = item.Deger;
                    }
                }
            }

            switch (e.Row.Cells[1].Text)
            {
                case "textbox":
                    TextBox tb = new TextBox();
                    tb.ID = e.Row.Cells[0].Text;
                    tb.ClientIDMode = ClientIDMode.Static;
                    tb.Text = Deger;
                    tb.Width = Unit.Pixel(300);
                    e.Row.Cells[1].Controls.Add(tb);
                    break;

                case "dropdown":
                    DropDownList dd = new DropDownList();
                    dd.ID = e.Row.Cells[0].Text;
                    dd.ClientIDMode = ClientIDMode.Static;
                    dd.Items.Add(new ListItem("« Lütfen Seçiniz »", "0"));

                    if (e.Row.Cells[2].Text != "")
                    {
                        int ID = int.Parse(e.Row.Cells[2].Text);
                        using (BaglantiCumlesi db = new BaglantiCumlesi())
                        {
                            var SQL = from a in db.ilan_degisken where a.UstID == ID select new { a.Baslik, a.Değer };
                            if (SQL.AsEnumerable().Count() > 0)
                            {
                                foreach (var item in SQL)
                                {
                                    dd.Items.Add(new ListItem(item.Baslik, item.Değer));
                                }
                            }
                        }
                    }

                    dd.Text = Deger;
                    e.Row.Cells[1].Controls.Add(dd);
                    break;
            }
        }
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        Response.Redirect("IlanEkle.aspx?ID=" + Request.QueryString["ID"].ToString() + "");
    }

    protected void Button2_Click(object sender, EventArgs e)
    {
        try
        {
            int IlanID = int.Parse(Request.QueryString["ID"].ToString());
            using (BaglantiCumlesi db3 = new BaglantiCumlesi())
            {
                var SQL3 = from a in db3.ilan_detay where a.IlanID == IlanID select a;
                foreach (var item3 in SQL3)
                {
                    db3.ilan_detay.DeleteObject(item3);
                }
                db3.SaveChanges();
            }

            using (BaglantiCumlesi db = new BaglantiCumlesi())
            {
                ilan Tbl = db.ilan.First(a => a.ID == IlanID);
                if (Request.Form["ozellik"] != null && Request.Form["ozellik"].ToString() != "")
                {
                    Tbl.Ozellik = Request.Form["ozellik"].ToString();
                }
                else
                {
                    Tbl.Ozellik = "0";
                }
                db.SaveChanges();
            }

            foreach (var item in Request.Form)
            {
                using (BaglantiCumlesi db = new BaglantiCumlesi())
                {
                    var SQL = from a in db.ilan_sabit select new { a.Sabit, a.ID };
                    if (SQL.AsEnumerable().Count() > 0)
                    {
                        foreach (var item2 in SQL)
                        {
                            if (item.ToString().Contains(item2.Sabit))
                            {
                                if (Request.Form["" + item + ""].ToString() != "" && Request.Form["" + item + ""].ToString() != "0")
                                {
                                    Class.Fonksiyonlar.JavaScript.MesajKutusu("" + item2.ID.ToString() + ":" + Request.Form["" + item + ""].ToString() + "");

                                    using (BaglantiCumlesi db2 = new BaglantiCumlesi())
                                    {
                                        ilan_detay Tbl = new ilan_detay();
                                        Tbl.IlanID = IlanID;
                                        Tbl.SabitID = item2.ID;
                                        Tbl.Deger = Request.Form["" + item + ""].ToString();
                                        Tbl.KayitTarih = DateTime.Now;
                                        Tbl.EkleyenID = int.Parse(HttpContext.Current.Request.Cookies["" + Class.Fonksiyonlar.Genel.ParametreAl("GuvenlikKodu") + "KullaniciID"].Value);
                                        db2.AddToilan_detay(Tbl);
                                        db2.SaveChanges();
                                    }
                                }
                            }
                        }
                    }
                }
            }

            Response.Redirect("IlanEkle3.aspx?ID=" + Request.QueryString["ID"] + "");
        }
        catch (Exception ex)
        {
            Class.Fonksiyonlar.JavaScript.MesajKutusuVeYonlendir(Yonetim.Degiskenler.Hata + ex.Message, "IlanEkle.aspx");
        }
    }
}