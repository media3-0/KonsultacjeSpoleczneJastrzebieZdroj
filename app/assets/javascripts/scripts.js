/* JavaScript Document */

function textareafix(){
    //textarea
    autosize(document.querySelectorAll('textarea'));

    var FIREFOX = /Firefox/i.test(navigator.userAgent);

    if (FIREFOX) {
        var x = document.querySelectorAll("textarea");
        var i;
        for (i = 0; i < x.length; i++) {
            x[i].style.height = ((x[i].style.height.replace('px', ''))-1)+'px';
        }
    }
}

var toReport = -1;

function initScriptsJs(){

    //animatescroll and zoom
    var scrollTime = 1000;

    var zoom = 100;
    var zoomMultiplier = 0;

    $('.headerMoreButton').click(function() {
        scrollToElement($('#about'));
    });

    $('.fontSizePlus').click(function() {
        zoomTo("+");
    });

    $('.fontSizeMinus').click(function() {
        zoomTo("-");
    });
    $('.fontReset').click(function() {
        zoomTo("");
    });

    function zoomTo(znak) {
        if(znak == "+"){
            if(zoom<150){
                zoom += 10;
            }
        }
        else if(znak == "-"){
            if(zoom!=100){
                zoom -= 10;
            }
        }
        else{
            zoom = 100;
        }
        $("body").css({"font-size":zoom+"%"});
        var headerHeight = $("header").height();
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
        text: 'Korzystanie z tej witryny oznacza zgodę użytkownika na wykorzystywanie cookies oraz zapoznanie się z <a href="http://konsultacje.jastrzebie.pl/Regulamin_PKS.pdf">regulaminem platformy</a>',
        close: 'Zamknij',
        parent: jQuery('body'),
        animation: 'hide',
        use_default_css: false,
        auto_accept: false
    });

    //report post
    $(".reportButton").click(function(){
        var variables = getPositionOfItem($(this));
        createReportBox(variables.top,variables.left);
        var id = this.id.split('_')[1];
        toReport = id;
    });

    function getPositionOfItem(item){
        var left = $(item, this).offset().left;
        var top = $(item, this).offset().top;
        return {left:left, top:top};
    }

    function createReportBox(top,left) {
        $('body').append('<div class="reportBox" style="top:'+top+'px'+'; left:'+left+'px'+';">Czy jesteś pewien?<a class="yes">tak</a><a class="no">nie</a></div>');
    }

    $(document).on('click', ".reportBox .yes", function() { //close
        //report
        if(toReport != -1){
            $.ajax({
                url: 'http://konsultacje.jastrzebie.pl/consultations/report_post?id=' + toReport
            });
        }
        toReport = -1;
        $(this).parent("").remove();
    });

    $(document).on('click', ".reportBox .no", function() { //close
        $(this).parent("").remove();
    });

    hideFullBox(".reportBox");


    function hideFullBox(item){
        $(document).mouseup(function (e){ //close (click outside)
            var container = $(item);

            if (!container.is(e.target) // if the target of the click isn't the container...
                && container.has(e.target).length === 0) // ... nor a descendant of the container
            {
                container.remove();
            }
        });
    }

    //loadingBox
    centerFullBox('.loadingBox.fullSize');

    //alert

    hideFullBoxAlert(".alert.fullSize");

    function hideFullBoxAlert(item){
        createCloseButtonForAlert(item);
        hideFullBox(item);
    }

    function createCloseButtonForAlert(item){
        $(item).append( "<button>X</button>" );
        $(document).on('click', item+" button", function() {
            $(item).remove();
        });
    }

    centerFullBox('.alert.fullSize');

    function centerFullBox(item){
        if($(item).length !== 0){
            var height = $(item).outerHeight();
            $(item).css({"margin-top":"-"+height/2+"px"});
        }
    }

    //signIn pick type

    $("#signIn").click(function(event){
        event.preventDefault();
        var variables = getPositionOfItem($(this));
        createSignInBox(variables.top,variables.left);
        createCloseButtonForAlert(".signInBox");
    });

    function createSignInBox(top,left) {
        $('body').append('<div class="signInBox" style="top:'+top+'px'+'; left:'+left+'px'+';">Wybierz metodę logowania<a href="http://konsultacje.jastrzebie.pl/users/sign_in">tradycyjna</a><a href="http://konsultacje.jastrzebie.pl/users/auth/facebook">facebook</a></div>');
    }

    hideFullBox(".signInBox");

    $(document).on('click', ".fontNContrast", function() {
        $$("body").removeClass("black");
    });

    $(document).on('click', ".fontWBContrast", function() {
        $("body").addClass("black");
    });

    textareafix();
}