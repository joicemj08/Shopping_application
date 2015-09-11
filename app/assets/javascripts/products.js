$(function () {
    $("#search_button").click(function() {
        var search_content = $("#text").val();
        $.ajax({
            url: '/products.json',
            type: 'GET',
            dataType: 'json',
            data: {
            'search': search_content
            },
            success: function(data){
                $('#products_div').html(data.html_string);
            }
        });
        return false;
    });
});

function validateForm(){
    var name = $('#product_name').val();
    var unitprice = $('#product_unit_price').val();
    var quantity = $('#product_quantity').val();
    var check_unitprice = isNaN(unitprice)
    var check_quantity = isNaN(quantity)
    flag = 0;
    $("#error").html (' ');
    if (name.length <=3 ){
        $("#error").append("<br>* Code is too short (minimum is 3 characters) ");
        flag = 1;
    }
    if (check_unitprice){
        $("#error").append("<br>* Unit price should be a number");
        flag = 1;
    }
    else if(unitprice.length == 0){
        $("#error").append("<br>* Unit price shoud not be blank");
        flag = 1;
    }
    if (check_quantity){
        $("#error").append("<br>* Quantity should be a number");
        flag = 1;
    }
    else if (quantity.length == 0){
        $("#error").append("<br>* Quantity shoud not be blank");
        flag = 1;
    }
    if (flag == 0)
        $(".form-submit form").submit();
}

