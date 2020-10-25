<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AyarParametre.aspx.cs" Inherits="Yonetim_Kullanici" %>

<%@ Register TagPrefix="include" TagName="Head" Src="~/Yonetim/Ascx/Head.ascx" %>
<%@ Register TagPrefix="include" TagName="Ust" Src="~/Yonetim/Ascx/Ust.ascx" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <include:Head runat="server" ID="head" />
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
        <include:Ust runat="server" ID="ust" />
        <div class="icerik">
            <div class="blokbaslik">Ana Sayfa » Ayarlar » Parametreler</div>
            <div class="blokicerik">
                <table>
                    <tbody>
                        <tr>
                            <td><strong>Site Adresi</strong></td>
                            <td><strong>:</strong></td>
                            <td>
                                <asp:TextBox ID="form_siteadres" runat="server" Width="300px"></asp:TextBox>
                                <asp:RequiredFieldValidator 
                                    ID="RequiredFieldValidator1" runat="server" ControlToValidate="form_siteadres" 
                                    Display="None" ErrorMessage="Lütfen site adresini giriniz." 
                                    ValidationGroup="ekle"></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" 
                                    ControlToValidate="form_siteadres" Display="None" 
                                    ErrorMessage="Site adresini kontrol ediniz." 
                                    ValidationExpression="http(s)?://([\w-]+\.)+[\w-]+(/[\w- ./?%&amp;=]*)?" 
                                    ValidationGroup="ekle"></asp:RegularExpressionValidator>
&nbsp;</td>
                        </tr>
                        <tr>
                            <td><strong>Güvenlik Kodu</strong></td>
                            <td><strong>:</strong></td>
                            <td>
                                <asp:TextBox ID="form_guvenlikkod" runat="server" Width="300px" Enabled="False"></asp:TextBox>
                                <asp:RequiredFieldValidator 
                                    ID="RequiredFieldValidator4" runat="server" ControlToValidate="form_guvenlikkod" 
                                    Display="None" ErrorMessage="Lütfen güvenlik kodunu giriniz." 
                                    ValidationGroup="ekle"></asp:RequiredFieldValidator>
                                </td>
                        </tr>
                        <tr>
                            <td colspan="3">&nbsp;</td>
                        </tr>
                        <tr>
                            <td><strong>Google Map Api Key</strong></td>
                            <td><strong>:</strong></td>
                            <td>
                                <asp:TextBox ID="form_mapkey" runat="server" Width="300px"></asp:TextBox>
                                </td>
                        </tr>
                        <tr>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>
                                &nbsp;</td>
                        </tr>
                        <tr>
                            <td><strong>ReCaptcha Public Key</strong></td>
                            <td><strong>:</strong></td>
                            <td>
                                <asp:TextBox ID="form_publickey" runat="server" Width="300px"></asp:TextBox>
                                </td>
                        </tr>
                        <tr>
                            <td><strong>ReCaptcha Private Key</strong></td>
                            <td><strong>:</strong></td>
                            <td>
                                <asp:TextBox ID="form_privatekey" runat="server" Width="300px"></asp:TextBox>
                                </td>
                        </tr>
                        <tr>
                            <td colspan="3">&nbsp;</td>
                        </tr>
                        <tr>
                            <td><strong>Facebook Adresi</strong></td>
                            <td><strong>:</strong></td>
                            <td>
                                <asp:TextBox ID="form_facebook" runat="server" Width="300px"></asp:TextBox>
                                </td>
                        </tr>
                        <tr>
                            <td><strong>Twitter Adresi</strong></td>
                            <td><strong>:</strong></td>
                            <td>
                                <asp:TextBox ID="form_twitter" runat="server" Width="300px"></asp:TextBox>
                                </td>
                        </tr>
                        <tr>
                            <td colspan="3">&nbsp;</td>
                        </tr>
                        <tr>
                            <td><strong>Yönetim Liste Kayıt Sayısı</strong></td>
                            <td><strong>:</strong></td>
                            <td>
                                <asp:DropDownList runat="server" 
                                    ID="kayitsayi" />
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