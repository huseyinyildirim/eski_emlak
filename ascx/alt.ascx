<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="alt.ascx.cs" Inherits="emlak.ascx.alt" %>

<div class="fulldiv">
    <div class="icdiv alt">
        <table width="100%">
            <tbody>
                <tr>
                    <td valign="top">
                        <h3>
                            iletişime geçin</h3>
                        <strong>
                            <% Response.Write(emlak.Class.Fonksiyonlar.Genel.Parametre().Select(b=>b.firma).FirstOrDefault()); %></strong><br />
                        A:
                        <% Response.Write(emlak.Class.Fonksiyonlar.Genel.Parametre().Select(b => b.adres).FirstOrDefault()); %><br />
                        T:
                        <% Response.Write(emlak.Class.Fonksiyonlar.Genel.Parametre().Select(b => b.telefon).FirstOrDefault()); %><br />
                        E:
                        <% Response.Write(emlak.Class.Fonksiyonlar.Genel.Parametre().Select(b => b.eposta).FirstOrDefault()); %>
                    </td>
                    <td width="30">
                        &nbsp;
                    </td>
                    <td width="150" valign="top">
                        <h3>
                            kurumsal</h3>
                        <ul>
                            <li><a href="#">ana sayfa</a></li>
                            <asp:Literal runat="server" ID="altmenusayfa" />
                            <li><a href="#">iletişim</a></li>
                        </ul>
                    </td>
                    <td width="30">
                        &nbsp;
                    </td>
                    <td width="150" valign="top">
                        <h3>
                            ilanlarımız</h3>
                        <ul>
                            <asp:Literal runat="server" ID="altmenukategori" />
                        </ul>
                    </td>
                    <td width="30">
                        &nbsp;
                    </td>
                    <td valign="top">
                        <a href="<% Response.Write(emlak.Class.Fonksiyonlar.Genel.Parametre().Select(b=>b.facebook).FirstOrDefault()); %>"
                            target="_blank">
                            <img src="/img/sosyalag-facebook.jpg" /></a><br />
                        <br />
                        <a href="<% Response.Write(emlak.Class.Fonksiyonlar.Genel.Parametre().Select(b=>b.twitter).FirstOrDefault()); %>"
                            target="_blank">
                            <img src="/img/sosyalag-twitter.jpg" /></a><br />
                        <br />
                        <!-- AddThis Button BEGIN -->
                        <div class="addthis_toolbox addthis_default_style addthis_32x32_style">
                            <a class="addthis_button_preferred_1"></a><a class="addthis_button_preferred_2">
                            </a><a class="addthis_button_preferred_3"></a><a class="addthis_button_compact">
                            </a><a class="addthis_counter addthis_bubble_style"></a>
                        </div>
                        <script type="text/javascript" src="http://s7.addthis.com/js/250/addthis_widget.js#pubid=aristor"></script>
                        <!-- AddThis Button END -->
                        <br />
                        <g:plusone></g:plusone>
                    </td>
                </tr>
            </tbody>
        </table>
    </div>
</div>
