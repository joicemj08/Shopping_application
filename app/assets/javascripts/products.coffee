# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$('#products_search').submit( ->
    $.get(this.action, $(this).serialize(), null, 'script')
    false
  )
  # Ajax search on keyup
  $('#products_search input').keyup( ->
    $.get($("#products_search").attr("action"), $("#products_search").serialize(), null, 'script')
    false