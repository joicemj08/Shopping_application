$(function () {
    $("#submit_button").click(function() {
      var email =  $("#user_email").val();
        $.ajax({
            url: '/check',
            type: 'GET',
            dataType: 'json',
            data: {
            'search': email
            },
            success: function(data){
              if (!data)
               $("#new_user").submit();
              else
                $('#error').html("* email already exists");
            }
        });
        return false;
    });
});

