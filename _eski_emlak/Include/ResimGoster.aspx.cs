using System;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.Drawing.Imaging;
using System.Web;

public partial class Include_ResimGoster : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        ResimGetir(Image.FromFile(@Request.ServerVariables["APPL_PHYSICAL_PATH"] + @"/" + Request.QueryString["R"].ToString() + ""), int.Parse(Request.QueryString["G"].ToString()), int.Parse(Request.QueryString["Y"].ToString()), Color.Black, false, 100, 72);
    }

    public static void ResimGetir(Image Resim, int Width, int Height, Color Renk, bool Kirp, Int64 Kalite, int Cozunurluk)
    {
        using (Resim)
        {
            #region Resim Header ve Formatı

            string Header = null;
            ImageFormat I = null;

            if (Resim.RawFormat.Equals(ImageFormat.Jpeg))
            {
                Header = "image/jpeg";
                I = ImageFormat.Jpeg;
            }
            else if (Resim.RawFormat.Equals(ImageFormat.Bmp))
            {
                Header = "image/bmp";
                I = ImageFormat.Bmp;
            }
            else if (Resim.RawFormat.Equals(ImageFormat.Emf))
            {
                Header = "image/emf";
                I = ImageFormat.Emf;
            }
            else if (Resim.RawFormat.Equals(ImageFormat.Exif))
            {
                Header = "image/exif";
                I = ImageFormat.Exif;
            }
            else if (Resim.RawFormat.Equals(ImageFormat.Gif))
            {
                Header = "image/gif";
                I = ImageFormat.Gif;
            }
            else if (Resim.RawFormat.Equals(ImageFormat.Icon))
            {
                Header = "image/icon";
                I = ImageFormat.Icon;
            }
            else if (Resim.RawFormat.Equals(ImageFormat.Png))
            {
                Header = "image/png";
                I = ImageFormat.Png;
            }
            else if (Resim.RawFormat.Equals(ImageFormat.Tiff))
            {
                Header = "image/tiff";
                I = ImageFormat.Tiff;
            }
            else if (Resim.RawFormat.Equals(ImageFormat.Wmf))
            {
                Header = "image/wmf";
                I = ImageFormat.Wmf;
            }
            #endregion

            using (EncoderParameters EP = new EncoderParameters(1))
            {
                EP.Param[0] = new EncoderParameter(Encoder.Quality, Kalite);

                using (Bitmap B2 = new Bitmap(ResimBoyutlandir(Resim, Width, Height, Renk, Kirp)))
                {
                    if (B2.HorizontalResolution != Cozunurluk || B2.VerticalResolution != Cozunurluk)
                    {
                        B2.SetResolution((float)Cozunurluk, (float)Cozunurluk);
                    }

                    B2.Save(HttpContext.Current.Response.OutputStream, EnkoderBul(I), EP);
                }
            }

            HttpContext.Current.Response.AddHeader("Content-Type", Header);
        }
    }

    public static ImageCodecInfo EnkoderBul(ImageFormat ResimFormati)
    {
        ImageCodecInfo[] ICI = ImageCodecInfo.GetImageDecoders();

        foreach (ImageCodecInfo i in ICI)
        {
            if (i.FormatID == ResimFormati.Guid)
            {
                return i;
            }
        }

        return null;
    }

    public static Image ResimBoyutlandir(Image Resim, int Width, int Height, Color Renk, bool Kirp)
    {
        #region Değişkenler
        int ResimW = Resim.Width;
        int ResimH = Resim.Height;
        int ResimX = 0;
        int ResimY = 0;
        int SonucX = 0;
        int SonucY = 0;

        float Yuzde = 0;
        float YuzdeW = 0;
        float YuzdeH = 0;

        YuzdeW = ((float)Width / (float)ResimW);
        YuzdeH = ((float)Height / (float)ResimH);

        if (YuzdeH < YuzdeW)
        {
            Yuzde = YuzdeH;
            SonucX = System.Convert.ToInt16((Width - (ResimW * Yuzde)) / 2);
        }
        else
        {
            Yuzde = YuzdeW;
            SonucY = System.Convert.ToInt16((Height - (ResimH * Yuzde)) / 2);
        }

        int SonucW = (int)(ResimW * Yuzde);
        int SonucH = (int)(ResimH * Yuzde);
        #endregion

        Bitmap B;

        if (Kirp)
        {
            B = new Bitmap(Width, Height, Resim.PixelFormat);
        }
        else
        {
            B = new Bitmap(SonucW, SonucH, Resim.PixelFormat);
        }

        //B.SetResolution(Resim.HorizontalResolution,Resim.VerticalResolution);

        using (Graphics G = Graphics.FromImage(B))
        {
            if (Kirp)
            {
                G.Clear(Renk);
            }

            #region Resim Kalitesi
            G.CompositingQuality = CompositingQuality.HighQuality;
            G.SmoothingMode = SmoothingMode.HighQuality;
            G.PixelOffsetMode = PixelOffsetMode.HighQuality;
            G.InterpolationMode = InterpolationMode.HighQualityBicubic;
            #endregion

            if (Kirp)
            {
                G.DrawImage(Resim, new Rectangle(SonucX, SonucY, SonucW, SonucH), new Rectangle(ResimX, ResimY, ResimW, ResimH), GraphicsUnit.Pixel);
            }
            else
            {
                G.DrawImage(Resim, 0, 0, SonucW, SonucH);
            }
        }

        return B;
    }
}