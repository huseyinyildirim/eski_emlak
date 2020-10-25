using System.IO;
using System.Linq;
using System.Text;
using System.Web;

namespace emlak
{
    public class Yonetim
    {
        public static class Degiskenler
        {
            public static string Hata = "Beklenmedik bir hata oluştu. Hata: ";
        }

        public class Olay
        {
            public static void Islem(string Tablo, string Islem, string ID)
            {
                using (BaglantiCumlesi db = new BaglantiCumlesi())
                {
                    tbl_olay_islem TblOlay = new tbl_olay_islem();
                    TblOlay.kullanici_id = int.Parse(HttpContext.Current.Request.Cookies["" + Class.Fonksiyonlar.Genel.Parametre().Select(b => b.guvenlik_kodu).FirstOrDefault() + "KullaniciID"].Value);
                    TblOlay.tablo = Tablo;
                    TblOlay.islem = Islem;
                    TblOlay.kayit_id = ID;
                    TblOlay.ip = HttpContext.Current.Request.ServerVariables["REMOTE_ADDR"];
                    db.AddTotbl_olay_islem(TblOlay);
                    db.SaveChanges();
                }
            }

            public static void GirisCikis(string Islem)
            {
                using (BaglantiCumlesi db = new BaglantiCumlesi())
                {
                    tbl_olay_giris_cikis TblOlay = new tbl_olay_giris_cikis();
                    TblOlay.kullanici_id = int.Parse(HttpContext.Current.Request.Cookies["" + Class.Fonksiyonlar.Genel.Parametre().Select(b => b.guvenlik_kodu).FirstOrDefault() + "KullaniciID"].Value);
                    TblOlay.islem = Islem;
                    TblOlay.ip = HttpContext.Current.Request.ServerVariables["REMOTE_ADDR"];
                    TblOlay.all_http = HttpContext.Current.Request.ServerVariables["ALL_HTTP"]; ;
                    TblOlay.all_raw = HttpContext.Current.Request.ServerVariables["ALL_RAW"]; ;
                    db.AddTotbl_olay_giris_cikis(TblOlay);
                    db.SaveChanges();
                }
            }

            public static void GirisHata(string Islem, string Kullanici)
            {
                using (BaglantiCumlesi db = new BaglantiCumlesi())
                {
                    tbl_olay_giris_hata TblOlay = new tbl_olay_giris_hata();
                    TblOlay.kullanici = Kullanici;
                    TblOlay.islem = Islem;
                    TblOlay.ip = HttpContext.Current.Request.ServerVariables["REMOTE_ADDR"];
                    db.AddTotbl_olay_giris_hata(TblOlay);
                    db.SaveChanges();
                }
            }
        }

        public class Islem
        {
            public static void IlanSil(int ID)
            {
                using (BaglantiCumlesi db = new BaglantiCumlesi())
                {
                    var SQL = (from a in db.tbl_ilan_resim
                               where a.ilan_id == ID
                               select new
                               {
                                   a.id,
                                   a.resim
                               }).AsEnumerable();

                    if (SQL.Any())
                    {
                        foreach (var item in SQL)
                        {
                            if (File.Exists(HttpContext.Current.Server.MapPath("~/upload/ilan/" + item.resim + "")))
                            {
                                File.Delete(HttpContext.Current.Server.MapPath("~/upload/ilan/" + item.resim + ""));
                                Yonetim.Olay.Islem("ilan_resim", "Silindi", item.id.ToString());
                            }
                        }
                    }
                }

                using (BaglantiCumlesi db = new BaglantiCumlesi())
                {
                    var SQL = (from a in db.tbl_ilan_resim where a.ilan_id == ID select a);
                    foreach (var item in SQL)
                    {
                        db.tbl_ilan_resim.DeleteObject(item);
                    }
                    db.SaveChanges();
                }

                using (BaglantiCumlesi db = new BaglantiCumlesi())
                {
                    var SQL = (from a in db.tbl_ilan_detay where a.ilan_id == ID select a);
                    foreach (var item in SQL)
                    {
                        db.tbl_ilan_detay.DeleteObject(item);
                    }
                    db.SaveChanges();
                }
                Yonetim.Olay.Islem("ilan_detay", "Silindi", ID.ToString());

                using (BaglantiCumlesi db = new BaglantiCumlesi())
                {
                    tbl_ilan TblSil = db.tbl_ilan.First(a => a.id == ID);
                    db.DeleteObject(TblSil);
                    db.SaveChanges();
                }
                Yonetim.Olay.Islem("ilan", "Silindi", ID.ToString());
            }
        }

