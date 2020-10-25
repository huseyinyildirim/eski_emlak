<%@ Page Language="C#" AutoEventWireup="true" CodeFile="IlanSabitEkle.aspx.cs" Inherits="Yonetim_Kullanici" %>

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
            <div class="blokbaslik">Ana Sayfa » İlan Özellikleri » İlan Sabitleri » İlan Sabiti Ekle</div>
            <div class="blokicerik">
                <table>
                    <tbody>
                        <tr>
                            <td><strong>Sabit Adı</strong></td>
                            <td><strong>:</strong></td>
                            <td>
                                <asp:DropDownList ID="form_sabitid" runat="server" DataTextField="Sabit" 
                                    DataValueField="ID">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td class="style1"><strong>Kategori</strong></td>
                            <td class="style1"><strong>:</strong></td>
                            <td class="style1">
                                <asp:DropDownList ID="form_katid" runat="server" DataTextField="Baslik" DataValueField="ID">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3">&nbsp;</td>
                        </tr>
                        <tr>
                            <td><strong>Sabit Kontrol Tipi</strong></td>
                            <td><strong>:</strong></td>
                            <td>
                                <asp:DropDownList ID="form_tip" runat="server" DataTextField="Baslik" DataValueField="ID">
                                    <asp:ListItem Value="textbox">Metin Kutusu</asp:ListItem>
                                    <asp:ListItem Value="dropdown">Açılır Menü</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td><strong>Sabit Tipi Değişkenleri</strong></td>
                            <td><strong>:</strong></td>
                            <td>
                                <asp:DropDownList ID="form_tipdegisken" runat="server">
                                </asp:DropDownList>
                            &nbsp;(Eğer Sabit Kontrol Tipini &quot;Açılır Menü&quot; seçerseniz aşağıdaki alanda kontrolün 
                                değişkenlerini lütfen seçiniz.)</td>
                        </tr>
                        <tr>
                            <td colspan="3">&nbsp;</td>
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
                            <td colspan="3">&nbsp;</td>
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
            <div class="h10"></div>
            <div class="blokbaslik">Ne işe yarar?</div>
            <div class="blokicerik">Yukarıdaki form ile ekleyeceğiniz ilanın kategorisine göre 
                ilan özellikleri için form bileşenleri yaratır. (örn: İlan ekleme sayfalarının 
                2. adımı olan Oda Sayısı, Bulunduğu Kat gibi.)<br />
                Eğer ekleyeceğiniz sabit kontrol tipi &quot;Açılır Menü&quot; ve sabit kontrol tipi 
                değişkenlerinde istediğiniz kayıt yoksa ilk önce &quot;<a href="IlanDegisken.aspx">İlan 
                Değişkenleri</a>&quot; adımından sabit tipi değişkeni ekleyebilirsiniz.<br />
                Eğer &quot;Sabit Adı&quot; açılır menüsünde istediğiniz içerik yoksa aşağıdaki formdan 
                ekleyebilirsiniz. Bu alanın düzenlenmesi veya silinmesi yoktur. Sistem sabiti 
                olarak atanmaktadır.</div>
            <div class="h10"></div>
            <div class="blokbaslik">Sabit Adı Ekle</div>
            <div class="blokicerik">
                <table>
                    <tbody>
                        <tr>
                            <td><strong>Sabit Adı</strong></td>
                            <td><strong>:</strong></td>
                            <td><asp:TextBox ID="form_sabitadi" runat="server" Width="203px"></asp:TextBox></td>
                            <td>&nbsp;</td>
                            <td><asp:Button ID="btn_sabit_adi_ekle" runat="server" Text="Ekle" onclick="btn_sabit_adi_ekle_Click" /></td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </form>
</body>
</html>