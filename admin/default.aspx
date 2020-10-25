<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="emlak.admin._default" %>

<%@ Register TagPrefix="include" TagName="head" Src="~/admin/ascx/head.ascx" %>
<%@ Register TagPrefix="include" TagName="ust" Src="~/admin/ascx/ust.ascx" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<include:head runat="server" ID="head" />
    <script type="text/javascript">
        $(document).ready(function () {
            $(".menu ul #panel").addClass("secili");
            $(".menualt #panel_detay").css("display", "inline");
        });
    </script>
    <asp:Literal runat="server" ID="grafik" />
    <style type="text/css">
        .style1
        {
            width: 100%;
        }
        .style2
        {
            width: 64px;
            height: 64px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <include:ust runat="server" ID="ust" />
        <div class="icerik">
            <div class="blokbaslik">Masaüstü</div>
            <div class="blokicerik">
                <table width="100%">
                    <tbody>
                        <tr>
                            <td width="48%" valign="top">
                                <table class="style1">
                                    <tr>
                                        <td align="center">
                                            <img class="style2" src="Image/icon-ilan.png" /></td>
                                        <td align="center">
                                            <img class="style2" src="Image/icon-ilan-ekle.png" /></td>
                                    </tr>
                                    <tr>
                                        <td align="center">
                                            <a href="Ilan.aspx">Yayındaki İlanlar</a></td>
                                        <td align="center">
                                            <a href="IlanEkle.aspx">Yeni İlan Ekle</a></td>
                                    </tr>
                                    <tr>
                                        <td align="center">
                                            &nbsp;</td>
                                        <td align="center">
                                            &nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td align="center">
                                            <img class="style2" src="Image/icon-kullanici.png" /></td>
                                        <td align="center">
                                            <img class="style2" src="Image/icon-kullanici-ekle.png" /></td>
                                    </tr>
                                    <tr>
                                        <td align="center">
                                            <a href="Kullanici.aspx">Kullanıcılar</a></td>
                                        <td align="center">
                                            <a href="KullaniciEkle.aspx">Yeni Kullanıcı Ekle</a></td>
                                    </tr>
                                </table>
                                <br />
                                <asp:Literal ID="uyarilar" runat="server"></asp:Literal>
                            </td>
                            <td width="2%">&nbsp;</td>
                            <td width="48%" valign="top" align="center">Ziyaretçi İstatistikleri<br /><div id="chart_div" style="width:800px; height:300px;"></div></td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </form>
</body>
</html>
