
    var count = $(".cart-items").length;
    $('#cart-total').html(count);
    $(".checkout").click(function() {
        $.ajax({
            url: '/purchase',
            type: 'GET',
            success: function(data){
                $('#myModal1 .modal-body').html(data);
            },
            error: function(){
              alert('Error');
            }
        });
    });
    $(".remove").click(function() {
        var id = $(this).attr('id');
        $.ajax({
            url: '/remove_cart',
            type: 'GET',
            data: {
                'index': id,
            },
            success: function(data){
                $('#myModal1 .modal-body').html(data);
            },
            error: function(){
              alert('Error');
            }
        });
    });

});