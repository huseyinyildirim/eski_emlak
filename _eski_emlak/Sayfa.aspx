<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Sayfa.aspx.cs" Inherits="_Default" %>

<%@ Register TagPrefix="include" TagName="head" Src="~/Include/Head.ascx" %>
<%@ Register TagPrefix="include" TagName="alt" Src="~/Include/Alt.ascx" %>
<%@ Register TagPrefix="include" TagName="logo" Src="~/Include/Logo.ascx" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <include:head runat="server" ID="head" />
    <link href="/App/AdGallery/ad-gallery.css" rel="stylesheet" type="text/css" />
    <script src="/App/AdGallery/ad-gallery.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(function () {
            var galleries = $('.ad-gallery').adGallery();

            $('#toggle-slideshow').click(
      function () {
          galleries[0].slideshow.toggle();
          return false;
      }
    );
            $('#toggle-description').click(
      function () {
          if (!galleries[0].settings.description_wrapper) {
              galleries[0].settings.description_wrapper = $('#descriptions');
          } else {
              galleries[0].settings.description_wrapper = false;
          }
          return false;
      }
    );
        });
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <include:logo runat="server" ID="logo" />
    <div class="nerdesin">Ana Sayfa &raquo; Sayfalar &raquo; <asp:Literal runat="server" ID="nerdesin" /></div>
    <div class="clear h10"></div>
    <div class="icdiv beyazilan">
        <h1><asp:Literal runat="server" ID="sayfabaslik" /></h1>
        <div class="clear"></div>
        <em><asp:Literal runat="server" ID="sayfaozet" /></em>
        <div class="clear h10"></div>
        <asp:Literal runat="server" ID="sayfadetay" />
    </div>
    <div class="clear h10"></div>
    <div class="fulldiv">
        <div class="icdiv">
            <div class="sol ilanvurgu">
                <h1>Sizde evinizi, arsanızı, ofisinizi ve diğer gayrimenkullerinizi satmak veya kiraya vermek mi istiyorsunuz?</h1>
                <h3>Emlak sektöründeki itibarımız, referanslarımız ve sitemizin yüksek ziyaretçi potansiyeli ile gayrimenkulleriniz hemen değerlenecek. Bizimle irtibata geçiniz!</h3>
            </div>
            <div class="sag">
                
            </div>
        </div>
    </div>
    <div class="clear h10"></div>
    <div class="fulldiv">
        <div class="icdiv beyazilan">
            <h1>Vitrindekiler</h1>
            <ul id="mycarousel" class="jcarousel-skin-tango">
                <asp:Literal runat="server" ID="vitrinilan" />
            </ul>
        </div>
    </div>
    <div class="clear h10"></div>
    <include:alt runat="server" ID="alt" />
    </form>
</body>
</html>
