$(function(){
    
    $('.account__record, .admin__record').click(function(){

        var url = $(this).find('a').attr('href');

        window.location.href = url;

    });

    $('.btn-option').click(function(){
        var Val = $(this).attr('data-value');

        if( Val == "eathere" ){
            $('.table-selection').show();
        } else {
            $('.table-selection').hide();
        }

        $('.btn-submit').removeAttr('disabled');
    });



});