jQuery ->
  $(document).on 'click', "#employees th a, #employees .pagination a, #posts .pagination a", (event) ->
    $.getScript this.href
    false

  $("#employees_search input").keyup ->
    $.get $("#employees_search").attr("action"), 
      $("#employees_search").serialize() + "&" + $.param status: $("#employees_status").val(),
      null, 
      "script"
    false

  $("#employees_status").on 'change', (evevnt) ->
    data = $.param status: this.value if this.value?
    $.getScript '/employees?' + data
    false
