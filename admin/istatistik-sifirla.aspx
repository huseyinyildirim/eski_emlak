<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="istatistik-sifirla.aspx.cs" Inherits="emlak.admin.istatistik_sifirla" %>

<%@ Register TagPrefix="include" TagName="head" Src="~/admin/ascx/head.ascx" %>
<%@ Register TagPrefix="include" TagName="ust" Src="~/admin/ascx/ust.ascx" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <include:head runat="server" ID="head" />
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
        <include:ust runat="server" ID="ust" />
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
