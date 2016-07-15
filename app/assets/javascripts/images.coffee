#StartTime Date Picker

$(document).on "turbolinks:load", ->
	$('#datetimepicker').datetimepicker()
	$('#datetimepicker1').datetimepicker()

###
$(document).on 'ready page:change', ->
	$('.datepicker').datetimepicker pickTime: false
	return
$(document).on 'ready page:change', ->
	$('.datetimepicker').datetimepicker pickSeconds: false
	return
$(document).on 'ready page:change', ->
	$('.timepicker').datetimepicker
		pickDate: false
		pickSeconds: false
	return
###
