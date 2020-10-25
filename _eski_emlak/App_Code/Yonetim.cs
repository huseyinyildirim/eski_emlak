using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Dynamic;
using System.Web;
using System.IO;
using MySQLDataModel;
using System.Text;
using MySQLDataModel;

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
                olay_islem TblOlay = new olay_islem();
                TblOlay.KullaniciID = int.Parse(HttpContext.Current.Request.Cookies["" + Class.Fonksiyonlar.Genel.ParametreAl("GuvenlikKodu") + "KullaniciID"].Value);
                TblOlay.Tablo = Tablo;
                TblOlay.Islem = Islem;
                TblOlay.KayıtID = ID;
                TblOlay.Ip = HttpContext.Current.Request.ServerVariables["REMOTE_ADDR"];
                TblOlay.KayitTarih = DateTime.Now;
                db.AddToolay_islem(TblOlay);
                db.SaveChanges();
            }
        }

        public static void GirisCikis(string Islem)
        {
            using (BaglantiCumlesi db = new BaglantiCumlesi())
            {
                olay_giriscikis TblOlay = new olay_giriscikis();
                TblOlay.KullaniciID = int.Parse(HttpContext.Current.Request.Cookies["" + Class.Fonksiyonlar.Genel.ParametreAl("GuvenlikKodu") + "KullaniciID"].Value);
                TblOlay.Islem = Islem;
                TblOlay.Ip = HttpContext.Current.Request.ServerVariables["REMOTE_ADDR"];
                TblOlay.All_http = HttpContext.Current.Request.ServerVariables["ALL_HTTP"]; ;
                TblOlay.All_raw = HttpContext.Current.Request.ServerVariables["ALL_RAW"]; ;
                TblOlay.KayitTarih = DateTime.Now;
                db.AddToolay_giriscikis(TblOlay);
                db.SaveChanges();
            }
        }

        public static void GirisHata(string Islem, string Kullanici)
        {
            using (BaglantiCumlesi db = new BaglantiCumlesi())
            {
                olay_girishata TblOlay = new olay_girishata();
                TblOlay.Kullanici = Kullanici;
                TblOlay.Islem = Islem;
                TblOlay.Ip = HttpContext.Current.Request.ServerVariables["REMOTE_ADDR"];
                TblOlay.KayitTarih = DateTime.Now;
                db.AddToolay_girishata(TblOlay);
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
                var SQL = from a in db.ilan_resim where a.IlanID == ID select new { a.ID, a.Resim };
                if (SQL.AsEnumerable().Count() > 0)
                {
                    foreach (var item in SQL)
                    {
                        if (File.Exists(HttpContext.Current.Server.MapPath("~/Upload/Ilan/" + item.Resim + "")))
                        {
                            File.Delete(HttpContext.Current.Server.MapPath("~/Upload/Ilan/" + item.Resim + ""));
                            Yonetim.Olay.Islem("ilan_resim", "Silindi", item.ID.ToString());
                        }
                    }
                }
            }

            using (BaglantiCumlesi db = new BaglantiCumlesi())
            {
                var SQL = from a in db.ilan_resim where a.IlanID == ID select a;
                foreach (var item in SQL)
                {
                    db.ilan_resim.DeleteObject(item);
                }
                db.SaveChanges();
            }

            using (BaglantiCumlesi db = new BaglantiCumlesi())
            {
                var SQL = from a in db.ilan_detay where a.IlanID == ID select a;
                foreach (var item in SQL)
                {
                    db.ilan_detay.DeleteObject(item);
                }
                db.SaveChanges();
            }
            Yonetim.Olay.Islem("ilan_detay", "Silindi", ID.ToString());

            using (BaglantiCumlesi db = new BaglantiCumlesi())
            {
                ilan TblSil = db.ilan.First(a => a.ID == ID);
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