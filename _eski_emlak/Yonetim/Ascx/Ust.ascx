<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Ust.ascx.cs" Inherits="Yonetim_Ascx_ust" %>

<div class="ust">
    <div class="sol"><img src="Image/logo.png" /></div>
    <div class="sag" style="text-align:right;"><img src="Image/kullanici.png" /> Hoşgeldiniz, <asp:Literal runat="server" ID="kullaniciadi" /> | <img src="Image/profil.png" /> <a href="Profil.aspx">Profiliniz</a> | <asp:Literal runat="server" ID="mesaj" /><br /><br /><img src="Image/site.png" /> <a href="/" target="_blank">Siteye git</a> | <img src="Image/cikis.png" /> <a href="Cikis.aspx">Güvenli çıkış</a></div>
</div>

<div class="clear"></div>

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

<div class="clear"></div>

<div class="menualt">
    <div class="menualtdetay" id="panel_detay" style="display:none;">
        <ul>
            <li><a href="Default.aspx">Masaüstü</a></li>
            <li><a href="Ilan.aspx">İlanlar</a></li>
            <li><a href="IlanEkle.aspx">Yeni İlan Ekle</a></li>
            <li><a href="IstatistikZiyaretci.aspx">Ziyaretçiler</a></li>
            <li><a href="Musteri.aspx">Müşteriler</a></li>
            <li><a href="MusteriTalep.aspx">Emlak Talepleri</a></li>
        </ul>
    </div>
    <div class="clear"></div>
    <div class="menualtdetay" id="ilan_detay" style="display:none;">
        <ul>
            <li><a href="IlanEkle.aspx">Yeni İlan Ekle</a></li>
            <li><a href="Ilan.aspx">Yayındaki İlanlar</a></li>
            <li><a href="IlanOnaysiz.aspx">Onay Bekleyenler</a></li>
            <li><a href="IlanSatilan.aspx">Satılan İlanlar</a></li>
            <li><a href="IlanKiralanan.aspx">Kiralanan İlanlar</a></li>
            <li><a href="IlanArsiv.aspx">Arşivdeki İlanlar</a></li>
            <li><a href="IlanVitrin.aspx">Vitrindeki İlanlar</a></li>
        </ul>
    </div>
    <div class="clear"></div>
    <div class="menualtdetay" id="musteri_detay" style="display:none;">
        <ul>
            <li><a href="Musteri.aspx">Müşteriler</a></li>
            <li><a href="MusteriTalep.aspx">Emlak Talepleri</a></li>
        </ul>
    </div>
    <div class="clear"></div>
    <div class="menualtdetay" id="ilanozellik_detay" style="display:none;">
        <ul>
            <li><a href="Kategori.aspx">Kategoriler</a></li>
            <li><a href="Sehir.aspx">Şehir Listesi</a></li>
            <li><a href="IlanOzellik.aspx">İlan Özellikleri</a></li>
            <li><a href="IlanDegisken.aspx">İlan Değişkenleri</a></li>
            <li><a href="IlanSabit.aspx">İlan Sabitleri</a></li>
        </ul>
    </div>
    <div class="clear"></div>
    <div class="menualtdetay" id="icerik_detay" style="display:none;">
        <ul>
            <li><a href="Sayfa.aspx">Sayfalar</a></li>
            <li><a href="SayfaEkle.aspx">Yeni Sayfa Ekle</a></li>
            <li><a href="Haber.aspx">Haberler</a></li>
            <li><a href="HaberEkle.aspx">Yeni Haber Ekle</a></li>
        </ul>
    </div>
    <div class="clear"></div>
    <div class="menualtdetay" id="kullanici_detay" style="display:none;">
        <ul>
            <li><a href="Kullanici.aspx">Kullanıcılar</a></li>
            <li><a href="KullaniciEkle.aspx">Yeni Kullanıcı Ekle</a></li>
            <li><a href="OlayGirisHata.aspx">Giriş Hataları</a></li>
            <li><a href="OlayGirisCikis.aspx">Giriş-Çıkış Kayıtları</a></li>
            <li><a href="OlayIslem.aspx">İşlem Kayıtları</a></li>
        </ul>
    </div>
    <div class="clear"></div>
    <div class="menualtdetay" id="arac_detay" style="display:none;">
        <ul>
            <li><a href="AracAnket.aspx">Anket</a></li>
            <li><a href="AracHavaDurumu.aspx">Hava Durumu</a></li>
            <li><a href="AracDoviz.aspx">Döviz Kurları</a></li>
            <li></li>
        </ul>
    </div>
    <div class="clear"></div>
    <div class="menualtdetay" id="ayar_detay" style="display:none;">
        <ul>
            <li><a href="AyarGenel.aspx">Genel Ayarlar</a></li>
            <li><a href="AyarParametre.aspx">Parametreler</a></li>
            <li><a href="AyarSeo.aspx">SEO Ayarları</a></li>
            <li><a href="AyarEposta.aspx">E-Posta Ayarları</a></li>
        </ul>
    </div>
    <div class="clear"></div>
    <div class="menualtdetay" id="istatistik_detay" style="display:none;">
        <ul>
            <li><a href="IstatistikZiyaretci.aspx">Ziyaretçiler</a></li>
            <li><a href="IstatistikIsletimSistem.aspx">İşletim Sistemi</a></li>
            <li><a href="IstatistikTarayici.aspx">Tarayıcılar</a></li>
            <li><a href="IstatistikUlke.aspx">Ülkeler</a></li>
            <li><a href="IstatistikAramaMotor.aspx">Arama Motorları</a></li>
            <li><a href="IstatistikYonlendiren.aspx">Yönlendiren Siteler</a></li>
            <li><a href="IstatistikSifirla.aspx">İstatistikleri Sıfırla</a></li>
        </ul>
    </div>
    <div class="clear"></div>
</div>

<div class="clear"></div>