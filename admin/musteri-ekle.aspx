<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="musteri-ekle.aspx.cs" Inherits="emlak.admin.musteri_ekle" %>

<%@ Register TagPrefix="include" TagName="head" Src="~/admin/ascx/head.ascx" %>
<%@ Register TagPrefix="include" TagName="ust" Src="~/admin/ascx/ust.ascx" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <include:head runat="server" ID="head" />
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
        <include:ust runat="server" ID="ust" />
        <div class="icerik">
            <div class="blokbaslik">Ana Sayfa » Müşteri » Müşteriler » Yeni Müşteri Ekle</div>
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
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>
                                &nbsp;</td>
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