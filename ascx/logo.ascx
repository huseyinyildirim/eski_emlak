<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="logo.ascx.cs" Inherits="emlak.ascx.logo" %>
<style type="text/css">
    .style1
    {
        width: 100%;
    }
</style>
<div class="icdiv">
    <div class="sol">
        <a href="/">
            <img src="/img/logo.jpg" alt="Emlak Sitesi" /></a></div>
    <div class="sag">
        <ul class="anamenu">
            <li class="ilk">
                <h3>
                    <a href="/">ana sayfa</a></h3>
            </li>
            <asp:Literal runat="server" ID="ustmenusayfa" />
            <li>
                <h3>
                    <a href="/iletisim.aspx">iletişim</a></h3>
            </li>
        </ul>
    </div>
</div>
<div class="clear">
</div>
<div class="fulldiv2">
    <div class="icdiv">
        <ul class="anakategori">
            <asp:Literal runat="server" ID="kategori" />
        </ul>
    </div>
</div>
<div class="arama">
    <table class="style1">
        <tr>
            <td>
                Durumu
            </td>
            <td>
                İl seçiniz
            </td>
            <td>
                İlçe seçiniz
            </td>
            <td>
                Semt seçiniz
            </td>
            <td rowspan="5" valign="middle" width="50">
                <asp:Button ID="Button1" runat="server" Text="Ara" />
            </td>
        </tr>
        <tr>
            <td>
                <asp:DropDownList ID="form_ilantur" runat="server" Width="150px">
                    <asp:ListItem>Seçiniz</asp:ListItem>
                    <asp:ListItem>Satılık</asp:ListItem>
                    <asp:ListItem>Kiralık</asp:ListItem>
                </asp:DropDownList>
            </td>
            <asp:ScriptManager runat="server" ID="ScriptManager1">
            </asp:ScriptManager>
            <asp:UpdatePanel runat="server" ID="up_il">
                <ContentTemplate>
                    <td>
                        <asp:DropDownList ID="form_il" runat="server" Width="150px" AutoPostBack="true" OnSelectedIndexChanged="form_il_SelectedIndexChanged">
                        </asp:DropDownList>
                    </td>
                    <td>
                        <asp:DropDownList ID="form_ilce" runat="server" Width="150px" AutoPostBack="true"
                            Enabled="false" OnSelectedIndexChanged="form_ilce_SelectedIndexChanged">
                        </asp:DropDownList>
                    </td>
                    <td>
                        <asp:DropDownList ID="form_semt" runat="server" Width="150px" AutoPostBack="true"
                            Enabled="false">
                        </asp:DropDownList>
                    </td>
                </ContentTemplate>
            </asp:UpdatePanel>
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
            <td>
                &nbsp;
            </td>
        </tr>
        <tr>
            <td>
                Kategori
            </td>
            <td>
                Fiyat aralığı
            </td>
            <td>
                Anahtar kelime
            </td>
            <td>
                İlan no
            </td>
        </tr>
        <tr>
            <td>
                <asp:DropDownList ID="form_kategori" runat="server" Width="150px">
                </asp:DropDownList>
            </td>
            <td>
                <asp:TextBox ID="form_fiyat1" runat="server" Width="67px"></asp:TextBox>
                -
                <asp:TextBox ID="form_fiyat2" runat="server" Width="67px"></asp:TextBox>
            </td>
            <td>
                <asp:TextBox ID="form_anahtarkelime" runat="server" Width="150px"></asp:TextBox>
            </td>
            <td>
                <asp:TextBox ID="form_ilanno" runat="server" Width="150px"></asp:TextBox>
            </td>
        </tr>
    </table>
</div>