        public class JavaScript
        {
            public static string GrafikPasta(string Veri)
            {
                StringBuilder sb = new StringBuilder();
                sb.Append("<script type=\"text/javascript\" src=\"https://www.google.com/jsapi\"></script>\n");
                sb.Append("<script type=\"text/javascript\">\n");
                sb.Append("google.load(\"visualization\", \"1\", { packages: [\"corechart\"] });\n");
                sb.Append("google.setOnLoadCallback(drawChart);\n");
                sb.Append("function drawChart() {\n");
                sb.Append("var data = new google.visualization.DataTable();\n");
                sb.Append("data.addColumn('string', '');\n");
                sb.Append("data.addColumn('number', '');\n");
                sb.Append("data.addRows([\n");

                string[] Data = Veri.Split('/');
                string virgul = ",";
                for (int i = 0; i < Data.Length; i++)
                {
                    if (Data.Length == i + 1)
                    {
                        virgul = "";
                    }
                    string[] Data1 = Data[i].ToString().Split('|');
                    sb.Append("['" + Data1[0].ToString() + "', " + Data1[1].ToString() + "]" + virgul + "\n");


                }

                sb.Append("]);\n");
                sb.Append("\n");
                sb.Append("var options = {\n");
                sb.Append("title: ''\n");
                sb.Append("};\n");
                sb.Append("var chart = new google.visualization.PieChart(document.getElementById('chart_div'));\n");
                sb.Append("chart.draw(data, options);\n");
                sb.Append("}\n");
                sb.Append("</script>\n");
                return sb.ToString();
            }

            public static string BarPasta(string Veri)
            {
                StringBuilder sb = new StringBuilder();
                sb.Append("<script type=\"text/javascript\" src=\"https://www.google.com/jsapi\"></script>\n");
                sb.Append("<script type=\"text/javascript\">\n");
                sb.Append("google.load(\"visualization\", \"1\", {packages:[\"corechart\"]});\n");
                sb.Append("google.setOnLoadCallback(drawChart);\n");
                sb.Append("function drawChart() {\n");
                sb.Append("var data = new google.visualization.DataTable();\n");
                sb.Append("data.addColumn('string', 'Günler');\n");
                sb.Append("data.addColumn('number', 'Tekil');\n");
                sb.Append("data.addColumn('number', 'Çoğul');\n");
                sb.Append("data.addRows([\n");

                string[] Data = Veri.Split('/');
                string virgul = ",";
                for (int i = 0; i < Data.Length; i++)
                {
                    if (Data.Length == i + 1)
                    {
                        virgul = "";
                    }
                    string[] Data1 = Data[i].ToString().Split('|');
                    sb.Append("['" + Data1[0].ToString() + "', " + Data1[1].ToString() + ", " + Data1[2].ToString() + "]" + virgul + "\n");
                }

                sb.Append("]);\n");
                sb.Append("var options = {\n");
                sb.Append("title: '',\n");
                sb.Append("hAxis: {title: 'Günler', titleTextStyle: {color: 'red'}}\n");
                sb.Append("};\n");
                sb.Append("var chart = new google.visualization.ColumnChart(document.getElementById('chart_div'));\n");
                sb.Append("chart.draw(data, options);\n");
                sb.Append("}\n");
                sb.Append("</script>\n");
                return sb.ToString();
            }
        }
    }
}