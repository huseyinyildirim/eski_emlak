using System;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace emlak.admin
{
    public partial class ilan_ekle_2 : System.Web.UI.Page
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
                    var SQL = (from a in db.tbl_ilan
                               where a.id == ID
                               select new
                               {
                                   a.kod,
                                   a.baslik,
                                   a.kat_id,
                                   a.ozellik,
                                   Il = db.tbl_sehir_il.Where(b => b.id == a.il_id).Select(b => b.baslik).FirstOrDefault(),
                                   Ilce = db.tbl_sehir_ilce.Where(b => b.id == a.ilce_id).Select(b => b.baslik).FirstOrDefault(),
                                   Semt = db.tbl_sehir_semt.Where(b => b.id == a.semt_id).Select(b => b.baslik).FirstOrDefault(),
                                   a.tarih_ek,
                                   a.tarih_gun,
                                   Ekleyen = db.tbl_admin.Where(b => b.id == a.admin_id_ek).Select(b => b.ad).FirstOrDefault(),
                                   Guncelleyen = db.tbl_admin.Where(b => b.id == a.admin_id_gun).Select(b => b.ad).FirstOrDefault()
                               }).AsEnumerable();

                    if (SQL.Any())
                    {
                        foreach (var item in SQL)
                        {
                            ilan_bilgi.Text = "<strong>İlan Kodu:</strong> " + item.kod + "<br />";
                            ilan_bilgi.Text += "<strong>İlan Başlık:</strong> " + item.baslik + "<br />";
                            ilan_bilgi.Text += "<strong>Şehir:</strong> " + item.Semt + "/" + item.Ilce + "/" + item.Il + "";
                            KatID = int.Parse(item.kat_id.ToString());
                            Ozellikler = item.ozellik;
                            kayitbilgi_ekleyen.Text = item.Ekleyen;
                            kayitbilgi_gucelleyen.Text = item.Guncelleyen;
                            kayitbilgi_kayittarih.Text = item.tarih_ek.ToString();
                            kayitbilgi_guncellemetarih.Text = item.tarih_gun.ToString();
                        }
                    }
                }

                using (BaglantiCumlesi db = new BaglantiCumlesi())
                {
                    var SQL = (from a in db.tbl_ilan_sabit_2
                               where a.kat_id == KatID
                               select new
                               {
                                   a.tip,
                                   a.ilan_degisken_id,
                                   a.sabit_id,
                                   Sabit = db.tbl_ilan_sabit.Where(b => b.id == a.sabit_id).Select(b => b.sabit).FirstOrDefault()
                               });

                    Kayit.DataSource = SQL;
                    Kayit.DataBind();
                }

                using (BaglantiCumlesi db = new BaglantiCumlesi())
                {
                    var SQL = (from a in db.tbl_ilan_ozellik_2
                               where a.kat_id == KatID
                               select new
                               {
                                   a.id,
                                   Kategori = db.tbl_ilan_ozellik.Where(b => b.id == a.ozellik_id).Select(b => b.baslik).FirstOrDefault(),
                                   a.ozellik_id
                               }).AsEnumerable();

                    if (SQL.Any())
                    {
                        kategoriilanbaslik.Text = "";
                        kategoriilandetay.Text = "";
                        foreach (var item in SQL)
                        {
                            kategoriilanbaslik.Text += "<li><a href=\"#tab" + item.id + "\">" + item.Kategori + "</a></li>";
                            kategoriilandetay.Text += "<div class=\"tablar\" id=\"tab" + item.id + "\">" + Ozellik(int.Parse(item.ozellik_id.ToString())) + "</div>";
                        }
                    }
                }
            }
            else
            {
                Response.Redirect("ilan-ekle.aspx");
            }
        }

        protected string Ozellik(int ID)
        {
            string Deger = string.Empty;
            using (BaglantiCumlesi db = new BaglantiCumlesi())
            {
                var SQL = (from a in db.tbl_ilan_ozellik
                           where a.ust_id == ID
                           select new
                           {
                               a.id,
                               a.baslik
                           }).AsEnumerable();

                if (SQL.Any())
                {
                    StringBuilder sb = new StringBuilder();
                    sb.Append("<table width=\"100%\"><tr>");
                    int i = 0;
                    foreach (var item in SQL)
                    {
                        string strChecked = string.Empty;
                        if (Ozellikler != "" && Ozellikler != null)
                        {
                            string[] OzellikDizi = Ozellikler.Split(',');
                            for (int x = 0; x < OzellikDizi.Length; x++)
                            {
                                if (item.id.ToString() == OzellikDizi[x].ToString())
                                {
                                    strChecked += "checked=\"checked\" ";
                                }
                            }
                        }


                        sb.Append("<td height=\"30px\"><input id=\"ozellik\" " + strChecked + "name=\"ozellik\" type=\"checkbox\" value=\"" + item.id + "\" /> " + item.baslik + "</td>");

                        if (i == 7)
                        {
                            sb.Append("</tr><tr>");
                            i = 0;
                        }
                        else
                        {
                            i++;
                        }
                    }
                    sb.Append("</tr></table>");
                    Deger = sb.ToString();
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
                    var SQL = from a in db.tbl_ilan_sabit where a.id == SabitID select new { a.sabit };

                    if (SQL.Any())
                    {
                        foreach (var item in SQL)
                        {
                            e.Row.Cells[0].Text = item.sabit;
                        }
                    }
                }

                string Deger = "";
                int IlanID = int.Parse(Request.QueryString["ID"].ToString());

                using (BaglantiCumlesi db = new BaglantiCumlesi())
                {
                    var SQL = (from a in db.tbl_ilan_detay
                               where a.ilan_id == IlanID && a.sabit_id == SabitID
                               select new
                               {
                                   a.deger
                               });

                    if (SQL.Any())
                    {
                        foreach (var item in SQL)
                        {
                            Deger = item.deger;
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
                                var SQL = (from a in db.tbl_ilan_degisken
                                           where a.ust_id == ID
                                           select new
                                           {
                                               a.baslik,
                                               a.deger
                                           });

                                if (SQL.Any())
                                {
                                    foreach (var item in SQL)
                                    {
                                        dd.Items.Add(new ListItem(item.baslik, item.deger));
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
            Response.Redirect("ilan-ekle.aspx?ID=" + Request.QueryString["ID"].ToString() + "");
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            try
            {
                int IlanID = int.Parse(Request.QueryString["ID"].ToString());
                using (BaglantiCumlesi db3 = new BaglantiCumlesi())
                {
                    var SQL3 = from a in db3.tbl_ilan_detay where a.ilan_id == IlanID select a;
                    foreach (var item3 in SQL3)
                    {
                        db3.tbl_ilan_detay.DeleteObject(item3);
                    }
                    db3.SaveChanges();
                }

                using (BaglantiCumlesi db = new BaglantiCumlesi())
                {
                    tbl_ilan Tbl = db.tbl_ilan.First(a => a.id == IlanID);
                    if (Request.Form["ozellik"] != null && Request.Form["ozellik"].ToString() != "")
                    {
                        Tbl.ozellik = Request.Form["ozellik"].ToString();
                    }
                    else
                    {
                        Tbl.ozellik = "0";
                    }
                    db.SaveChanges();
                }

                foreach (var item in Request.Form)
                {
                    using (BaglantiCumlesi db = new BaglantiCumlesi())
                    {
                        var SQL = (from a in db.tbl_ilan_sabit
                                   select new
                                   {
                                       a.sabit,
                                       a.id
                                   });

                        if (SQL.Any())
                        {
                            foreach (var item2 in SQL)
                            {
                                if (item.ToString().Contains(item2.sabit))
                                {
                                    if (Request.Form["" + item + ""].ToString() != "" && Request.Form["" + item + ""].ToString() != "0")
                                    {
                                        Class.Fonksiyonlar.JavaScript.MesajKutusu("" + item2.id.ToString() + ":" + Request.Form["" + item + ""].ToString() + "");

                                        using (BaglantiCumlesi db2 = new BaglantiCumlesi())
                                        {
                                            tbl_ilan_detay Tbl = new tbl_ilan_detay();
                                            Tbl.ilan_id = IlanID;
                                            Tbl.sabit_id = item2.id;
                                            Tbl.deger = Request.Form["" + item + ""].ToString();
                                            Tbl.admin_id_ek = int.Parse(HttpContext.Current.Request.Cookies["" + Class.Fonksiyonlar.Genel.Parametre().Select(b => b.guvenlik_kodu).FirstOrDefault() + "KullaniciID"].Value);
                                            db2.AddTotbl_ilan_detay(Tbl);
                                            db2.SaveChanges();
                                        }
                                    }
                                }
                            }
                        }
                    }
                }

                Response.Redirect("ilan-ekle-3.aspx?ID=" + Request.QueryString["ID"] + "");
            }
            catch (Exception ex)
            {
                Class.Fonksiyonlar.JavaScript.MesajKutusuVeYonlendir(Yonetim.Degiskenler.Hata + ex.Message, "ilan-ekle.aspx");
            }
        }
    }
}