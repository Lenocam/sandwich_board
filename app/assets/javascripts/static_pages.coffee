# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on "turbolinks:load", ->
  console.log ("DOM is ready.")
  $item = $(".carousel .item")
  $wHeight = $(window).height()

  $item.height $wHeight
  $item.addClass "full-screen"

  $item.eq(0).addClass "active"

  $(".carousel img").each ->
    $src = $(this).attr("src")
    $color = $(this).attr("data-color")
    $(this).parent().css
      "background-image": "url(" + $src + ")"
      "background-color": $color
    $(this).remove()
    return
  $(window).on "resize", ->
    $wHeight = $(window).height()
    $item.height $wHeight
    return

  $(".carousel").carousel
    interval: 6000
    pause: "false"


  $(".forms #signup p").on "click", ->
    $("#signup").removeClass("active-form").addClass("inactive-form")
    $("#login").addClass("active-form").removeClass("inactive-form")

  $(".forms #login p").on "click", ->
    $("#signup").addClass("active-form").removeClass("inactive-form")
    $("#login").removeClass("active-form").addClass("inactive-form")
return
