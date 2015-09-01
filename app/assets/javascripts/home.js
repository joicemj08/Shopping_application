// This is a manifest file that'll be compiled into home.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require turbolinks
//= require bootstrap.min
//= require jquery.flexslider-min

$(function () {
    $("#signup").click(function() {
        $.ajax({
            url: '/validate',
            type: 'POST',
            dataType: 'json',
            data: $("#new_user").serialize(),
            success: function(data){
                if(data.success == true){
                    alert("you have successfully registered.You will recieve a confirmation mail soon");
                    $('#myModal').modal('toggle');
                }
                var errors = "";
                for(var i=0; i<data.error.length; i++){
                    errors += '<br>*'+ data.error[i] ;
                }
                $('#error').html(errors);
            }
        });
    });
    $('.modal').on('hidden.bs.modal', function(){
        $(this).find('form')[0].reset();
    });
});