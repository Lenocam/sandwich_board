$(document).on "turbolinks:load", ->
		#StartTime Date Picker
		$('#datetimepicker').datetimepicker({
				"format": "YYYY/MM/DD H:mm"
				});
		#EndtTime Date Picker
		$('#datetimepicker1').datetimepicker({
				"format": "YYYY/MM/DD H:mm"
				});

		#Disables Start Date until Checked
		$('#datetimepicker').data("DateTimePicker").disable();

		$('input#awakeStartSelect').change((e) ->
				if this.checked
						$('#datetimepicker').data("DateTimePicker").enable();
				else
						$('#datetimepicker').data("DateTimePicker").disable();
		)

		#Disables End Date until Checked
		$('#datetimepicker1').data("DateTimePicker").disable();

		$('input#awakeEndSelect').change((e) ->
				if this.checked
						$('#datetimepicker1').data("DateTimePicker").enable();
				else
						$('#datetimepicker1').data("DateTimePicker").disable();
		)
