using System;
using System.Collections;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Linq.Dynamic;
using System.Net;
using System.Net.Mail;
using System.Text;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using MySQLDataModel;

public class Class
{
    public class Degiskenler
    {
        public static class Diger
        {
            public static string vbCrLf = "\r\n";
            public static string TamAdres = String.Empty;
        }
    }

    public class Fonksiyonlar
    {
        public static void Sayac()
        {
            try
            {
                string Ip = HttpContext.Current.Request.ServerVariables["REMOTE_ADDR"].ToString();
                DateTime Tarih = DateTime.Today;
                string Agent = HttpContext.Current.Request.ServerVariables["HTTP_USER_AGENT"].ToString();
                string Browser = HttpContext.Current.Request.Browser.Browser.ToString().Trim() + " " + HttpContext.Current.Request.Browser.Version.ToString().Trim();
                string Dil = HttpContext.Current.Request.ServerVariables["HTTP_ACCEPT_LANGUAGE"].ToString().Trim();
                string Referans = HttpContext.Current.Request.ServerVariables["HTTP_REFERER"];
                string Sayfa = Class.Fonksiyonlar.Genel.MevcutSayfa().Replace("www.", "");

                string OS = "Unknown";

                if (Agent.Contains("Windows NT 3.1"))
                {
                    OS = "Windows NT 3.1";
                }

                if (Agent.Contains("Windows NT 3.5"))
                {
                    OS = "Windows NT 3.5";
                }

                if (Agent.Contains("Windows NT 3.51"))
                {
                    OS = "Windows NT 3.51";
                }

                if (Agent.Contains("Windows NT 4.0"))
                {
                    OS = "Windows NT 4.0";
                }

                if (Agent.Contains("Windows NT 5.0"))
                {
                    OS = "Windows 2000";
                }

                if (Agent.Contains("Windows NT 5.1"))
                {
                    OS = "Windows XP";
                }

                if (Agent.Contains("Windows NT 5.2"))
                {
                    OS = "Windows XP";
                }

                if (Agent.Contains("Windows NT 6.0"))
                {
                    OS = "Windows Vista";
                }

                if (Agent.Contains("Windows NT 6.1"))
                {
                    OS = "Windows 7";
                }

                if (Agent.Contains("TBA"))
                {
                    OS = "Windows 8";
                }

                if (Agent.Contains("Linux"))
                {
                    OS = "Linux";
                }

                if (Agent.Contains("iPhone"))
                {
                    OS = "iPhone";
                }

                if (Agent.Contains("iPad"))
                {
                    OS = "iPad";
                }

                using (BaglantiCumlesi db = new BaglantiCumlesi())
                {
                    var SQL = from a in db.sayac where a.Ip == Ip && a.Tarih == Tarih && a.Agent == Agent select new { a.ID };

                    if (SQL.AsEnumerable().Count() > 0)
                    {
                        if (HttpContext.Current.Request.ServerVariables["PATH_INFO"].ToString() == "/default.aspx")
                        {
                            using (BaglantiCumlesi Ekle = new BaglantiCumlesi())
                            {
                                sayac TblEkle = Ekle.sayac.First(a => a.Ip == Ip && a.Tarih == Tarih && a.Agent == Agent);
                                TblEkle.Cogul = TblEkle.Cogul + 1;
                                Ekle.SaveChanges();
                            }
                        }
                    }
                    else
                    {
                        DataSet IpDetay = new DataSet();
                        IpDetay.ReadXml("http://api.ipinfodb.com/v2/ip_query.php?key=1c9348841d076a0888d0a63590bc5e2486ac1c46b46993ab175fb17a6d598597&ip=" + Ip + "&timezone=true");

                        using (BaglantiCumlesi Ekle = new BaglantiCumlesi())
                        {
                            sayac TblEkle = new sayac();
                            TblEkle.Ip = Ip;
                            TblEkle.Cogul = 1;
                            TblEkle.Agent = Agent;
                            TblEkle.Tarayici = Browser;
                            TblEkle.IsletimSistemi = OS;
                            TblEkle.Dil = Dil;
                            TblEkle.Referans = Referans;
                            TblEkle.UlkeAd = IpDetay.Tables[0].Rows[0]["CountryName"].ToString();
                            TblEkle.UlkeKod = IpDetay.Tables[0].Rows[0]["CountryCode"].ToString();
                            TblEkle.Il = IpDetay.Tables[0].Rows[0]["RegionName"].ToString();
                            TblEkle.Ilce = IpDetay.Tables[0].Rows[0]["City"].ToString();
                            TblEkle.Enlem = IpDetay.Tables[0].Rows[0]["Latitude"].ToString();
                            TblEkle.Boylam = IpDetay.Tables[0].Rows[0]["Longitude"].ToString();
                            TblEkle.Tarih = Tarih;
                            if (HttpContext.Current.Request.Browser.Version.ToString().Trim() == "0.0")
                            {
                                TblEkle.Bot = 1;
                            }
                            else
                            {
                                TblEkle.Bot = 0;
                            }
                            Ekle.AddTosayac(TblEkle);
                            Ekle.SaveChanges();
                        }
                    }
                }

                using (BaglantiCumlesi db = new BaglantiCumlesi())
                {
                    var SQL = from a in db.sayac_sayfa where a.Ip == Ip && a.Tarih == Tarih && a.Sayfa == Sayfa select new { a.ID };

                    if (SQL.AsEnumerable().Count() == 0)
                    {
                        using (BaglantiCumlesi Ekle = new BaglantiCumlesi())
                        {
                            sayac_sayfa TblEkle = new sayac_sayfa();
                            TblEkle.Ip = Ip;
                            TblEkle.Sayfa = Sayfa;
                            TblEkle.Hit = 1;
                            TblEkle.Tarih = Tarih;
                            Ekle.AddTosayac_sayfa(TblEkle);
                            Ekle.SaveChanges();
                        }
                    }
                    else
                    {
                        using (BaglantiCumlesi Ekle = new BaglantiCumlesi())
                        {
                            sayac_sayfa TblEkle = Ekle.sayac_sayfa.First(a => a.Ip == Ip && a.Sayfa == Sayfa && a.Tarih == Tarih);
                            TblEkle.Hit = TblEkle.Hit + 1;
                            Ekle.SaveChanges();
                        }
                    }
                }
            }
            catch (Exception)
            {
            }
        }

