<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="sayfa-ekle.aspx.cs" Inherits="emlak.admin.sayfa_ekle" %>

<%@ Register TagPrefix="include" TagName="head" Src="~/admin/ascx/head.ascx" %>
<%@ Register TagPrefix="include" TagName="ust" Src="~/admin/ascx/ust.ascx" %>

<%@ Register Assembly="CKEditor.NET" Namespace="CKEditor.NET" TagPrefix="CKEditor" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <include:head runat="server" ID="head" />
    <script type="text/javascript">
        $(document).ready(function () {
            $(".menu ul #icerik").addClass("secili");
            $(".menualt #icerik_detay").css("display", "inline");
        });
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager runat="server" ID="sm"></asp:ScriptManager>
        <include:ust runat="server" ID="ust" />
        <div class="icerik">
            <div class="blokbaslik">Ana Sayfa » İçerik Yönetimi » Sayfalar » Sayfa Düzenle</div>
            <div class="blokicerik">
                <asp:ValidationSummary CssClass="form_hata" ID="hatalar" runat="server" ForeColor="#CC0000" ValidationGroup="ekle" />
                <table>
                    <tbody>
                        <tr>
                            <td><strong>Kategori</strong></td>
                            <td><strong>:</strong></td>
                            <td>
                                <asp:DropDownList ID="form_katid" runat="server"></asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3">&nbsp;</td>
                        </tr>
                        <tr>
                            <td><strong>Sayfa Adı</strong></td>
                            <td><strong>:</strong></td>
                            <td>
                                <asp:TextBox ID="form_baslik" runat="server" Width="300px"></asp:TextBox>
                                <asp:RequiredFieldValidator 
                                    ID="RequiredFieldValidator1" runat="server" ControlToValidate="form_baslik" 
                                    Display="None" ErrorMessage="Lütfen sayfa adını giriniz." 
                                    ValidationGroup="ekle"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td valign="top"><strong>Özet</strong></td>
                            <td valign="top"><strong>:</strong></td>
                            <td>
                                <CKEditor:CKEditorControl ID="form_ozet" runat="server" Height="100px" 
                                    BasePath="~/Yonetim/App/ckeditor" 
                                    ContentsCss="~/Yonetim/App/ckeditor/contents.css" 
                                    TemplatesFiles="~/Yonetim/App/ckeditor/plugins/templates/templates/default.js" 
                                    Toolbar="" EnterMode="BR" ShiftEnterMode="BR"></CKEditor:CKEditorControl>
                            </td>
                        </tr>
                        <tr>
                            <td valign="top"><strong>Detay</strong></td>
                            <td valign="top"><strong>:</strong></td>
                            <td>
                                <CKEditor:CKEditorControl ID="form_detay" runat="server" Height="200" 
                                    BasePath="~/Yonetim/App/ckeditor" 
                                    ContentsCss="~/Yonetim/App/ckeditor/contents.css" 
                                    TemplatesFiles="~/Yonetim/App/ckeditor/plugins/templates/templates/default.js"
                                    FilebrowserBrowseUrl="/Yonetim/App/ckfinder/ckfinder.html"
	FilebrowserImageBrowseUrl="/Yonetim/App/ckfinder/ckfinder.html?type=Images"
	FilebrowserFlashBrowseUrl="/Yonetim/App/ckfinder/ckfinder.html?type=Flash"
	FilebrowserUploadUrl="/Yonetim/App/ckfinder/core/connector/aspx/connector.aspx?command=QuickUpload&type=Files"
	FilebrowserImageUploadUrl="/Yonetim/App/ckfinder/core/connector/aspx/connector.aspx?command=QuickUpload&type=Images"
	
                                    FilebrowserFlashUploadUrl="/Yonetim/App/ckfinder/core/connector/aspx/connector.aspx?command=QuickUpload&type=Flash" 
                                    EnterMode="BR" ShiftEnterMode="BR"
                                    ></CKEditor:CKEditorControl>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3">&nbsp;</td>
                        </tr>
                        <tr>
                            <td><strong>Ana Menüde Göster</strong></td>
                            <td><strong>:</strong></td>
                            <td>
                                <asp:DropDownList ID="form_anamenu" runat="server">
                                    <asp:ListItem Value="1">Evet</asp:ListItem>
                                    <asp:ListItem Value="0">Hayır</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td><strong>Alt Menüde Göster</strong></td>
                            <td><strong>:</strong></td>
                            <td>
                                <asp:DropDownList ID="form_altmenu" runat="server">
                                    <asp:ListItem Value="1">Evet</asp:ListItem>
                                    <asp:ListItem Value="0">Hayır</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td><strong>Sıra</strong></td>
                            <td><strong>:</strong></td>
                            <td>
                                <asp:TextBox ID="form_sira" runat="server"></asp:TextBox>
                                <asp:RequiredFieldValidator 
                                    ID="RequiredFieldValidator2" runat="server" ControlToValidate="form_sira" 
                                    Display="None" ErrorMessage="Lütfen sırasını giriniz." 
                                    ValidationGroup="ekle"></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" 
                                    ControlToValidate="form_sira" Display="None" 
                                    ErrorMessage="Lütfen sayı giriniz." ValidationExpression="^\d+$" 
                                    ValidationGroup="ekle"></asp:RegularExpressionValidator>
                                </td>
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
                                <asp:Button ID="btn_kayitekle" runat="server" Text="Düzenle" 
                                    ValidationGroup="ekle" onclick="btn_kayitekle_Click" />
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </form>
</body>
</html>