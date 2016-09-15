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
		if $('#datetimepicker').data("DateTimePicker")
			if $('#datetimepicker').data("DateTimePicker").date() != null
				$('#datetimepicker').data("DateTimePicker").enable();
				$('input#awakeStartSelect').prop("checked", true)
			else
				$('#datetimepicker').data("DateTimePicker").disable();

		$('input#awakeStartSelect').change((e) ->
				if this.checked
						$('#datetimepicker').data("DateTimePicker").enable();
				else
						$('#datetimepicker').data("DateTimePicker").disable();
		)

		#Disables End Date until Checked
		if $('#datetimepicker1').data("DateTimePicker")
			if $('#datetimepicker1').data("DateTimePicker").date() != null
				$('#datetimepicker1').data("DateTimePicker").enable();
				$('input#awakeEndSelect').prop("checked", true);
			else
				$('#datetimepicker1').data("DateTimePicker").disable();

		$('input#awakeEndSelect').change((e) ->
				if this.checked
						$('#datetimepicker1').data("DateTimePicker").enable();
				else
						$('#datetimepicker1').data("DateTimePicker").disable();
		)

		$('#image_category_ids').chosen({
			no_results_text: "No result found. Press enter to add..."
			search_contains: true
			});
