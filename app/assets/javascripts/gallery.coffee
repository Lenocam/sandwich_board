ready = ->
  $('.flex-images').flexImages rowHeight: 250
  $('.flex-images').flexImages maxRows: 1

$(document).ready ready
$(document).on 'page:load', ready