        public static class Genel
        {
            public class OturumIslemleri
            {
                public static void CookieOlustur(string CookieAdi, string Deger)
                {
                    HttpContext.Current.Response.SetCookie(new HttpCookie(CookieAdi, Deger));
                }

                public static void CookieSil()
                {
                    HttpContext.Current.Session.Clear();
                    HttpContext.Current.Session.RemoveAll();
                    HttpContext.Current.Session.Abandon();

                    string[] cookies = HttpContext.Current.Request.Cookies.AllKeys;
                    HttpCookie tmpCookie;

                    foreach (string cookieKey in cookies)
                    {
                        tmpCookie = HttpContext.Current.Response.Cookies[cookieKey];
                        tmpCookie.Expires = DateTime.Now.AddDays(-2);
                        HttpContext.Current.Response.Cookies.Add(tmpCookie);
                    }

                    //HttpContext.Current.Response.Redirect("Giris.aspx");
                }

                public static void CookieKontrol()
                {
                    if (HttpContext.Current.Request.Cookies["" + Class.Fonksiyonlar.Genel.ParametreAl("GuvenlikKodu") + "Giris"] != null)
                    {
                        if (HttpContext.Current.Request.Cookies["" + Class.Fonksiyonlar.Genel.ParametreAl("GuvenlikKodu") + "Giris"].Value != "7777777")
                        {
                            HttpContext.Current.Response.Redirect("Giris.aspx");
                        }
                    }
                    else
                    {
                        HttpContext.Current.Response.Redirect("Giris.aspx");
                    }
                }
            }

            public static void ResimYukle(HttpPostedFile Dosya, int Genislik, int Yukseklik, string Yol)
            {
                Bitmap Resim = new Bitmap(Dosya.InputStream);
                if (Resim.Width > Genislik || Resim.Height > Yukseklik)
                {
                    Size ebatlar = new Size(Resim.Width, Resim.Height);
                    double oran = ((double)Resim.Width / (double)Resim.Height);
                    if (Resim.Width > Genislik && Genislik > 0)
                    {
                        ebatlar.Width = Genislik;
                        ebatlar.Height = (int)((double)Genislik / oran);
                    }
                    if (ebatlar.Height > Yukseklik && Yukseklik > 0)
                    {
                        ebatlar.Height = Yukseklik;
                        ebatlar.Width = (int)((double)Yukseklik * oran);
                    }
                    Resim = new Bitmap(Resim, ebatlar);
                }

                if (Dosya.ContentType == "image/jpeg" || Dosya.ContentType == "image/pjpeg")
                    Resim.Save(Yol, System.Drawing.Imaging.ImageFormat.Jpeg);
                else if (Dosya.ContentType == "image/gif")
                    Resim.Save(Yol, System.Drawing.Imaging.ImageFormat.Gif);
                else if (Dosya.ContentType == "image/png" || Dosya.ContentType == "image/x-png")
                    Resim.Save(Yol, System.Drawing.Imaging.ImageFormat.Png);
                Resim.Dispose();
            }

