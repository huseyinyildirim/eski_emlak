<%@ Page Language="C#" AutoEventWireup="true" CodeFile="IstatistikYonlendiren.aspx.cs" Inherits="Yonetim_Kullanici" %>

<%@ Register TagPrefix="include" TagName="Head" Src="~/Yonetim/Ascx/Head.ascx" %>
<%@ Register TagPrefix="include" TagName="Ust" Src="~/Yonetim/Ascx/Ust.ascx" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <include:Head runat="server" ID="head" />
    <script type="text/javascript">
        $(document).ready(function () {
            $(".menu ul #istatistik").addClass("secili");
            $(".menualt #istatistik_detay").css("display", "inline");
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
                    <div class="blokbaslik">Ana Sayfa » İstatistikler » Yönlendiren Siteler</div>
                    <div class="blokicerik">

                                        <div class="blokkomut">
                                            <div style="display:inline; float:right; margin-left:10px;">Sayfa: <asp:DropDownList runat="server" ID="sayfa" AutoPostBack="true" OnSelectedIndexChanged="sayfasec" /></div>
                                            <div style="display:inline; float:right; margin-left:10px;">Kayıt Sayısı: <asp:DropDownList runat="server" ID="kayitsayi" AutoPostBack="true" OnSelectedIndexChanged="kayitsayisec" /></div>
                                            <div style="display:inline; float:right;"><asp:UpdateProgress runat="server" ID="ds"><ProgressTemplate><img src="Image/yukleniyor.gif" alt="Yükleniyor..." /></ProgressTemplate></asp:UpdateProgress></div>
                                            <div class="clear"></div>
                                        </div>
                                        <div class="h10"></div>
                                        <asp:GridView ID="kayitlar" runat="server" Width="100%" CssClass="gridstil" AutoGenerateColumns="false">
                                            <EmptyDataTemplate>Kayıt bulunmuyor!</EmptyDataTemplate>
                                            <Columns>
                                                <asp:TemplateField>
                                                    <ItemTemplate>
                                                        <a href="<%# DataBinder.Eval(Container.DataItem, "Referans")%>" target="_blank"><%# DataBinder.Eval(Container.DataItem, "Referans")%></a>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                            </Columns>
                                        </asp:GridView>
                        
                    </div>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
    </form>
</body>
</html>