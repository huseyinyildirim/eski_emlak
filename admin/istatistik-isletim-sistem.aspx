<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="istatistik-isletim-sistem.aspx.cs" Inherits="emlak.admin.istatistik_isletim_sistem" %>

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
            <asp:UpdatePanel runat="server" ID="update_tablo">
                <ContentTemplate>
                    <div class="blokbaslik">Ana Sayfa » İstatistikler » İşletim Sistemi</div>
                    <div class="blokicerik">
                        <table width="100%">
                            <tbody>
                                <tr>
                                    <td valign="top" width="600px">
                                        <div id="chart_div" style="width: 600px; height: 500px;"></div>
                                    </td>
                                    <td valign="top">
                                        <div class="blokkomut">
                                            <div style="display:inline; float:right; margin-left:10px;">Sayfa: <asp:DropDownList runat="server" ID="sayfa" AutoPostBack="true" OnSelectedIndexChanged="sayfasec" /></div>
                                            <div style="display:inline; float:right; margin-left:10px;">Kayıt Sayısı: <asp:DropDownList runat="server" ID="kayitsayi" AutoPostBack="true" OnSelectedIndexChanged="kayitsayisec" /></div>
                                            <div style="display:inline; float:right;"><asp:UpdateProgress runat="server" ID="ds"><ProgressTemplate><img src="img/yukleniyor.gif" alt="Yükleniyor..." /></ProgressTemplate></asp:UpdateProgress></div>
                                            <div class="clear"></div>
                                        </div>
                                        <div class="h10"></div>
                                        <asp:GridView ID="kayitlar" runat="server" Width="100%" CssClass="gridstil" AutoGenerateColumns="false">
                                            <EmptyDataTemplate>Kayıt bulunmuyor!</EmptyDataTemplate>
                                            <Columns>
                                                <asp:BoundField DataField="IsletimSistemi" HeaderText="İşletim Sistemi" HeaderStyle-HorizontalAlign="Left" />
                                                <asp:BoundField DataField="Hit" HeaderText="Hit" HeaderStyle-HorizontalAlign="Left" ItemStyle-Width="100" />
                                            </Columns>
                                        </asp:GridView>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                        
                    </div>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
    </form>
</body>
</html>
