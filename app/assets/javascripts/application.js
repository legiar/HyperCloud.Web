//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require_tree .

$(document).ready(function () {
	// Message box fading
	$(".close-yellow").click(function() {
		$("#message-yellow").fadeOut("slow");
	});
	$(".close-red").click(function() {
		$("#message-red").fadeOut("slow");
	});
	$(".close-blue").click(function() {
		$("#message-blue").fadeOut("slow");
	});
	$(".close-green").click(function() {
		$("#message-green").fadeOut("slow");
	});
  
	// Table row background color changes on rollover
	$('#product-table tr').hover(
		function() {
			$(this).addClass('activity-blue');
		},
		function() {
			$(this).removeClass('activity-blue');
		}
	);
  
	// TODO: Add prepend inline-error div (for graphics)
	$("p.inline-errors").before('<p class="inline-errors-left">&nbsp;</p>');

	$("select").combobox();
	$('input[type=checkbox]').checkbox('toggle');
	
	$(".sortable").sortable({
		items: "tr.queue_job:not(.active)",
		axis: "y",
		cursor: "move",
		opacity: "0.7",
		placeholder: "reorder-placeholder",
		forcePlaceholderSize: true,
		helper: function(e, ui) {
			var $originals = ui.children();
			var $helper = ui.clone();
			$helper.children().each(function(index)
			{
				// Set helper cell sizes to match the original sizes
				$(this).width($originals.eq(index).width())
			});
			return $helper;			
		},
		start: function(event, ui) {
			var $column_count = ui.item.find("td").size();
			ui.placeholder.append("<td colspan='" + $column_count + "'></td>");
		},
		update: function() {
			var url = $(this).attr("data-reorder-url");
			var keys = $(this).sortable("serialize", {key: "ids[]"})
			$.post(url, keys + "&csrf-token=" + $("meta[name=csrf-token]").attr("content"));
		}
	}).disableSelection();
});

