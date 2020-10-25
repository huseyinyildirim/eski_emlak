/* idTip ~ Sean Catchpole - Version 1.0 */

/*
<a class="idTip" href="http://www.jquery.com" title="jQuery Website"/>jQuery</a><br/>
<span class="idTip" title="#info">idTips are very interesting</span>
<span id="info">They can provide a vast amount of information</span>
<p class="idTip" title="#lambda">Lambda</p>
<img id="lambda" class="hidden" src="http://www.sunsean.com/images/symbol/_lambda.png"/>
*/

(function ($) {
    $.fn.idTip = function () {
        //Defaults 
        var s = { "over": null,
            "out": null,
            "event": "mouse",
            "title": null
        };

        //Loop Arguments matching options 
        var t = 1;
        for (var i = 0; i < arguments.length; ++i) {
            var n = {}, a = arguments[i];
            switch (typeof a) {
                case "object": $.extend(n, a); break;
                case "string": if (a.toLowerCase() == "mouse") n.event = "mouse";
                    else if (a.toLowerCase() == "click") n.event = "click";
                    else n.title = a; break;
                case "function": (t) ? (over = a) : (out = a); t = !t; break;
            }; $.extend(s, n);
        }

        //var self = this; //Save scope 
        var tip = $("#idTip"); //Save idTip
        if (!tip.length)
            tip = $('<div id="idTip">').hide()
      .css("position", "absolute").appendTo("body");

        //Over
        var over = function () {
            $(this).not('a').css("cursor", "default");
            var e = (s.over) ? s.over(this) : s.title || this.title;
            if (!e) return false; //Nothing to display
            if (typeof e == "string")
                if (e[0] == '#') e = $(e); //Fetch element with id
                else e = $('<p>').html(e); //Create text element
            tip.html(e.clone().show()).show();
            //TODO: Consider fading tooltips option
            return false;
        };

        //Out
        var out = function () {
            var e = (s.out) ? s.out(this) : s.title || this.title;
            if (!e) return false; //Nothing to display
            if (typeof e == "string")
                if (e[0] == '#') e = $(e); //Fetch element with id
                else e = $('<p>').html(e); //Create text element
            tip.html(e).hide();
            //TODO: Consider fading tooltips option
            return false;
        };

        //Move
        var move = function (m) {
            //TODO: Consider offset option (and over/out function able to extend settings)
            var x = ($.browser.msie) ? document.body.scrollLeft : window.pageXOffset;
            var y = ($.browser.msie) ? document.body.scrollTop : window.pageYOffset;
            tip.css({ top: m.clientY + 10 + y, left: m.clientX + 10 + x });
            return false;
        };

        //Setup Tips 
        //TODO: how does this work with multiple elements? ($.each)
        this.mousemove(move);
        if (s.event == "mouse") this.hover(over, out);
        else if (s.event == "click") this.toggle(over, out);

        return this; //Chainable 
    };
    $(function () { $(".idTip").idTip(); });
})(jQuery);