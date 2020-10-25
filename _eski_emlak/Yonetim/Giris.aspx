<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Giris.aspx.cs" Inherits="Yonetim_Default" %>

<%@ Register TagPrefix="include" TagName="Head" Src="~/Yonetim/Ascx/Head.ascx" %>
<%@ Register TagPrefix="recaptcha" Namespace="Recaptcha" Assembly="Recaptcha" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <include:Head runat="server" ID="head" />
    <style type="text/css">
        body {background:url(Image/bg.jpg) #B0ABB5 no-repeat top left;}
        .giris_form {margin:100px auto 0px auto; width:550px; padding:30px; background:#FFF; border:1px dotted #757388; text-align:center;}
        .input {padding:5px; width:200px; margin-bottom:10px;}
        input {padding:5px;}
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="giris_form">
            <img src="Image/logo.png" alt="Yönetim Paneli" /><br /><br /><br />
            <table align="center">
                <tbody>
                    <tr>
                        <td align="right"><strong>E-Posta Adresiniz</strong></td>
                        <td><strong>:</strong></td>
                        <td align="left"><asp:TextBox ID="form_kullanici" runat="server" CssClass="input"></asp:TextBox></td>
                    </tr>
                    <tr>
                        <td align="right"><strong>Şifreniz</strong></td>
                        <td><strong>:</strong></td>
                        <td align="left"><asp:TextBox ID="form_sifre" runat="server" CssClass="input" 
                                TextMode="Password"></asp:TextBox></td>
                    </tr>
                    <tr>
                        <td align="right" valign="top">&nbsp;</td>
                        <td valign="top">&nbsp;</td>
                        <td align="left"><recaptcha:RecaptchaControl ID="recaptcha" runat="server" 
                                PublicKey="6LfQs84SAAAAAKhzM23uEFTwZmOvpgRGvtGsIGc6" 
                                PrivateKey="6LfQs84SAAAAADPij_NDsvx24xLKy54N3mk7RBUK" Language="tr" /></td>
                    </tr>
                    <tr>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td align="left">
                            <asp:Button ID="btn_GirisYap" runat="server" Text="Giriş Yap" onclick="btn_GirisYap_Click" />
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    </form>
</body>
</html>
