<%@ Page Language="C#" AutoEventWireup="true" CodeFile="MusteriTalepDuzenle.aspx.cs" Inherits="Yonetim_Kullanici" %>

<%@ Register Assembly="CKEditor.NET" Namespace="CKEditor.NET" TagPrefix="CKEditor" %>

<%@ Register TagPrefix="include" TagName="Head" Src="~/Yonetim/Ascx/Head.ascx" %>
<%@ Register TagPrefix="include" TagName="Ust" Src="~/Yonetim/Ascx/Ust.ascx" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <include:Head runat="server" ID="head" />
    <script type="text/javascript">
        $(document).ready(function () {
            $(".menu ul #musteri").addClass("secili");
            $(".menualt #musteri_detay").css("display", "inline");
        });
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager runat="server" ID="sm"></asp:ScriptManager>
        <include:Ust runat="server" ID="ust" />
        <div class="icerik">
            <div class="blokbaslik">Ana Sayfa » Müşteri » Emlak Talepleri » Emlak Taleplerini 
                İnceleme</div>
            <div class="blokicerik">
                <table>
                    <tbody>
                        <tr>
                            <td><strong>Adı Soyadı</strong></td>
                            <td><strong>:</strong></td>
                            <td>
                                <asp:Literal ID="form_adi" runat="server"></asp:Literal>
                            </td>
                        </tr>
                        <tr>
                            <td><strong>E-Posta</strong></td>
                            <td><strong>:</strong></td>
                            <td>
                                <asp:Literal ID="form_eposta" runat="server"></asp:Literal>
                            </td>
                        </tr>
                        <tr>
                            <td><strong>Telefon</strong></td>
                            <td><strong>:</strong></td>
                            <td>
                                <asp:Literal ID="form_telefon" runat="server"></asp:Literal>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3">&nbsp;</td>
                        </tr>
                        <tr>
                            <td><strong>İl</strong></td>
                            <td><strong>:</strong></td>
                            <td>
                                <asp:Literal ID="form_il" runat="server"></asp:Literal>
                            </td>
                        </tr>
                        <tr>
                            <td><strong>İlçe</strong></td>
                            <td><strong>:</strong></td>
                            <td>
                                <asp:Literal ID="form_ilce" runat="server"></asp:Literal>
                            </td>
                        </tr>
                        <tr>
                            <td><strong>Semt</strong></td>
                            <td><strong>:</strong></td>
                            <td>
                                <asp:Literal ID="form_semt" runat="server"></asp:Literal>
                            </td>
                        </tr>
                        <tr>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>
                                &nbsp;</td>
                        </tr>
                        <tr>
                            <td><strong>İlan Türü</strong></td>
                            <td><strong>:</strong></td>
                            <td>
                                <asp:Literal ID="form_ilantur" runat="server"></asp:Literal>
                            </td>
                        </tr>
                        <tr>
                            <td><strong>Kategori</strong></td>
                            <td><strong>:</strong></td>
                            <td>
                                <asp:Literal ID="form_kategori" runat="server"></asp:Literal>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3">&nbsp;</td>
                        </tr>
                        <tr>
                            <td><strong>Talep</strong></td>
                            <td><strong>:</strong></td>
                            <td>
                                <asp:Literal ID="form_talep" runat="server"></asp:Literal>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3">&nbsp;</td>
                        </tr>
                        <tr>
                            <td><strong>Durumu</strong></td>
                            <td><strong>:</strong></td>
                            <td>
                                <asp:DropDownList ID="form_durum" runat="server">
                                    <asp:ListItem>Cevaplandı</asp:ListItem>
                                    <asp:ListItem>Bekliyor</asp:ListItem>
                                    <asp:ListItem>İptal Edildi</asp:ListItem>
                                    <asp:ListItem>Sonuçlandı</asp:ListItem>
                                    <asp:ListItem>Bilgi Verildi</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3">&nbsp;</td>
                        </tr>
                        <tr>
                            <td valign="top"><strong>Yönetici Notları</strong></td>
                            <td valign="top"><strong>:</strong></td>
                            <td>
                                <CKEditor:CKEditorControl ID="form_detay" runat="server" Height="264px" 
                                    BasePath="~/Yonetim/App/ckeditor" 
                                    ContentsCss="~/Yonetim/App/ckeditor/contents.css" 
                                    
                                    TemplatesFiles="~/Yonetim/App/ckeditor/plugins/templates/templates/default.js" 
                                    EnterMode="BR" ShiftEnterMode="BR"
                                    FilebrowserBrowseUrl="/Yonetim/App/ckfinder/ckfinder.html"
	FilebrowserImageBrowseUrl="/Yonetim/App/ckfinder/ckfinder.html?type=Images"
	FilebrowserFlashBrowseUrl="/Yonetim/App/ckfinder/ckfinder.html?type=Flash"
	FilebrowserUploadUrl="/Yonetim/App/ckfinder/core/connector/aspx/connector.aspx?command=QuickUpload&type=Files"
	FilebrowserImageUploadUrl="/Yonetim/App/ckfinder/core/connector/aspx/connector.aspx?command=QuickUpload&type=Images"
	
                                    FilebrowserFlashUploadUrl="/Yonetim/App/ckfinder/core/connector/aspx/connector.aspx?command=QuickUpload&type=Flash" 
                                    Width="781px" Toolbar="Basic"></CKEditor:CKEditorControl>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3">&nbsp;</td>
                        </tr>
                        <tr>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>
                                <asp:Button ID="btn_kayitekle" runat="server" Text="Düzenle" 
                                    ValidationGroup="ekle" onclick="btn_kayitekle_Click" />
                            </td>
                        </tr>
                    </tbody>
                </table>
                <asp:ValidationSummary ID="hatalar" runat="server" ForeColor="#CC0000" ValidationGroup="ekle" />
            </div>
            <div class="h10"></div>
            <div class="blokbaslik">Kayıt Bilgileri</div>
            <div class="blokicerik">
                <table>
                    <tbody>
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