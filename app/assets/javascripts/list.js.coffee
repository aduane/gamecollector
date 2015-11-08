$ ->
  $("table.tablesorter").tablesorter({
    theme: "bootstrap",
    widthFixed: true,
    headerTemplate : '{content} {icon}',
    widgets : [ "uitheme" ],
    headers: {
        3: {
            sorter: false
          }
      }
  });

  $("select#platform").on("change", ->
    $(this).closest('form').submit()
  )
  $('#share-link').popover({html: true})
