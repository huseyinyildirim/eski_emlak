<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<%@ Register TagPrefix="include" TagName="head" Src="~/Include/Head.ascx" %>
<%@ Register TagPrefix="include" TagName="alt" Src="~/Include/Alt.ascx" %>
<%@ Register TagPrefix="include" TagName="logo" Src="~/Include/Logo.ascx" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <include:head runat="server" ID="head" />
</head>
<body>
    <form id="form1" runat="server">
    <include:logo runat="server" ID="logo" />
    <div class="nerdesin">Ana Sayfa &raquo; İletişim</div>
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
    <div class="icdiv beyazilan">
        <h1>Son eklenen ilanlar</h1>
        <asp:DataList runat="server" ID="soneklenenilan" Width="100%" RepeatColumns="5" RepeatDirection="Horizontal">
            <ItemTemplate>
                <div class="vitrinilanitem" style="background:#F4F4F4;">
                    <div class="vitrinilanresim" style="background:url(/Include/ResimGoster.aspx?R=/Upload/Ilan/<%# DataBinder.Eval(Container.DataItem, "Resim") %>&G=200&Y=160) no-repeat center;"></div>
                    <div class="clear h10"></div>
                    <div class="ilandetay">
                        <span class="ilanbaslik"><%# DataBinder.Eval(Container.DataItem, "IlanTur") %> <%# DataBinder.Eval(Container.DataItem, "Kategori") %></span><br />
                        <%# DataBinder.Eval(Container.DataItem, "Il") %>/<%# DataBinder.Eval(Container.DataItem, "Ilce") %><br /><span class="ilanfiyat"><%# String.Format("{0:N0}", DataBinder.Eval(Container.DataItem, "Fiyat")) %> <%# DataBinder.Eval(Container.DataItem, "FiyatTur") %></span><br /><%# DataBinder.Eval(Container.DataItem, "Baslik") %><br /><br /><img src="/Image/iconbina.png" alt="<%# DataBinder.Eval(Container.DataItem, "Baslik") %>" /><a href="<%# Class.Fonksiyonlar.Genel.SeoLinkOlustur("ilan", DataBinder.Eval(Container.DataItem, "ID").ToString(), DataBinder.Eval(Container.DataItem, "Baslik").ToString()) %>">İlanı detayları</a><br />
                    </div>
                </div>
            </ItemTemplate>
            <SeparatorTemplate><div class="w5"></div></SeparatorTemplate>
        </asp:DataList>
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
    <div class="icdiv">
        <div id="usual1" class="usual">
          <ul>
            <asp:Literal runat="server" ID="kategoriilanbaslik" />
          </ul>
          <asp:Literal runat="server" ID="kategoriilandetay" />
        </div>
        <script type="text/javascript">
            $("#usual1 ul").idTabs();
        </script>
    </div>
    <div class="clear h10"></div>
    <include:alt runat="server" ID="alt" />
    </form>
</body>
</html>
