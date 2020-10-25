<%@ Page Language="C#" AutoEventWireup="true" CodeFile="IlanEkle.aspx.cs" Inherits="Yonetim_Kullanici" %>

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
        <asp:ScriptManager runat="server" ID="sm"></asp:ScriptManager>
        <include:Ust runat="server" ID="ust" />
        <div class="icerik">
            <div class="blokbaslik">Ana Sayfa » İlanlar » İlan Ekle</div>
            <div class="blokicerik">
                <asp:ValidationSummary ID="hatalar" runat="server" ForeColor="#CC0000" ValidationGroup="ekle" />
                <asp:Literal runat=server ID="ilan_bilgi" />
                <table>
                    <tbody>
                        <tr>
                            <td><strong>İlan Türü</strong></td>
                            <td><strong>:</strong></td>
                            <td>
                                <asp:DropDownList ID="form_ilantur" runat="server">
                                    <asp:ListItem Selected="True">Seçiniz</asp:ListItem>
                                    <asp:ListItem>Satılık</asp:ListItem>
                                    <asp:ListItem>Kiralık</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <strong>Kategori</strong></td>
                            <td>
                                <strong>:</strong></td>
                            <td>
                                <asp:DropDownList ID="form_katid" runat="server">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3">
                                &nbsp;</td>
                        </tr>
                        <tr>
                            <td>
                                <strong>İlan Kodu</strong></td>
                            <td>
                                <strong>:</strong></td>
                            <td>
                                <asp:TextBox ID="form_ilankod" runat="server" Width="300px"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                                    ControlToValidate="form_ilankod" Display="None" 
                                    ErrorMessage="Lütfen ilan kodunu giriniz." ValidationGroup="ekle"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <strong>İlan Başlığı</strong></td>
                            <td>
                                <strong>:</strong></td>
                            <td>
                                <asp:TextBox ID="form_ilanbaslik" runat="server" Width="300px"></asp:TextBox>
                                &nbsp;(örn: Kadıköy&#39;de satılık 3+1 daire, Çankaya&#39;da kiralık 300 m² dükkan)<asp:RequiredFieldValidator 
                                    ID="RequiredFieldValidator2" runat="server" ControlToValidate="form_ilanbaslik" 
                                    Display="None" ErrorMessage="Lütfen ilan başlığını giriniz." 
                                    ValidationGroup="ekle"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <strong>Fiyatı</strong></td>
                            <td>
                                <strong>:</strong></td>
                            <td>
                                <asp:TextBox ID="form_fiyat" onkeypress="return SadeceRakam(event);" onblur="SadeceRakamBlur(event,false)" runat="server"></asp:TextBox>
                                <asp:DropDownList ID="form_fiyattur" runat="server">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <strong>İlan Süresi</strong></td>
                            <td>
                                <strong>:</strong></td>
                            <td>
                                <asp:DropDownList ID="form_ilansure" runat="server">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3">
                                &nbsp;</td>
                        </tr>
                        <asp:UpdatePanel runat="server" ID="up_sehir">
                        <ContentTemplate>
                        <tr>
                            <td>
                                <strong>İl</strong></td>
                            <td>
                                <strong>:</strong></td>
                            <td>
                                <asp:DropDownList ID="form_il" runat="server" DataTextField="Baslik" DataValueField="ID" AutoPostBack="true" onselectedindexchanged="form_il_SelectedIndexChanged"></asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <strong>İlçe</strong></td>
                            <td>
                                <strong>:</strong></td>
                            <td>
                                <asp:DropDownList ID="form_ilce" runat="server" DataTextField="Baslik" DataValueField="ID" AutoPostBack="true" onselectedindexchanged="form_ilce_SelectedIndexChanged" Enabled="false"></asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <strong>Semt</strong></td>
                            <td>
                                <strong>:</strong></td>
                            <td>
                                <asp:DropDownList ID="form_semt" runat="server" DataTextField="Baslik" DataValueField="ID" AutoPostBack="true" Enabled="false"></asp:DropDownList>
                            </td>
                        </tr>
                        </ContentTemplate>
                        </asp:UpdatePanel>
                        <tr>
                            <td>
                                <strong>Mevki</strong></td>
                            <td>
                                <strong>:</strong></td>
                            <td>
                                <asp:TextBox ID="form_mevki" runat="server" Width="300px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td valign="top">
                                <strong>Adres</strong></td>
                            <td valign="top">
                                <strong>:</strong></td>
                            <td>
                                <asp:TextBox ID="form_adres" runat="server" Height="99px" Width="300px" 
                                    TextMode="MultiLine"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <strong>Adresi Göster</strong></td>
                            <td>
                                <strong>:</strong></td>
                            <td>
                                <asp:DropDownList ID="form_adresgoster" runat="server">
                                    <asp:ListItem Value="0">Gösterilmesin</asp:ListItem>
                                    <asp:ListItem Value="1">Gösterilsin</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                &nbsp;</td>
                            <td>
                                &nbsp;</td>
                            <td>
                                &nbsp;</td>
                        </tr>
                        <tr>
                            <td>
                                <strong>İlan Satışı Yapıldı mı?</strong></td>
                            <td>
                                <strong>:</strong></td>
                            <td>
                                <asp:DropDownList ID="form_satis" runat="server">
                                    <asp:ListItem Value="0">Satışı Yapılmadı</asp:ListItem>
                                    <asp:ListItem Value="1">Satışı Yapıldı</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                &nbsp;</td>
                            <td>
                                &nbsp;</td>
                            <td>
                                &nbsp;</td>
                        </tr>
                        <tr>
                            <td>
                                <strong>Vitrinde Gösterilsin mi?</strong></td>
                            <td>
                                <strong>:</strong></td>
                            <td>
                                <asp:DropDownList ID="form_vitrin" runat="server">
                                    <asp:ListItem Value="0">Vitrinde Gösterme</asp:ListItem>
                                    <asp:ListItem Value="1">Vitrinde Göster</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <strong>İlan Yayınlansın mı?</strong></td>
                            <td>
                                <strong>:</strong></td>
                            <td>
                                <asp:DropDownList ID="form_onay" runat="server">
                                    <asp:ListItem Value="0">Yayınlanmasın</asp:ListItem>
                                    <asp:ListItem Value="1">Yayınlansın</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3">
                                &nbsp;</td>
                        </tr>
                        <tr>
                            <td>
                                &nbsp;</td>
                            <td>
                                &nbsp;</td>
                            <td>
                                <asp:Button ID="btn_devam" runat="server" onclick="btn_devam_Click" 
                                    Text="Devam »" ValidationGroup="ekle" />
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
            <asp:Panel runat="server" ID="kayit_bilgi" Visible="false">
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
            </asp:Panel>
        </div>
    </form>
</body>
</html>