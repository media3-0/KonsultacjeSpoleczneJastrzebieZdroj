/* JavaScript Document */

$(document).ready(function(){

    //animatescroll and zoom
    var scrollTime = 1000;
    clickButtons();

    var zoom = 100;
    var zoomMultiplier = 0;

    function clickButtons() {
        $('.headerMoreButton').click(function() {
            scrollToElement($('#about'));
        });

        $('.fontSizePlus').click(function() {
            zoomTo("+",0.4);
        });

        $('.fontSizeMinus').click(function() {
            zoomTo("-",-0.4);
        });
        $('.fontReset').click(function() {
            zoomTo("",0);
        });
    }

    function zoomTo(znak,wartosc) {
        if(znak == "+"){
            if(zoom<150){
                zoom += 10;
                zoomMultiplier += 0.4;
            }
        }
        else if(znak == "-"){
            if(zoom!=100){
                zoom -= 10;
                zoomMultiplier -= 0.4;
            }
        }
        else{
            zoom = 100;
            zoomMultiplier = 0;
        }
        $("body").css({"font-size":zoom+"%"});
        $(".fullSize").css({"height":((zoomMultiplier*zoom)+760)+"px"});
    }

    function scrollToElement(element) {
        $('html, body').stop().animate({
            scrollTop: element.offset().top
        }, {
            duration: scrollTime,
            easing: 'easeInOutCubic',
            queue: false
        });
    }

    //cookies
    jQuery.fn.cookiesEU({
        text: 'W ramach naszej witryny stosujemy pliki cookies w celu świadczenia Państwu usług na najwyższym poziomie, w tym w sposób dostosowany do indywidualnych potrzeb. Korzystanie z witryny bez zmiany ustawień dotyczących cookies oznacza, że będą one zamieszczane w Państwa urządzeniu końcowym. Możecie Państwo dokonać w każdym czasie zmiany ustawień dotyczących cookies.',
        close: 'Zamknij',
        parent: jQuery('body'),
        animation: 'hide',
        use_default_css: false,
        auto_accept: false,
    });

    //textarea
    autosize(document.querySelectorAll('textarea'));
});