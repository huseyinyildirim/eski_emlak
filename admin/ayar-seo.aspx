<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ayar-seo.aspx.cs" Inherits="emlak.admin.ayar_seo" %>

<%@ Register TagPrefix="include" TagName="head" Src="~/admin/ascx/head.ascx" %>
<%@ Register TagPrefix="include" TagName="ust" Src="~/admin/ascx/ust.ascx" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <include:head runat="server" ID="head" />
    <script type="text/javascript">
        $(document).ready(function () {
            $(".menu ul #ayar").addClass("secili");
            $(".menualt #ayar_detay").css("display", "inline");
        });
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager runat="server" ID="sm"></asp:ScriptManager>
        <include:ust runat="server" ID="ust" />
        <div class="icerik">
            <div class="blokbaslik">Ana Sayfa » Ayarlar » Genel Ayarlar</div>
            <div class="blokicerik">
                <table>
                    <tbody>
                        <tr>
                            <td><strong>Başlık</strong></td>
                            <td><strong>:</strong></td>
                            <td>
                                <asp:TextBox ID="form_baslik" runat="server" Width="300px"></asp:TextBox>
                                <asp:RequiredFieldValidator 
                                    ID="RequiredFieldValidator1" runat="server" ControlToValidate="form_baslik" 
                                    Display="None" ErrorMessage="Lütfen başlığı giriniz." 
                                    ValidationGroup="ekle"></asp:RequiredFieldValidator>
&nbsp;</td>
                        </tr>
                        <tr>
                            <td><strong>Açıklama</strong></td>
                            <td><strong>:</strong></td>
                            <td>
                                <asp:TextBox ID="form_aciklama" runat="server" Width="300px"></asp:TextBox>
                                <asp:RequiredFieldValidator 
                                    ID="RequiredFieldValidator4" runat="server" ControlToValidate="form_aciklama" 
                                    Display="None" ErrorMessage="Lütfen açıklama giriniz." 
                                    ValidationGroup="ekle"></asp:RequiredFieldValidator>
                                </td>
                        </tr>
                        <tr>
                            <td><strong>Anahtar</strong></td>
                            <td><strong>:</strong></td>
                            <td>
                                <asp:TextBox ID="form_anahtar" runat="server" Width="300px"></asp:TextBox>
                                <asp:RequiredFieldValidator 
                                    ID="RequiredFieldValidator5" runat="server" ControlToValidate="form_anahtar" 
                                    Display="None" ErrorMessage="Lütfe anahtar kelimeleri giriniz." 
                                    ValidationGroup="ekle"></asp:RequiredFieldValidator>
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