<%@ Page Language="C#" AutoEventWireup="true" CodeFile="KullaniciEkle.aspx.cs" Inherits="Yonetim_Kullanici" %>

<%@ Register TagPrefix="include" TagName="Head" Src="~/Yonetim/Ascx/Head.ascx" %>
<%@ Register TagPrefix="include" TagName="Ust" Src="~/Yonetim/Ascx/Ust.ascx" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <include:Head runat="server" ID="head" />
    <script type="text/javascript">
        $(document).ready(function () {
            $(".menu ul #kullanici").addClass("secili");
            $(".menualt #kullanici_detay").css("display", "inline");
        });
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager runat="server" ID="sm"></asp:ScriptManager>
        <include:Ust runat="server" ID="ust" />
        <div class="icerik">
            <div class="blokbaslik">Ana Sayfa » Kullanıcı Yönetimi » Kullanıcılar » Yeni Kullanıcı Ekle</div>
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
                            <td><strong>E-Posta Adresi</strong></td>
                            <td><strong>:</strong></td>
                            <td>
                                <asp:TextBox ID="form_eposta" runat="server" Width="300px"></asp:TextBox>
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" 
                                    ControlToValidate="form_eposta" Display="None" 
                                    ErrorMessage="Lütfen e-posta adresini kontrol ediniz." 
                                    ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" 
                                    ValidationGroup="ekle"></asp:RegularExpressionValidator>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                                    ControlToValidate="form_eposta" Display="None" 
                                    ErrorMessage="Lütfen e-posta adresini giriniz." ValidationGroup="ekle"></asp:RequiredFieldValidator>
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
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>
                                &nbsp;</td>
                        </tr>
                        <tr>
                            <td><strong>Şifre</strong></td>
                            <td><strong>:</strong></td>
                            <td>
                                <asp:TextBox ID="form_sifre" runat="server" TextMode="Password" Width="300px"></asp:TextBox>
                                <asp:CompareValidator ID="CompareValidator1" runat="server" 
                                    ControlToCompare="form_sifre" ControlToValidate="form_sifretekrar" 
                                    Display="None" ErrorMessage="Şifreler aynı değil." ValidationGroup="ekle"></asp:CompareValidator>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" 
                                    ControlToValidate="form_sifre" Display="None" 
                                    ErrorMessage="Lütfen şifreyi giriniz." ValidationGroup="ekle"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td><strong>Şifre Tekrar</strong></td>
                            <td><strong>:</strong></td>
                            <td>
                                <asp:TextBox ID="form_sifretekrar" runat="server" TextMode="Password" 
                                    Width="300px"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>
                                &nbsp;</td>
                        </tr>
                        <tr>
                            <td><strong>Onay</strong></td>
                            <td><strong>:</strong></td>
                            <td>
                                <asp:DropDownList ID="form_onay" runat="server">
                                    <asp:ListItem Value="1">Evet</asp:ListItem>
                                    <asp:ListItem Value="0">Hayır</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>
                                &nbsp;</td>
                        </tr>
                        <tr>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>
                                <asp:Button ID="btn_kayitekle" runat="server" Text="Ekle" 
                                    ValidationGroup="ekle" onclick="btn_kayitekle_Click" />
                            </td>
                        </tr>
                    </tbody>
                </table>
                <asp:ValidationSummary ID="hatalar" runat="server" ForeColor="#CC0000" ValidationGroup="ekle" />
            </div>
        </div>
    </form>
</body>
</html>