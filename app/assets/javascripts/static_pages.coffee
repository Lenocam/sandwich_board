# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
	$item = $('.carousel .item')
	$wHeight = $(window).height()

	$item.eq(0).addClass('active');

	$item.height $wHeight
	$item.addClass 'full-screen'

	$('.carousel img').each ->
		$src = $(this).attr('data-color')
		$this.parent().css
			'background-image': 'url(' + src + ')'
			'background-color': $color
		$(this).remove()
		return

	$(window).on 'resize', ->
		$wHeight = $(window).height()
		$item.height $wHeight
		return

	$('.carousel').carousel
		interval: 2000
		pause: 'false'

return
