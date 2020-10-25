<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ust.ascx.cs" Inherits="emlak.admin.ascx.ust" %>
<div class="ust">
    <div class="sol">
        <img src="img/logo.png" /></div>
    <div class="sag" style="text-align: right;">
        <img src="img/kullanici.png" />
        Hoşgeldiniz,
        <asp:Literal runat="server" ID="kullaniciadi" />
        |
        <img src="img/profil.png" />
        <a href="profil.aspx">Profiliniz</a> |
        <asp:Literal runat="server" ID="mesaj" /><br />
        <br />
        <img src="img/site.png" />
        <a href="/" target="_blank">Siteye git</a> |
        <img src="img/cikis.png" />
        <a href="cikis.aspx">Güvenli çıkış</a></div>
</div>
<div class="clear">
</div>
<div class="menu">
    <ul>
        <li id="panel"><a href="javascript:menusec('panel')">Panel</a></li>
        <li id="ilan"><a href="javascript:menusec('ilan')">İlanlar</a></li>
        <li id="musteri"><a href="javascript:menusec('musteri')">Müşteri</a></li>
        <li id="ilanozellik"><a href="javascript:menusec('ilanozellik')">İlan Özellikleri</a></li>
        <li id="icerik"><a href="javascript:menusec('icerik')">İçerik Yönetimi</a></li>
        <li id="kullanici"><a href="javascript:menusec('kullanici')">Kullanıcı Yönetimi</a></li>
        <li id="arac"><a href="javascript:menusec('arac')">Araçlar</a></li>
        <li id="ayar"><a href="javascript:menusec('ayar')">Ayarlar</a></li>
        <li id="istatistik"><a href="javascript:menusec('istatistik')">İstatistikler</a></li>
    </ul>
</div>
<div class="clear">
</div>
<div class="menualt">
    <div class="menualtdetay" id="panel_detay" style="display: none;">
        <ul>
            <li><a href="default.aspx">Masaüstü</a></li>
            <li><a href="ilan.aspx">İlanlar</a></li>
            <li><a href="ilan-ekle.aspx">Yeni İlan Ekle</a></li>
            <li><a href="istatistik-ziyaretci.aspx">Ziyaretçiler</a></li>
            <li><a href="musteri.aspx">Müşteriler</a></li>
            <li><a href="musteri-talep.aspx">Emlak Talepleri</a></li>
        </ul>
    </div>
    <div class="clear">
    </div>
    <div class="menualtdetay" id="ilan_detay" style="display: none;">
        <ul>
            <li><a href="ilan-ekle.aspx">Yeni İlan Ekle</a></li>
            <li><a href="ilan.aspx">Yayındaki İlanlar</a></li>
            <li><a href="ilan-onaysiz.aspx">Onay Bekleyenler</a></li>
            <li><a href="ilan-satilan.aspx">Satılan İlanlar</a></li>
            <li><a href="ilan-kiralanan.aspx">Kiralanan İlanlar</a></li>
            <li><a href="ilan-arsiv.aspx">Arşivdeki İlanlar</a></li>
            <li><a href="ilan-vitrin.aspx">Vitrindeki İlanlar</a></li>
        </ul>
    </div>
    <div class="clear">
    </div>
    <div class="menualtdetay" id="musteri_detay" style="display: none;">
        <ul>
            <li><a href="musteri.aspx">Müşteriler</a></li>
            <li><a href="musteri-talep.aspx">Emlak Talepleri</a></li>
        </ul>
    </div>
    <div class="clear">
    </div>
    <div class="menualtdetay" id="ilanozellik_detay" style="display: none;">
        <ul>
            <li><a href="kategori.aspx">Kategoriler</a></li>
            <li><a href="sehir.aspx">Şehir Listesi</a></li>
            <li><a href="ilan-ozellik.aspx">İlan Özellikleri</a></li>
            <li><a href="ilan-degisken.aspx">İlan Değişkenleri</a></li>
            <li><a href="ilan-sabit.aspx">İlan Sabitleri</a></li>
        </ul>
    </div>
    <div class="clear">
    </div>
    <div class="menualtdetay" id="icerik_detay" style="display: none;">
        <ul>
            <li><a href="sayfa.aspx">Sayfalar</a></li>
            <li><a href="sayfa-ekle.aspx">Yeni Sayfa Ekle</a></li>
            <li><a href="haber.aspx">Haberler</a></li>
            <li><a href="haber-ekle.aspx">Yeni Haber Ekle</a></li>
        </ul>
    </div>
    <div class="clear">
    </div>
    <div class="menualtdetay" id="kullanici_detay" style="display: none;">
        <ul>
            <li><a href="kullanici.aspx">Kullanıcılar</a></li>
            <li><a href="kullanici-ekle.aspx">Yeni Kullanıcı Ekle</a></li>
            <li><a href="olay-giris-hata.aspx">Giriş Hataları</a></li>
            <li><a href="olay-giris-cikis.aspx">Giriş-Çıkış Kayıtları</a></li>
            <li><a href="olay-islem.aspx">İşlem Kayıtları</a></li>
        </ul>
    </div>
    <div class="clear">
    </div>
    <div class="menualtdetay" id="arac_detay" style="display: none;">
        <ul>
            <li><a href="arac-anket.aspx">Anket</a></li>
            <li><a href="arac-hava-durumu.aspx">Hava Durumu</a></li>
            <li><a href="arac-doviz.aspx">Döviz Kurları</a></li>
            <li></li>
        </ul>
    </div>
    <div class="clear">
    </div>
    <div class="menualtdetay" id="ayar_detay" style="display: none;">
        <ul>
            <li><a href="ayar-genel.aspx">Genel Ayarlar</a></li>
            <li><a href="ayar-parametre.aspx">Parametreler</a></li>
            <li><a href="ayar-seo.aspx">SEO Ayarları</a></li>
            <li><a href="ayar-eposta.aspx">E-Posta Ayarları</a></li>
        </ul>
    </div>
    <div class="clear">
    </div>
    <div class="menualtdetay" id="istatistik_detay" style="display: none;">
        <ul>
            <li><a href="istatistik-ziyaretci.aspx">Ziyaretçiler</a></li>
            <li><a href="istatistik-isletim-sistem.aspx">İşletim Sistemi</a></li>
            <li><a href="istatistik-tarayici.aspx">Tarayıcılar</a></li>
            <li><a href="istatistik-ulke.aspx">Ülkeler</a></li>
            <li><a href="istatistik-arama-motor.aspx">Arama Motorları</a></li>
            <li><a href="istatistik-yonlendiren.aspx">Yönlendiren Siteler</a></li>
            <li><a href="istatistik-sifirla.aspx">İstatistikleri Sıfırla</a></li>
        </ul>
    </div>
    <div class="clear">
    </div>
</div>
<div class="clear">
</div>