            public static string SeoLinkOlustur(string sayfa, string ID, string baslik)
            {
                return "/" + sayfa + "/" + ID + "/" + SeoLink(baslik) + ".aspx";
            }

            public static string SeoLink(string str)
            {
                try
                {
                    if (str != string.Empty)
                    {
                        str = str.ToLower();
                        str = str.Replace("ç", "c");
                        str = str.Replace("ı", "i");
                        str = str.Replace("ğ", "g");
                        str = str.Replace("ö", "o");
                        str = str.Replace("ş", "s");
                        str = str.Replace("ü", "u");
                        str = str.Replace("?", "");
                        str = str.Replace(" ", "-");
                        str = str.Replace("!", "");
                        str = str.Replace("'", "");
                        str = str.Replace("\"", "");
                        str = str.Replace("&", "-");
                        str = str.Replace(".", "-");
                        str = str.Replace(",", "");
                        str = str.Replace("’", "");
                        str = str.Replace("+", "-");
                        str = str.Replace("--", "-");
                        str = str.Replace("---", "-");
                        str = str.Replace("----", "-");
                    }
                }
                catch
                {

                }

                return str;
            }

            public static void MailGonder(string GonderenEmail, string GonderenAdSoyad, string AliciEmail, string AliciAdSoyad, string Konu, string MailIcerigi)
            {
                MailAddress gonderen = new MailAddress(GonderenEmail, GonderenAdSoyad);
                MailAddress alan = new MailAddress(AliciEmail, AliciAdSoyad);
                MailMessage eposta = new MailMessage(gonderen, alan);
                eposta.IsBodyHtml = true;
                eposta.Subject = Konu;
                eposta.Body = MailIcerigi;
                NetworkCredential auth = new NetworkCredential(Class.Fonksiyonlar.Genel.ParametreAl("SmtpEposta").ToString(), Class.Fonksiyonlar.Genel.ParametreAl("SmtpSifre").ToString());
                SmtpClient SMTP = new SmtpClient();
                SMTP.Host = Class.Fonksiyonlar.Genel.ParametreAl("Smtp").ToString();
                SMTP.UseDefaultCredentials = false;
                SMTP.Credentials = auth;
                SMTP.DeliveryMethod = SmtpDeliveryMethod.Network;
                SMTP.Send(eposta);
            }

            public static bool NumerikKontrol(string str)
            {
                int numeric;

                if (int.TryParse(str, out numeric))
                {
                    return true;
                }
                else
                {
                    return false;
                }
            }

            public static string SQLTemizle(string str)
            {
                try
                {
                    if (str != string.Empty)
                    {
                        str = HttpUtility.HtmlEncode(str);
                    }
                }
                catch
                {
                }

                return str;
            }

            public static string UrlvePathYaz()
            {
                string protocol = HttpContext.Current.Request.ServerVariables["SERVER_PORT_SECURE"];
                if (String.IsNullOrEmpty(protocol) | String.Equals(protocol, "0"))
                    protocol = "http://";
                else
                    protocol = "https://";

                string currentAddress = HttpContext.Current.Request.Url.ToString();
                Regex rx = new Regex(@"([^/]*)(localhost|\blocalhost:\d+\b)([^/]*)", RegexOptions.IgnoreCase);
                Match MatchObj = rx.Match(currentAddress);
                if (!(string.IsNullOrEmpty(MatchObj.Groups[0].Value)))
                {
                    Degiskenler.Diger.TamAdres = String.Concat(protocol,
                    MatchObj.Groups[0].Value,
                    HttpContext.Current.Request.ApplicationPath);
                }
                else
                {
                    Degiskenler.Diger.TamAdres = String.Concat(protocol,
                    HttpContext.Current.Request.ServerVariables["SERVER_NAME"],
                    HttpContext.Current.Request.ApplicationPath);
                }

                if (!Degiskenler.Diger.TamAdres.EndsWith("/"))
                    Degiskenler.Diger.TamAdres += "/";

                return Degiskenler.Diger.TamAdres;
            }

            public static string MevcutSayfa()
            {
                return (HttpContext.Current.Request.Url.AbsoluteUri);
            }

            public static string Sifrele(string str)
            {
                return FormsAuthentication.HashPasswordForStoringInConfigFile(FormsAuthentication.HashPasswordForStoringInConfigFile(FormsAuthentication.HashPasswordForStoringInConfigFile(str + "-" + Class.Fonksiyonlar.Genel.ParametreAl("GuvenlikKodu").ToString(), "sha1"), "md5"), "md5");
            }

