

  $('#products_search input').keyup( ->
    $.get($("#products_search").attr("action"), $("#products_search").serialize(), null, 'script')
    false
  )