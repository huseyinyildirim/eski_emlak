<%@ Page Language="C#" AutoEventWireup="true" CodeFile="IlanEkle2.aspx.cs" Inherits="Yonetim_Kullanici" ClientIDMode="Static" %>

<%@ Register TagPrefix="include" TagName="Head" Src="~/Yonetim/Ascx/Head.ascx" %>
<%@ Register TagPrefix="include" TagName="Ust" Src="~/Yonetim/Ascx/Ust.ascx" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <include:Head runat="server" ID="head" />
    <script type="text/javascript">
        $(document).ready(function () {
            $(".menu ul #ilan").addClass("secili");
            $(".menualt #ilan_detay").css("display", "inline");
        });
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <include:Ust runat="server" ID="ust" />
        <div class="icerik">
            <div class="blokbaslik">Ana Sayfa » İlanlar » İlan Detayları</div>
            <div class="blokicerik">
                <fieldset>
                    <legend>İlan Bilgileri</legend>
                    <div><asp:Literal runat="server" ID="ilan_bilgi" /></div>
                </fieldset>
                <div class="h10"></div>
                <asp:GridView ID="Kayit" runat="server" AutoGenerateColumns="False" onrowdatabound="Kayit_RowDataBound" BackColor="White" BorderColor="White" BorderStyle="None" BorderWidth="1px" CellPadding="4" ForeColor="Black" GridLines="None" ShowHeader="False" ClientIDMode="Static">
                    <Columns>
                        <asp:BoundField DataField="SabitID" ItemStyle-Font-Bold="true" />
                        <asp:BoundField DataField="Tip" />
                        <asp:BoundField DataField="IlanDegiskenID" ItemStyle-ForeColor="White" />
                    </Columns>
                </asp:GridView>
                <div class="h10"></div>
                <div id="usual1" class="usual2">
                  <ul>
                    <asp:Literal runat="server" ID="kategoriilanbaslik" />
                  </ul>
                  <asp:Literal runat="server" ID="kategoriilandetay" />
                </div>
                <script type="text/javascript">
                    $("#usual1 ul").idTabs();
                </script>
                <div class="h10"></div>
                <asp:Button ID="Button1" runat="server" Text="« Geri" onclick="Button1_Click" />&nbsp;<asp:Button ID="Button2" runat="server" Text="Devam »" onclick="Button2_Click" />
            </div>
            <div class="h10"></div>
            <div class="blokbaslik">Kayıt Bilgileri</div>
            <div class="blokicerik">
                <table>
                    <tbody>
                        <tr>
                            <td><strong>Ekleyen</strong></td>
                            <td><strong>:</strong></td>
                            <td>
                                <asp:Literal ID="kayitbilgi_ekleyen" runat="server"></asp:Literal>
                            </td>
                        </tr>
                        <tr>
                            <td><strong>Kayıt Tarihi</strong></td>
                            <td><strong>:</strong></td>
                            <td>
                                <asp:Literal ID="kayitbilgi_kayittarih" runat="server"></asp:Literal>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3">&nbsp;</td>
                        </tr>
                        <tr>
                            <td><strong>Güncelleyen</strong></td>
                            <td><strong>:</strong></td>
                            <td>
                                <asp:Literal ID="kayitbilgi_gucelleyen" runat="server"></asp:Literal>
                            </td>
                        </tr>
                        <tr>
                            <td><strong>Güncellenme Tarihi</strong></td>
                            <td><strong>:</strong></td>
                            <td>
                                <asp:Literal ID="kayitbilgi_guncellemetarih" runat="server"></asp:Literal>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </form>
</body>
</html>