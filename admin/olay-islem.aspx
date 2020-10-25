<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="olay-islem.aspx.cs" Inherits="emlak.admin.olay_islem" %>

<%@ Register TagPrefix="include" TagName="head" Src="~/admin/ascx/head.ascx" %>
<%@ Register TagPrefix="include" TagName="ust" Src="~/admin/ascx/ust.ascx" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <include:head runat="server" ID="head" />
    <script type="text/javascript">
        $(document).ready(function () {
            $(".menu ul #kullanici").addClass("secili");
            $(".menualt #kullanici_detay").css("display", "inline");
        });
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager runat="server" ID="sm"></asp:ScriptManager>
        <include:ust runat="server" ID="ust" />
        <div class="icerik">
            <asp:UpdatePanel runat="server" ID="update_tablo">
                <ContentTemplate>
                    <div class="blokbaslik">Ana Sayfa » Kullanıcı Yönetimi » İşlem Kayıtları</div>
                    <div class="blokicerik">
                        <div class="blokkomut">
                            <div style="display:inline; float:right; margin-left:10px;">Sayfa: <asp:DropDownList runat="server" ID="sayfa" AutoPostBack="true" OnSelectedIndexChanged="sayfasec" /></div>
                            <div style="display:inline; float:right; margin-left:10px;">Kayıt Sayısı: <asp:DropDownList runat="server" ID="kayitsayi" AutoPostBack="true" OnSelectedIndexChanged="kayitsayisec" /></div>
                            <div style="display:inline; float:right;"><asp:UpdateProgress runat="server" ID="ds"><ProgressTemplate><img src="img/yukleniyor.gif" alt="Yükleniyor..." /></ProgressTemplate></asp:UpdateProgress></div>
                            <div class="clear"></div>
                        </div>
                        <div class="h10"></div>
                        <asp:GridView ID="kayitlar" runat="server" Width="100%" CssClass="gridstil" AutoGenerateColumns="false" DataKeyNames="ID">
                            <EmptyDataTemplate>Kayıt bulunmuyor!</EmptyDataTemplate>
                            <Columns>
                                <asp:TemplateField ItemStyle-HorizontalAlign="Center" ItemStyle-Width="30">
                                    <HeaderTemplate>
                                        <asp:CheckBox ID="hepsinisec" runat="server" onClick="return coklusec(this);" ClientIDMode="Static" />
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:CheckBox ID="secim" runat="server" onClick="return coklusec(this);" ClientIDMode="Static" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="ID" HeaderText="ID" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="40" />
                                <asp:BoundField DataField="Kullanici" HeaderText="Kullanıcı" HeaderStyle-HorizontalAlign="Left" />
                                <asp:BoundField DataField="Tablo" HeaderText="Tablo" HeaderStyle-HorizontalAlign="Left" ItemStyle-Width="130" />
                                <asp:BoundField DataField="KayıtID" HeaderText="Kayıt ID" HeaderStyle-HorizontalAlign="Left" ItemStyle-Width="60" />
                                <asp:BoundField DataField="Islem" HeaderText="Yapılan İşlem" HeaderStyle-HorizontalAlign="Left" ItemStyle-Width="130" />
                                <asp:BoundField DataField="Ip" HeaderText="IP Adresi" HeaderStyle-HorizontalAlign="Left" ItemStyle-Width="130" />
                                <asp:BoundField DataField="KayitTarih" HeaderText="İşlem Tarihi" HeaderStyle-HorizontalAlign="Left" ItemStyle-Width="130" />
                            </Columns>
                        </asp:GridView>
                        <div class="h10"></div>
                        <div class="blokkomut"><asp:Button ID="secilenlerisil" runat="server" 
                                Text="Seçilenleri Sil" onclick="secilenlerisil_Click" 
                                
                                OnClientClick="return confirm('Seçilen kayıtları silmek istediğinizden eminmisiniz?');" />
                            &nbsp;<asp:Button ID="Button1" runat="server" onclick="Button1_Click" 
                                Text="Hepsini Sil" />
                        </div>
                    </div>
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="secilenlerisil" EventName="Click" />
                </Triggers>
            </asp:UpdatePanel>
        </div>
    </form>
</body>
</html>