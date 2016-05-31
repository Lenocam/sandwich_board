# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
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

  console.log ("Check me out")
  console.log ("Working here too.")
  $(".forms p").on "click", ->
    console.log("Hey it worked everybody!!")
    $("#signup").toggleClass("active-form").toggleClass("inactive-form")
    $("#login").toggleClass("active-form").toggleClass("inactive-form")
return
