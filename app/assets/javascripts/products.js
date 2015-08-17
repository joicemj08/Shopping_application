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