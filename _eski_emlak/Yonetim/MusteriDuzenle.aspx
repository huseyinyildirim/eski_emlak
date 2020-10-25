<%@ Page Language="C#" AutoEventWireup="true" CodeFile="MusteriDuzenle.aspx.cs" Inherits="Yonetim_Kullanici" %>

<%@ Register TagPrefix="include" TagName="Head" Src="~/Yonetim/Ascx/Head.ascx" %>
<%@ Register TagPrefix="include" TagName="Ust" Src="~/Yonetim/Ascx/Ust.ascx" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <include:Head runat="server" ID="head" />
    <script type="text/javascript">
        $(document).ready(function () {
            $(".menu ul #musteri").addClass("secili");
            $(".menualt #musteri_detay").css("display", "inline");
        });
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager runat="server" ID="sm"></asp:ScriptManager>
        <include:Ust runat="server" ID="ust" />
        <div class="icerik">
            <div class="blokbaslik">Ana Sayfa » Müşteri » Müşteriler » Müşteri Düzenle</div>
            <div class="blokicerik">
                <table>
                    <tbody>
                        <tr>
                            <td><strong>Adı Soyadı</strong></td>
                            <td><strong>:</strong></td>
                            <td>
                                <asp:TextBox ID="form_ad" runat="server" Width="300px"></asp:TextBox><asp:RequiredFieldValidator 
                                    ID="RequiredFieldValidator1" runat="server" ControlToValidate="form_ad" 
                                    Display="None" ErrorMessage="Lütfen adı soyadı giriniz." ValidationGroup="ekle"></asp:RequiredFieldValidator>
&nbsp;</td>
                        </tr>
                        <tr>
                            <td><strong>Adres</strong></td>
                            <td><strong>:</strong></td>
                            <td>
                                <asp:TextBox ID="form_adres" runat="server" Width="300px"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                                    ControlToValidate="form_adres" Display="None" 
                                    ErrorMessage="Lütfen adres giriniz." ValidationGroup="ekle"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td><strong>Telefon</strong></td>
                            <td><strong>:</strong></td>
                            <td>
                                <asp:TextBox ID="form_telefon" runat="server" Width="300px"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" 
                                    ControlToValidate="form_telefon" Display="None" 
                                    ErrorMessage="Lütfen telefon numarası giriniz." ValidationGroup="ekle"></asp:RequiredFieldValidator>
                                (örn: 0 532 123 45 67)</td>
                        </tr>
                        <tr>
                            <td colspan="3">&nbsp;</td>
                        </tr>
                        <tr>
                            <td valign="top"><strong>Not</strong></td>
                            <td valign="top"><strong>:</strong></td>
                            <td>
                                <asp:TextBox ID="form_not" runat="server" Width="500px" Height="125px" 
                                    TextMode="MultiLine"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3">&nbsp;</td>
                        </tr>
                        <tr>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>
                                <asp:Button ID="btn_kayitekle" runat="server" Text="Düzenle" 
                                    ValidationGroup="ekle" onclick="btn_kayitekle_Click" />
                            </td>
                        </tr>
                    </tbody>
                </table>
                <asp:ValidationSummary ID="hatalar" runat="server" ForeColor="#CC0000" ValidationGroup="ekle" />
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