            public static string ParametreAl(string str)
            {
                string x = string.Empty;

                using (BaglantiCumlesi db = new BaglantiCumlesi())
                {
                    var SQL = db.parametre.Where("ID == @0", 1).Select("" + str + "");

                    foreach (var item in SQL)
                    {
                        x = item.ToString();
                    }
                }

                return x;
            }
        }

        public class JavaScript
        {
            public static string GoogleMap(string Koordinat, string Zoom, string Div, int KoordinatTextbox)
            {
                StringBuilder sb = new StringBuilder();
                sb.Append("<meta name=\"viewport\" content=\"initial-scale=1.0, user-scalable=no\" />\n");
                sb.Append("<script type=\"text/javascript\" src=\"http://maps.googleapis.com/maps/api/js?key=" + Class.Fonksiyonlar.Genel.ParametreAl("GoogleMapApi") + "&sensor=true\"></script>\n");
                sb.Append("<script type=\"text/javascript\">\n");
                sb.Append("function initialize() {\n");
                //sb.Append("var image = 'Image/haritaisaret.png';\n");
                sb.Append("var myOptions = {\n");
                //if (Koordinat == null && Koordinat == "")
                //{
                    sb.Append("center: new google.maps.LatLng(39.368279, 35.657959),\n");
                //}
                //else
                //{
                    sb.Append("center: new google.maps.LatLng(" + Koordinat + "),\n");
                //}
                sb.Append("zoom: " + Zoom + ",\n");
                sb.Append("mapTypeId: google.maps.MapTypeId.HYBRID\n");
                sb.Append("};\n");
                sb.Append("var map = new google.maps.Map(document.getElementById(\"" + Div + "\"), myOptions);\n");
                if (KoordinatTextbox == 1)
                {
                    sb.Append("google.maps.event.addListener(map, 'click', function (event) {\n");
                    sb.Append("$(\"#koordinat\").val(event.latLng);\n");
                    sb.Append("});\n");
                }
                sb.Append("}\n");
                sb.Append("</script>\n");
                return sb.ToString();
            }

            public static void Yonlendir(string Url)
            {
                StringBuilder sb = new StringBuilder();
                sb.Append("<script type=\"text/javascript\">\n");
                sb.Append("//<![CDATA[\n");
                sb.Append("location.href=\"" + Url + "\"\n");
                sb.Append("//]]>\n");
                sb.Append("</script>\n");
                HttpContext.Current.Response.Write(sb.ToString());
            }

            public static void MesajKutusuVeYonlendir(string Mesaj, string Url)
            {
                StringBuilder sb = new StringBuilder();
                sb.Append("<script type=\"text/javascript\">\n");
                sb.Append("//<![CDATA[\n");
                sb.Append("alert(\"" + Mesaj.Replace("[ln]", @"\n") + "\");\n");
                sb.Append("location.href=\"" + Url + "\"\n");
                sb.Append("//]]>\n");
                sb.Append("</script>\n");
                HttpContext.Current.Response.Write(sb.ToString());
            }

            protected static Hashtable handlerPages = new Hashtable();
            public static void MesajKutusu(string Message)
            {
                if (!(handlerPages.Contains(HttpContext.Current.Handler)))
                {
                    Page currentPage = (Page)HttpContext.Current.Handler;
                    if (!((currentPage == null)))
                    {
                        Queue messageQueue = new Queue();
                        messageQueue.Enqueue(Message);
                        handlerPages.Add(HttpContext.Current.Handler, messageQueue);
                        currentPage.Unload += new EventHandler(CurrentPageUnload);
                    }
                }
                else
                {
                    Queue queue = ((Queue)(handlerPages[HttpContext.Current.Handler]));
                    queue.Enqueue(Message);
                }
            }

            private static void CurrentPageUnload(object sender, EventArgs e)
            {
                Queue queue = ((Queue)(handlerPages[HttpContext.Current.Handler]));
                if (queue != null)
                {
                    StringBuilder builder = new StringBuilder();
                    int iMsgCount = queue.Count;
                    builder.Append("<script language='javascript'>");
                    string sMsg;
                    while ((iMsgCount > 0))
                    {
                        iMsgCount = iMsgCount - 1;
                        sMsg = System.Convert.ToString(queue.Dequeue());
                        sMsg = sMsg.Replace("\"", "'");
                        builder.Append("alert( \"" + sMsg + "\" );");
                    }
                    builder.Append("</script>");
                    handlerPages.Remove(HttpContext.Current.Handler);
                    HttpContext.Current.Response.Write(builder.ToString());
                }
            }
        }
    }
}