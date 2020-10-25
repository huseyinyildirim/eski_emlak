<%@ Page Language="C#" AutoEventWireup="true" CodeFile="MesajKutu.aspx.cs" Inherits="Yonetim_Kullanici" %>

<%@ Register TagPrefix="include" TagName="Head" Src="~/Yonetim/Ascx/Head.ascx" %>
<%@ Register TagPrefix="include" TagName="Ust" Src="~/Yonetim/Ascx/Ust.ascx" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <include:Head runat="server" ID="head" />
    <script type="text/javascript">
        $(document).ready(function () {
            $(".menu ul #panel").addClass("secili");
            $(".menualt #panel_detay").css("display", "inline");
        });
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager runat="server" ID="sm"></asp:ScriptManager>
        <include:Ust runat="server" ID="ust" />
        <div class="icerik">
            <asp:UpdatePanel runat="server" ID="update_tablo">
                <ContentTemplate>
                    <div class="blokbaslik">Ana Sayfa » Mesaj Kutusu</div>
                    <div class="blokicerik">
                        <div class="blokkomut">
                            <div style="display:inline; float:right; margin-left:10px;">Sayfa: <asp:DropDownList runat="server" ID="sayfa" AutoPostBack="true" OnSelectedIndexChanged="sayfasec" /></div>
                            <div style="display:inline; float:right; margin-left:10px;">Kayıt Sayısı: <asp:DropDownList runat="server" ID="kayitsayi" AutoPostBack="true" OnSelectedIndexChanged="kayitsayisec" /></div>
                            <div style="display:inline; float:right;"><asp:UpdateProgress runat="server" ID="ds"><ProgressTemplate><img src="Image/yukleniyor.gif" alt="Yükleniyor..." /></ProgressTemplate></asp:UpdateProgress></div>
                            <div class="clear"></div>
                        </div>
                        <div class="h10"></div>
                        <asp:GridView ID="kayitlar" runat="server" Width="100%" CssClass="gridstil" onrowdatabound="kayitlar_RowDataBound" AutoGenerateColumns="false" onrowcommand="kayitlar_RowCommand" DataKeyNames="ID">
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
                                <asp:BoundField DataField="Okundu" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="40" />
                                <asp:BoundField DataField="Gonderen" HeaderText="Gönderen" HeaderStyle-HorizontalAlign="Left" ItemStyle-Width="200" />
                                <asp:BoundField HtmlEncode="false" DataField="Baslik" HeaderText="Konu" HeaderStyle-HorizontalAlign="Left" />
                                <asp:BoundField DataField="KayitTarih" DataFormatString="{0:D}" HeaderText="Tarih" HeaderStyle-HorizontalAlign="Left" ItemStyle-Width="150" />
                                <asp:TemplateField ItemStyle-Width="100">
                                    <ItemTemplate>
                                        <a href="MesajOku.aspx?ID=<%# DataBinder.Eval(Container.DataItem, "ID")%>">Mesajı Oku</a>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                        <div class="h10"></div>
                        <div class="blokkomut"><asp:Button ID="secilenlerisil" runat="server" Text="Seçilenleri Sil" onclick="secilenlerisil_Click" OnClientClick="return confirm('Seçtiğiniz kayıtları silmek istediğinizden eminmisiniz?');" />&nbsp;<asp:Button 
                                ID="yeniekle" runat="server" Text="Yeni Mesaj Gönder" 
                                onclick="yeniekle_Click" />
                        </div>
                    </div>
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="secilenlerisil" EventName="Click" />
                    <asp:AsyncPostBackTrigger ControlID="yeniekle" EventName="Click" />
                </Triggers>
            </asp:UpdatePanel>
        </div>
    </form>
</body>
</html>