#Flex Images for Dashboard

$(document).on "turbolinks:load", ->
  $('.flex-images').flexImages rowHeight: 250
  $('.flex-images').flexImages maxRows: 1
