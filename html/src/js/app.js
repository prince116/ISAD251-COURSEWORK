$(function(){
    
    $('.account__record, .admin__record').click(function(){

        var url = $(this).find('a').attr('href');

        window.location.href = url;

    });

});