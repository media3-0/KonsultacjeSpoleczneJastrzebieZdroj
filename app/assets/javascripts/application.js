// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require scrollReveal
//= require cookies
//= require autosize
//= require animatescroll
//= require scripts
//= require turbolinks

function updateComment(commentsCount, name, ago, content, commentId){
    $('#addmaincomment').remove();
    $('.commentscount').text(commentsCount);
    $('#whoandago').html("<strong>"+ name +"</strong> "+ ago +" - temu");
    $('#commenttext').html(content); //TODO : walka z enterami
    $('#gotocomment').attr('onclick', "$('#comment_'" + commentId + ").animatescroll();");
    $('#mycomment').show();
    $('#commentloadingbox').hide();
}

function onNavigate(){
    console.log('test');
}

function initSubcomments(){
    $('.subcommentForm').on("ajax:complete", function(xhr, status){
        if(status.status == "404") {
            alert(status.responseText);
        }else{
            $(status.responseText).insertBefore($(this).parent().parent());
            $(this).find('.inputPost').val('');
        }
        var id = this.id.split('_')[1];
        $('#subcommentloadingbox_' + id).hide();
        $('#subcommentForm_' + id).show();
        $(this).find('.inputPost').focus();
    }).on("ajax:before", function(){
        var id = this.id.split('_')[1];
        $('#subcommentloadingbox_' + id).show();
        $('#subcommentForm_' + id).hide();
    });
}

function initializeEvents(){
    $('.replyToComment').on("ajax:success", function(e, data){
        var id = this.id.split('_')[1];
        $('#commentloadingbox_' + id).remove();
        $(data).insertAfter("#comment_" + id)
        if($(this).hasClass("instantReply")){
            $('#subcommentInput_' + id).focus();
        }
        $(this).parent().find('.replyToComment').remove();
        textareafix();
        initSubcomments();
    }).on("ajax:before", function(e, data){
        var id = this.id.split('_')[1];
        $('#commentloadingbox_' + id).show();
    });

    $('#addmaincommentform').on("ajax:before", function(){
        $('#addmaincomment').hide();
        $('#commentloadingbox').show();
    });
}

//TODO : ładowanie ajax