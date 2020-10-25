<%@ Page Language="C#" AutoEventWireup="true" CodeFile="KategoriEkle.aspx.cs" Inherits="Yonetim_Kullanici" %>

<%@ Register TagPrefix="include" TagName="Head" Src="~/Yonetim/Ascx/Head.ascx" %>
<%@ Register TagPrefix="include" TagName="Ust" Src="~/Yonetim/Ascx/Ust.ascx" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <include:Head runat="server" ID="head" />
    <script type="text/javascript">
        $(document).ready(function () {
            $(".menu ul #ilanozellik").addClass("secili");
            $(".menualt #ilanozellik_detay").css("display", "inline");
        });
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager runat="server" ID="sm"></asp:ScriptManager>
        <include:Ust runat="server" ID="ust" />
        <div class="icerik">
            <div class="blokbaslik">Ana Sayfa » İlan Özellikleri » Kategoriler » Kategori Tipi Ekle</div>
            <div class="blokicerik">
                <table>
                    <tbody>
                        <tr>
                            <td><strong>Kategori Adı</strong></td>
                            <td><strong>:</strong></td>
                            <td>
                                <asp:TextBox ID="form_baslik" runat="server" Width="300px"></asp:TextBox><asp:RequiredFieldValidator 
                                    ID="RequiredFieldValidator1" runat="server" ControlToValidate="form_baslik" 
                                    Display="None" ErrorMessage="Lütfen kategori adını giriniz." 
                                    ValidationGroup="ekle"></asp:RequiredFieldValidator>
&nbsp;</td>
                        </tr>
                        <tr>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>
                                &nbsp;</td>
                        </tr>
                        <tr>
                            <td><strong>Alt Menüde Yayınlansın mı?</strong></td>
                            <td><strong>:</strong></td>
                            <td>
                                <asp:DropDownList ID="form_altmenu" runat="server">
                                    <asp:ListItem Value="1">Evet</asp:ListItem>
                                    <asp:ListItem Value="0">Hayır</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td><strong>Sıra</strong></td>
                            <td><strong>:</strong></td>
                            <td>
                                <asp:TextBox ID="form_sira" runat="server" Width="300px"></asp:TextBox><asp:RequiredFieldValidator 
                                    ID="RequiredFieldValidator2" runat="server" ControlToValidate="form_sira" 
                                    Display="None" ErrorMessage="Lütfen kategori sırasını giriniz." 
                                    ValidationGroup="ekle"></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" 
                                    ControlToValidate="form_sira" Display="None" 
                                    ErrorMessage="Lütfen sayı giriniz." ValidationExpression="^\d+$" 
                                    ValidationGroup="ekle"></asp:RegularExpressionValidator>
                            </td>
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