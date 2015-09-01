function validateForm(){
    var offer = $('#offer_avatar').val();
    flag = 0;
    $("#error").html (' ');
    if (offer.length == "" ){
      $("#error").append("<br>* Image is mandatory ");
      flag = 1;
    }
    if (flag == 0)
      $("#new_offer").submit();
}
