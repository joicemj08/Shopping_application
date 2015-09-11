function validateForm(){
      var name = $('#category_name').val();
      var code = $('#category_code').val();
      flag = 0;
      $("#error").html (' ');
      if (name.length <=3 ){
        $("#error").append("<br>* Name is too short (minimum is 3 characters) ");
        flag = 1;
      }
      if (code.length <=3 ){
        $("#error").append("<br>* Code is too short (minimum is 3 characters) ");
        flag = 1;
      }
      if (flag == 0)
        $(".form-submit form").submit();
    }

$(function () {
    $("#search_button").click(function() {
        var search_content = $("#text").val();
        $.ajax({
          url: '/search',
          method: 'GET',
          dataType: 'json',
          data: {
            'search': search_content
          },
          success: function(data){
            var length = data.length;
            var categories = "";
            for(var i=0; i<length; i++){
              categories += '<tr><td>' + data[i].code + '</td>' +
                            '<td>' + data[i].name + '</td>' +
                            '<td><a href="/categories/' + data[i].id + '">Show</a>' +
                            '<a href="/categories/'+ data[i].id +'">Edit</a>'+
                            '<a data-confirm="Are you sure?" rel="nofollow" data-method="delete"'+
                            ' href="/categories/' + data[i].id + '">Destroy</a></td></tr>';
            }
            $('#categories-tbody').html(categories);
          }
        });
        return false;
      });
  });