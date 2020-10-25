<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ilan-ekle-3.aspx.cs" Inherits="emlak.admin.ilan_ekle_3" %>

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

    <link href="App/swfupload/css/default.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="App/swfupload/swf/swfupload.js"></script>
	<script type="text/javascript" src="App/swfupload/js/handlers.js"></script>
	<script type="text/javascript">
	    var swfu;
	    window.onload = function () {
	        swfu = new SWFUpload({
	            upload_url: "App/swfupload/upload.aspx",
	            post_params: {
	                "ASPSESSID": "<%=Session.SessionID %>",
	                "id": "<%=Request.QueryString["ID"] %>"
	            },
	            file_size_limit: "2 MB",
	            file_types: "*.jpg",
	            file_types_description: "JPG Images",
	            file_upload_limit: "0",
	            file_queue_error_handler: fileQueueError,
	            file_dialog_complete_handler: fileDialogComplete,
	            upload_progress_handler: uploadProgress,
	            upload_error_handler: uploadError,
	            upload_success_handler: uploadSuccess,
	            upload_complete_handler: uploadComplete,
	            button_image_url: "App/swfupload/images/XPButtonNoText_160x22.png",
	            button_placeholder_id: "spanButtonPlaceholder",
	            button_width: 160,
	            button_height: 22,
	            button_text: '<span class="button">Resimleri Seç <span class="buttonSmall">(2 MB Max)</span></span>',
	            button_text_style: '.button { font-family: Helvetica, Arial, sans-serif; font-size: 14pt; } .buttonSmall { font-size: 10pt; }',
	            button_text_top_padding: 1,
	            button_text_left_padding: 5,
	            flash_url: "App/swfupload/swf/swfupload.swf",
	            custom_settings: {
	                upload_target: "divFileProgressContainer"
	            },
	            debug: false
	        });
	    }
	</script>

</head>
<body>
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
                
                <div id="swfu_container">
		            <div>
				        <span id="spanButtonPlaceholder"></span>
		            </div>
		            <div id="divFileProgressContainer"></div>
	            </div>

                <div class="h10"></div>

                <asp:DataList ID="dtResimler" RepeatColumns="6" RepeatDirection="Horizontal" runat="server" Width="100%">
                <ItemTemplate>
                <div><img src="/Include/ResimGoster.aspx?R=/upload/ilan/<%# Eval("Resim") %>&G=120&Y=120" /><br /><a href="?Islem=Sil&ResimID=<%# Eval("ID") %>&ID=<%# Eval("IlanID") %>">[Sil]</a></div>
                </ItemTemplate>
                </asp:DataList>

                <div class="h10"></div>
                <asp:Button ID="Button1" runat="server" Text="« Geri" onclick="Button1_Click" />&nbsp;<asp:Button ID="Button2" runat="server" Text="Devam »" onclick="Button2_Click" />
            </div>
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