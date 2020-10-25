function menusec(menuadi) {
    $(".menualt div").css("display", "none")
    $(".menu ul li").removeClass("secili")
    $(".menu ul #" + menuadi + "").addClass("secili")
    $(".menualt #" + menuadi + "_detay").css("display", "inherit")
}

$(document).ready(function () {
    $('.onay').jConfirmAction({ question: "Eminmisiniz?", yesAnswer: "Evet", cancelAnswer: "Hayır" });
});

function coklusec(Val) {
    var ValChecked = Val.checked;
    var ValId = Val.id;
    var frm = document.forms[0];
    for (i = 0; i < frm.length; i++) {
        if (this != null) {
            if (ValId.indexOf('hepsinisec') != -1) {
                if (ValChecked)
                    frm.elements[i].checked = true;
                else
                    frm.elements[i].checked = false;
            }
            else if (ValId.indexOf('secim') != -1) {
                if (frm.elements[i].checked == false)
                    frm.elements[1].checked = false;
            }
        }
    }
}