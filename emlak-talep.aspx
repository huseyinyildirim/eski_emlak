<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="emlak-talep.aspx.cs" Inherits="emlak.emlak_talep" %>

<%@ Register TagPrefix="include" TagName="head" Src="~/ascx/head.ascx" %>
<%@ Register TagPrefix="include" TagName="alt" Src="~/ascx/alt.ascx" %>
<%@ Register TagPrefix="include" TagName="logo" Src="~/ascx/logo.ascx" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <include:head runat="server" ID="head" />
</head>
<body>
    <form id="form1" runat="server">
    <include:logo runat="server" ID="logo" />
    <div class="nerdesin">
        Ana Sayfa &raquo; Emlak Talebinde Bulun</div>
    <div class="clear h10">
    </div>
    <div class="icdiv beyazilan">
        <h1>
            Emlak Talebinde Bulun</h1>
        <asp:ValidationSummary ID="ValidationSummary1" runat="server" ForeColor="#CC0000"
            ValidationGroup="talep" />
        <table>
            <tbody>
                <tr>
                    <td>
                        <strong>Durumu</strong>
                    </td>
                    <td>
                        <strong>:</strong>
                    </td>
                    <td>
                        <asp:DropDownList ID="form_ilantur" runat="server" Width="150px">
                            <asp:ListItem>Seçiniz</asp:ListItem>
                            <asp:ListItem>Satılık</asp:ListItem>
                            <asp:ListItem>Kiralık</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td>
                        <strong>Kategori</strong>
                    </td>
                    <td>
                        <strong>:</strong>
                    </td>
                    <td>
                        <asp:DropDownList ID="form_kategori" runat="server" Width="150px">
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td>
                        &nbsp;
                    </td>
                    <td>
                        &nbsp;
                    </td>
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <asp:UpdatePanel runat="server" ID="up_il">
                    <ContentTemplate>
                        <tr>
                            <td>
                                <strong>İl</strong>
                            </td>
                            <td>
                                <strong>:</strong>
                            </td>
                            <td>
                                <asp:DropDownList ID="form_il" runat="server" Width="150px" AutoPostBack="true" OnSelectedIndexChanged="form_il_SelectedIndexChanged">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <strong>İlçe</strong>
                            </td>
                            <td>
                                <strong>:</strong>
                            </td>
                            <td>
                                <asp:DropDownList ID="form_ilce" runat="server" Width="150px" AutoPostBack="true"
                                    Enabled="false" OnSelectedIndexChanged="form_ilce_SelectedIndexChanged">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <strong>Semt</strong>
                            </td>
                            <td>
                                <strong>:</strong>
                            </td>
                            <td>
                                <asp:DropDownList ID="form_semt" runat="server" Width="150px" AutoPostBack="true"
                                    Enabled="false">
                                </asp:DropDownList>
                            </td>
                        </tr>
                    </ContentTemplate>
                </asp:UpdatePanel>
                <tr>
                    <td>
                        &nbsp;
                    </td>
                    <td>
                        &nbsp;
                    </td>
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td>
                        <strong>Adınız Soyadınız</strong>
                    </td>
                    <td>
                        <strong>:</strong>
                    </td>
                    <td>
                        <asp:TextBox ID="form_ad" runat="server" Width="300px"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="form_ad"
                            Display="None" ErrorMessage="Lütfen adınızı giriniz." ValidationGroup="talep"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td>
                        <strong>Telefon</strong>
                    </td>
                    <td>
                        <strong>:</strong>
                    </td>
                    <td>
                        <asp:TextBox ID="form_telefon" runat="server" Width="300px"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="form_telefon"
                            Display="None" ErrorMessage="Lütfen telefon numaranızı giriniz." ValidationGroup="talep"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td>
                        <strong>E-Posta</strong>
                    </td>
                    <td>
                        <strong>:</strong>
                    </td>
                    <td>
                        <asp:TextBox ID="form_eposta" runat="server" Width="300px"></asp:TextBox>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="form_eposta"
                            Display="None" ErrorMessage="E-posta adresinizi kontrol ediniz." ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
                            ValidationGroup="talep"></asp:RegularExpressionValidator>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="form_eposta"
                            Display="None" ErrorMessage="Lütfen e-posta adresinizi giriniz." ValidationGroup="talep"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td valign="top">
                        <strong>Mesajınız</strong>
                    </td>
                    <td valign="top">
                        <strong>:</strong>
                    </td>
                    <td>
                        <asp:TextBox ID="form_mesaj" runat="server" Height="150px" TextMode="MultiLine" Width="500px"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="form_mesaj"
                            Display="None" ErrorMessage="Lütfen mesajınızı giriniz." ValidationGroup="talep"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td>
                        &nbsp;
                    </td>
                    <td>
                        &nbsp;
                    </td>
                    <td>
                        <asp:Button ID="btn_emlak_talep" runat="server" Text="Talep Yapın" OnClick="btn_emlak_talep_Click"
                            ValidationGroup="talep" />
                    </td>
                </tr>
            </tbody>
        </table>
    </div>
    <div class="clear h10">
    </div>
    <div class="fulldiv">
        <div class="icdiv">
            <div class="sol ilanvurgu">
                <h1>
                    Sizde evinizi, arsanızı, ofisinizi ve diğer gayrimenkullerinizi satmak veya kiraya
                    vermek mi istiyorsunuz?</h1>
                <h3>
                    Emlak sektöründeki itibarımız, referanslarımız ve sitemizin yüksek ziyaretçi potansiyeli
                    ile gayrimenkulleriniz hemen değerlenecek. Bizimle irtibata geçiniz!</h3>
            </div>
            <div class="sag">
            </div>
        </div>
    </div>
    <div class="clear h10">
    </div>
    <div class="fulldiv">
        <div class="icdiv beyazilan">
            <h1>
                Vitrindekiler</h1>
            <ul id="mycarousel" class="jcarousel-skin-tango">
                <asp:Literal runat="server" ID="vitrinilan" />
            </ul>
        </div>
    </div>
    <div class="clear h10">
    </div>
    <include:alt runat="server" ID="alt" />
    </form>
</body>
</html>
