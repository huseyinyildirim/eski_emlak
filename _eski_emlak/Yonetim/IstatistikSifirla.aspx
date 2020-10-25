<%@ Page Language="C#" AutoEventWireup="true" CodeFile="IstatistikSifirla.aspx.cs" Inherits="Yonetim_Kullanici" %>

<%@ Register TagPrefix="include" TagName="Head" Src="~/Yonetim/Ascx/Head.ascx" %>
<%@ Register TagPrefix="include" TagName="Ust" Src="~/Yonetim/Ascx/Ust.ascx" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <include:Head runat="server" ID="head" />
    <script type="text/javascript">
        $(document).ready(function () {
            $(".menu ul #istatistik").addClass("secili");
            $(".menualt #istatistik_detay").css("display", "inline");
        });
    </script>
    <asp:Literal runat="server" ID="grafik" />
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager runat="server" ID="sm"></asp:ScriptManager>
        <include:Ust runat="server" ID="ust" />
        <div class="icerik">
                    <div class="blokbaslik">Ana Sayfa » İstatistikler » İstatistikleri Sıfırla</div>
                    <div class="blokicerik">
                        
                        <asp:Button ID="Button1" runat="server" onclick="Button1_Click" 
                            Text="Bütün İstatistikleri Sfırla" OnClientClick="return confirm('İstatistikleri sıfırlamak istediğinizden eminmisiniz?');" />
                        <br />
                        <br />
                        Önemli: Bu işlemin hiç bir şekilde geri dönüşü yoktur. Bütün istatistikler 
                        sıfırlanacaktır.</div>
        </div>
    </form>
</body>
</html>