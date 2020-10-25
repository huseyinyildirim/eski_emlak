<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ilan-ekle-4.aspx.cs" Inherits="emlak.admin.ilan_ekle_4" %>

<%@ Register TagPrefix="include" TagName="head" Src="~/admin/ascx/head.ascx" %>
<%@ Register TagPrefix="include" TagName="ust" Src="~/admin/ascx/ust.ascx" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <include:head runat="server" ID="head" />
    <script type="text/javascript">
        $(document).ready(function () {
            $(".menu ul #ilan").addClass("secili");
            $(".menualt #ilan_detay").css("display", "inline");
        });
    </script>
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
    <script type="text/javascript" src="http://maps.googleapis.com/maps/api/js?key=<%=Class.Fonksiyonlar.Genel.ParametreAl("GoogleMapApi")%>&sensor=true">
    </script>
    <script type="text/javascript">
        function initialize() {
            var myOptions = {
                center: new google.maps.LatLng(<asp:Literal runat="server" ID="mapkoordinat" />),
                zoom: <asp:Literal runat="server" ID="mapzoom" />,
                mapTypeId: google.maps.MapTypeId.HYBRID
            };
            var map = new google.maps.Map(document.getElementById("map_canvas"), myOptions);

            google.maps.event.addListener(map, 'click', function (event) {
                $("#koordinat").val(event.latLng);
            });

            marker = new google.maps.Marker({
      map:map,
      draggable:true,
      animation: google.maps.Animation.DROP,
      position: new google.maps.LatLng(<asp:Literal runat="server" ID="mapkoordinat2" />)
    });
    google.maps.event.addListener(marker, 'click', toggleBounce);
        }

        function toggleBounce() {

    if (marker.getAnimation() != null) {
      marker.setAnimation(null);
    } else {
      marker.setAnimation(google.maps.Animation.BOUNCE);
    }
  }
    </script>
</head>
<body onload="initialize()">
    <form id="form1" runat="server">
        <include:ust runat="server" ID="ust" />
        <div class="icerik">
            <div class="blokbaslik">Ana Sayfa » İlanlar » İlan Detayları</div>
            <div class="blokicerik">
                <fieldset>
                    <legend>İlan Bilgileri</legend>
                    <div><asp:Literal runat="server" ID="ilan_bilgi" /></div>
                </fieldset>
                <div class="h10"></div>
                <div id="map_canvas" style="height:500px; width:100%;"></div>
                <input id="koordinat" name="koordinat" type="hidden" />
                <div class="h10"></div>
                <table>
                    <tbody>
                        <tr>
                            <td>
                                <strong>Vitrinde Gösterilsin mi?</strong></td>
                            <td>
                                <strong>:</strong></td>
                            <td>
                                <asp:DropDownList ID="form_vitrin" runat="server">
                                    <asp:ListItem Value="0">Hayır</asp:ListItem>
                                    <asp:ListItem Value="1">Evet</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <strong>Onay</strong></td>
                            <td>
                                <strong>:</strong></td>
                            <td>
                                <asp:DropDownList ID="form_onay" runat="server">
                                    <asp:ListItem Value="0">Hayır</asp:ListItem>
                                    <asp:ListItem Value="1">Evet</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                    </tbody>
                </table>
                <div class="h10"></div>
                <asp:Button ID="Button1" runat="server" Text="« Geri" onclick="Button1_Click" />&nbsp;<asp:Button 
                    ID="Button2" runat="server" Text="Bitir" onclick="Button2_Click" />
            </div>
            <div class="h10"></div>
            <div class="blokbaslik">Ne işe yarar?</div>
            <div class="blokicerik">Haritada ilan vermek istediğiniz yeri bulduğunuzda lütfen 
                çift tıklayınız, böylelikle yeri seçmiş bulunuyorsunuz. Ziyaretçiler ilan 
                detayında ilanın tam olarak yerini işaretli olarak göremezler, sadece gizli ilan 
                yerinin etrafında bulunan alışveriş merkesi, durak, hastane, park vb. yerleri 
                görebilir. Civar bilgisi vermek içindir.</div>
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
