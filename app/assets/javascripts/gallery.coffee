$(document).on "turbolinks:load", ->
	$('.flex-images').flexImages rowHeight: 250
	$('.flex-images').flexImages maxRows: 1

	$('#gallery_category_ids').chosen({
		no_results_text: "No reult found. Press enter to add..."
		search_contains: true,
		});
