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
    var count = $(".cart-items").length;
    $('#cart-total').html(count);
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

    $(".add-cart").unbind().click(function() {
        var id = $(this).attr('product-id');
        var quantity = $(this).next().first().val();
        alert("item added to cart");
        $.ajax({
            url: '/add-cart',
            type: 'GET',
            data: {
                'id': id,
                'quantity' : quantity
            },
            success: function(data){
                $('#myModal1 .modal-body').html(data);
                var count = $(".cart-items").length;
                $('#cart-total').html(count);
            },
            error: function(){
              alert('Error');
            }
        });
    });
    $(".list-cart").unbind().click(function() {
        $.ajax({
            url: '/view-cart',
            type: 'GET',
            success: function(data){
                $('#myModal1 .modal-body').html(data);
                var count = $(".cart-items").length;
                $('#cart-total').html(count);
            },
            error: function(){
              alert('Error');
            }
        });
    });
});

$.widget( "custom.catcomplete", $.ui.autocomplete,{
    _create: function() {
        this._super();
        this.widget().menu( "option", "items", "> :not(.ui-autocomplete-category)" );
    },
    _renderMenu: function( ul, items ) {
        var that = this,
        currentCategory = "";
        $.each( items, function( index, item ) {
            var li;
            if ( item.category != currentCategory ) {
                ul.append( "<li class='autocompleltelist ui-autocomplete-category drop-down'>" + item.category + "</li>" );
                currentCategory = item.category;
            }
            li = that._renderItemData( ul, item );
            if ( item.category ) {
                li.attr( "aria-label", item.category + " : " + item.label );
                li.attr( "data-id", item.id );
                li.attr( "data-category", item.category );
                li.attr( "class", 'autocompletelist')
            }
        });
    }
});


$(window).load(function() {
    $('.flexslider').flexslider();
    $('.flex-next, .flex-prev').empty();
});
$(function () {
    $(".ui-autocomplete-category").on('click', function() {
        alert(1);
    });
    $("#search_text").on('keyup', function() {
    // var search_content =$("#search_text").val();
        $( "#search_text" ).catcomplete({
            delay: 0,
            select: function (e, ui) {
                $.ajax({
                    url: '/search_index',
                    type: 'GET',
                    dataType: 'json',
                    data: {
                        'id': ui.item.id,
                        'category' : ui.item.category
                    },
                    success: function(data){
                        var length = data.length;
                        var products = "";
                        for(var i=0; i<length; i++){
                            products += '<div class="col-lg-3 col-md-3 col-sm-6 col-xs-12"><div class="product-thumb transition" style="height: 250px; overflow:hidden;" >' +
                            '<div class="image">' + '<img src="' + data[i].avatar_url + '">' + '</div>' +
                            '<div class="caption"><h4>' + data[i].name + '<br></h4><p><strong>Category :</strong>'
                            + data[i].category_name + '<br><p class="price">' +
                            '<strong>Price :</strong>' + data[i].unit_price + '<br></p><p class="price">' +
                            '<strong>Quantity Remaining :</strong>' + data[i].quantity +'<br></p></p></div></div></div>';
                        }
                        $('#products-listing').html(products);
                    }
                });
            },
            source: function (request, response) {
                $.ajax({
                    url: '/index',
                    type: 'GET',
                    dataType: 'json',
                    data: {
                    'search': $("#search_text").val()
                    },
                    success: function(data){
                      response(data.products);
                          // $('#product-layout').html(data.html_string);
                    }
                });
            }
        });
    // return false;
    });
});


