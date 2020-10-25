$(document).ready(function () {
    Cufon.replace('h1', { fontFamily: 'Myriad Pro Semibold Italic', hover: true });
    Cufon.replace('h2', { fontFamily: 'Myriad Pro Semibold', hover: true });
    Cufon.replace('h3', { fontFamily: 'Myriad Pro Regular', hover: true });
    Cufon.replace('h4', { fontFamily: 'Myriad Pro Condensed Italic' });
    Cufon.replace('h5', { fontFamily: 'Myriad Pro Condensed', hover: true });
    Cufon.replace('h6', { fontFamily: 'Myriad Pro Bold Italic', hover: true });
    Cufon.replace('h7', { fontFamily: 'Myriad Pro Bold Condensed Italic', hover: true });
    Cufon.replace('h8', { fontFamily: 'Myriad Pro Bold Condensed', hover: true });
    Cufon.replace('h9', { fontFamily: 'Myriad Pro Bold', hover: true });

    $(".yorumyaz").colorbox({ iframe: true, innerWidth: 600, innerHeight: 400 });
    $(".fotogalerislide").colorbox({ iframe: true, innerWidth: 600, innerHeight: 400, rel: 'fotogalerislide', slideshow: true });

    /*$(".group1").colorbox({ rel: 'group1' });
    $(".group2").colorbox({ rel: 'group2', transition: "fade" });
    $(".group3").colorbox({ rel: 'group3', transition: "none", width: "75%", height: "75%" });
    $(".group4").colorbox({ rel: 'group4', slideshow: true });
    $(".ajax").colorbox();
    $(".youtube").colorbox({ iframe: true, innerWidth: 425, innerHeight: 344 });
    $(".iframe").colorbox({ iframe: true, width: "80%", height: "80%" });
    $(".inline").colorbox({ inline: true, width: "50%" });
    $(".callbacks").colorbox({
    onOpen: function () { alert('onOpen: colorbox is about to open'); },
    onLoad: function () { alert('onLoad: colorbox has started to load the targeted content'); },
    onComplete: function () { alert('onComplete: colorbox has displayed the loaded content'); },
    onCleanup: function () { alert('onCleanup: colorbox has begun the close process'); },
    onClosed: function () { alert('onClosed: colorbox has completely closed'); }
    });
    $("#click").click(function () {
    $('#click').css({ "background-color": "#f00", "color": "#fff", "cursor": "inherit" }).text("Open this window again and this message will still be here.");
    return false;
    });*/

    $('#yourSliderId').DDSlider({
        nextSlide: '.slider_arrow_right',
        prevSlide: '.slider_arrow_left',
        selector: '.slider_selector'
    });
});