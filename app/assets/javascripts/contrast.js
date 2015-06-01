/*
 Copyrights (c) 2015 Jakub Król. All rights reserved. j.k[at] t.pl
 ver 0.2.0
*/

function splitComponent(color) {

 var rgbColors=new Object();

 color = color.substring(color.indexOf('(')+1, color.indexOf(')'));

 var result = color.split(',', 3);

 return result ? { 

 r: parseFloat(result[0]/255),

 g: parseFloat(result[1]/255),

 b: parseFloat(result[2]/255) 

 } : null;

}

function changeBG(ledge, colorValue, forceColor){
var gamma = 2.2;

jQuery(ledge).attr("style", "background-color: "+colorValue+" !important; "+jQuery(ledge).attr("style"));

if (typeof forceColor == 'string'){
  var color=forceColor;
} else {
var computedStyle = getComputedStyle(ledge, null);

var bgColor = computedStyle.backgroundColor;

var luminosity = 0.2126 * Math.pow(splitComponent(bgColor).r,gamma) + 0.7152 * Math.pow(splitComponent(bgColor).g,gamma) + 0.0722 * Math.pow(splitComponent(bgColor).b, gamma);

if (luminosity < 0.5) { 
var color='#fff';
} else {
var color='#000';
}
}

//This MUST be like this:
jQuery(ledge).attr("style", "color: "+color+" !important; "+jQuery(ledge).attr("style"));

}

function HighContrastOn(){
	setCookie('highContrast', 1, 360);
	jQuery('*').each(function(){
		changeBG(this, '#000000', '#fff');
	});/*.css({'background-image':'none'}); - na potrzeby konsultacji */
jQuery('*').focus(function(){
    jQuery(this).css({'outline':'solid 2px yellow'});
    jQuery(this).data('oryg-outline', jQuery(this).css('outline')+"");
}).blur(function(){
    jQuery(this).css({'outline':'none'});    
}).css({'outline':'none'});
}

function HighContrastOff(){
	setCookie('highContrast', 0, 360);
	window.location.reload();
}

function changeFontSize(fontvar, skipCookie) {
	if (fontvar==1){
		setCookie('fontSize', 0, 360);
		window.location.reload();
		return;
	}
	var oldFontSize = getCookie('fontSize');
	if (oldFontSize == '')
		oldFontSize=0;
	oldFontSize= parseInt(oldFontSize)+ ((fontvar>1)?1:-1);
	if (skipCookie!==true)
		setCookie('fontSize', oldFontSize, 360);
    jQuery('*').each(function(){
        var currentFont =jQuery(this).css('font-size');
        jQuery(this).css({'font-size': (parseFloat(currentFont) * parseFloat(fontvar)) + "px"});
    });
}

function setCookie(cname, cvalue, exdays) {
    var d = new Date();
    d.setTime(d.getTime() + (exdays*24*60*60*1000));
    var expires = "expires="+d.toUTCString();
    document.cookie = cname + "=" + cvalue + "; " + expires+ ";path=/";
} 

function getCookie(cname) {
    var name = cname + "=";
    var ca = document.cookie.split(';');
    for(var i=0; i<ca.length; i++) {
        var c = ca[i];
        while (c.charAt(0)==' ') c = c.substring(1);
        if (c.indexOf(name) == 0) return c.substring(name.length,c.length);
    }
    return "";
}

function getValueBackgroundCookie(bname){
	var oldBackgroundStyle = getCookie(bname);
	console.log(oldBackgroundStyle);
	return oldBackgroundStyle;
}

function changeValueBackgroundCookie(bname, contrast){
		setCookie(bname, contrast, 360);
		$("body").removeClass("black");
}

function setBackground(){
	if (getCookie('backgroundCookie') == '1'){ 
		$("body").addClass("black");
		HighContrastOn();
	}
	if (getCookie('backgroundCookie') == '0'){ 
		$("body").removeClass("black");
		//HighContrastOff();
	}
}

$(document).on('click', ".fontNContrast", function() {
	changeValueBackgroundCookie('backgroundCookie', '0');
	setBackground();
});

$(document).on('click', ".fontWBContrast", function() {
	changeValueBackgroundCookie('backgroundCookie', '1');
	setBackground();
});

function setContrast(){
    if (getCookie('backgroundCookie') == ''){
        setCookie('backgroundCookie', 0, 360);
    }
    setBackground();
    //alert(getValueBackgroundCookie('backgroundCookie'));

    var oldFontSize = getCookie('fontSize');
    if (oldFontSize != '')
        if (oldFontSize != 0){
            if (oldFontSize > 0)
                for(var i=0; i<=oldFontSize; i++)
                    changeFontSize(1.02, true);
            if (oldFontSize < 0)
                for(var i=0; i>=oldFontSize; i--)
                    changeFontSize(0.98, true);
        }
    var highContrast = getCookie('highContrast');
    if (highContrast != '')
        if (highContrast == 1)
            HighContrastOn();
}

$(document).on('page:load', function(){
	setContrast();
});

$(function(){
    setContrast();
});