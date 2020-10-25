<%@ Page Language="C#" AutoEventWireup="true" CodeFile="MesajYeni.aspx.cs" Inherits="Yonetim_Kullanici" %>

<%@ Register Assembly="CKEditor.NET" Namespace="CKEditor.NET" TagPrefix="CKEditor" %>

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
                    <div class="blokbaslik">Ana Sayfa » Mesaj Kutusu » Yeni Mesaj Gönder</div>
                    <div class="blokicerik">
                        <table>
                            <tr>
                                <td>
                                    <strong>Kime Gönderiyorsunuz?</strong></td>
                                <td>
                                    <strong>:</strong></td>
                                <td>
                                    <asp:DropDownList ID="form_aliciID" runat="server" DataTextField="Adi" DataValueField="ID">
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="3">
                                    &nbsp;</td>
                            </tr>
                            <tr>
                                <td>
                                    <strong>Konu</strong></td>
                                <td>
                                    <strong>:</strong></td>
                                <td>
                                    <asp:TextBox ID="form_konu" runat="server" Width="300px"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td valign="top">
                                    <strong>Mesaj</strong></td>
                                <td valign="top">
                                    <strong>:</strong></td>
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
                                <td>
                                    &nbsp;</td>
                                <td>
                                    &nbsp;</td>
                                <td>
                                    <asp:Button ID="Button1" runat="server" Text="Mesajı Gönder" 
                                        onclick="Button1_Click" />
                                </td>
                            </tr>
                        </table>
                    </div>
        </div>
    </form>
</body>
</html>