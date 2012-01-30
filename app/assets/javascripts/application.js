//= require jquery
//= require jquery_ujs
//= require_tree .

$(function(){
	// Top scroll
	$().UItoTop();
	
	// UniForm
	$("select, input:checkbox, input:radio, input:file").uniform();

	// Main navigation
	//$('.nav-main-subnav').adminMenu();
	
	// jQuery Custom File Input
	//$('.fileupload').customFileInput();
	
	// jQuery DateInput
	$('.datepicker').after('<span class="datepicker-icon">&nbsp;</span>').datepick({ pickerClass: 'jq-datepicker' });

	// Auto highlight mandatory inputs
	$('<span> *</span>').appendTo('.mandatory');
	
	// jQuery Tipsy
	$('.tooltip, .loading').tipsy({gravity:'s', fade:true}); // Tooltip Gravity Orientation: n | w | e | s
	$('.tooltip-wide').tipsy({gravity:'e', fade:true}); // Tooltip Gravity Orientation: n | w | e | s
	
	// Check all checkboxes
	$('.check-all').click(
		function(){
			$(this).parents('form').find('input:checkbox').attr('checked', $(this).is(':checked'));
		}
	)
	
	// Minimize Content Article
	$('.minimizer header').each(function() {
		var h2Width = $(this).find('h2').width();
		$(this).append('<a href="#" class="content-box-minimizer" title="Toggle Content Block">Toggle</a>'); // Add minimizer iocn 
		$(this).find('.content-box-minimizer').css({'display':'block', 'left':h2Width+35}).parent().find('h2').css({'padding-right':'90px'}); // Change style for minimizer
	});
	$('.minimizer .content-box-minimizer').click( // On click toggle content window and add class 'toggled'
		function () {
			$(this).toggleClass('toggled');
			$(this).parent().find('nav').toggle();
			$(this).parent().parent().toggleClass('toggled').find('section, footer').toggle();
			return false;
		}
	);
	
	// Notifications
	$('.notification-details').hide(); // Hide notification details
	$('.show-notification-details').click( //On click toggle notification details
		function () {
			$(this).next('.notification-details').slideToggle();
			return false;
		}
	);
	$('.close-notification').click( // On click slide up notification
		function () {
			$(this).parent().fadeTo(350, 0, function () {$(this).slideUp(600);});
			return false;
		}
	);
	
	// Targeting Opera 11 and older Opera browsers
	if (window.opera && window.opera.version() < 12) {
		document.documentElement.className += ' opera11';
	};
	
	// Content box tabs and sidetabs
	$('.tab, .sidetab').hide(); // Hide the content divs
	$('.tab.default, .default-sidetab').show(); // Show the div with class 'default-tab'
	$('nav .tabs a.default, .sidetab-switch a.default-sidetab').addClass('current'); // Set the class of the default tab link to 'current'

	if(window.location.hash && window.location.hash.match(/^#tab\d+$/)) { // Check for tab Hash ID, if exist opens corresponding tab
		var tabID = window.location.hash; // Set variable tabID to the value of URL Hash
		
		$('nav .tabs a[href='+tabID+']').addClass('current').parent().siblings().find('a').removeClass('current'); // Find corresponding link and set is as current
		$('div'+tabID).parent().find('.tab').hide(); // Hide all content divs
		$('div'+tabID).show(); // Show the content div with the id equal to the id of URL Hash
		//$('div'+tabID).find('.visualize').trigger('visualizeRefresh');; // Refresh jQuery Visualize
		//$('.fullcalendar').fullCalendar('render'); // Refresh jQuery FullCalendar
		
	} else if (window.location.hash && window.location.hash.match(/^#sidetab\d+$/)) { // Check for sidetab Hash ID, if exist opens corresponding sidetab
		var sidetabID = window.location.hash;// Set variable sidetabID to the value of URL Hash
		
		$('.sidetab-switch a[href='+sidetabID+']').addClass('current'); // Find corresponding link and set is as current
		$('div'+sidetabID).parent().find('.sidetab').hide(); // Hide all content divs
		$('div'+sidetabID).show(); // Show the content div with the id equal to the id of URL Hash
		$('div'+sidetabID).find('.visualize').trigger('visualizeRefresh'); // Refresh jQuery Visualize
		//$('.fullcalendar').fullCalendar('render'); // Refresh jQuery FullCalendar
	}
	
	$('nav .tabs a').click(
		function() { 
			var tab = $(this).attr('href'); // Set variable 'tab' to the value of href of clicked tab
			$(this).parent().siblings().find('a').removeClass('current'); // Remove 'current' class from all tabs
			$(this).addClass('current'); // Add class 'current' to clicked tab
			$(tab).siblings('.tab').hide(); // Hide all content divs
			$(tab).show(); // Show the content div with the id equal to the id of clicked tab
			//$(tab).find('.visualize').trigger('visualizeRefresh'); // Refresh jQuery Visualize
			//$('.fullcalendar').fullCalendar('render'); // Refresh jQuery FullCalendar
			return false;
		}
	);

	$('.sidetab-switch a').click(
		function() { 
			var sidetab = $(this).attr('href'); // Set variable 'sidetab' to the value of href of clicked sidetab
			$(this).parent().siblings().find('a').removeClass('current'); // Remove 'current' class from all sidetabs
			$(this).addClass('current'); // Add class 'current' to clicked sidetab
			$(sidetab).siblings('.sidetab').hide(); // Hide all content divs
			$(sidetab).show(); // Show the content div with the id equal to the id of clicked tab
			//$(sidetab).find('.visualize').trigger('visualizeRefresh'); // Refresh jQuery Visualize
			//$('.fullcalendar').fullCalendar('render'); // Refresh jQuery FullCalendar
			return false;
		}
	);
	
	// Tickets
	$('.tickets .ticket-details').hide(); // Hide all ticket details
	$('.tickets .ticket-open-details').click( // On click hide all ticket details content and open clicked one
		function() {
			//$('.tickets .ticket-details').slideUp()
			$(this).parent().parent().parent().parent().siblings().find('.ticket-details').slideUp(); // Hide all ticket details expect the one clicked
			$(this).parent().parent().parent().parent().find('.ticket-details').slideToggle();
			return false;
		}
	);
	
	// Table actions
	var optWidth = $('.table-switch').outerWidth();
	var btnWidth = $('.toggle-table-switch').outerWidth();
	$('.table-switch').hide().css({ 'margin-left':-(optWidth-btnWidth)/2 });
	$('.ie7 .table-switch').css({ 'margin-left':-btnWidth+3 }); // Don't ask why...
	
	$(document).on('click', '.toggle-table-switch', function() { 
		$(this).parent().parent().siblings().find('.toggle-table-switch').removeClass('active').next().slideUp(); // Hide all menus expect the one clicked
		$(this).toggleClass('active').next().slideToggle(); // Toggle clicked menu
		$(document).click(function() { // Hide menu when clicked outside of it
			$('.table-switch').slideUp();
			$('.toggle-table-switch').removeClass('active')
		});
		return false;
	});
	
	// Content Header Options
	var optWidth = $('.options-switch').width();
	var btnWidth = $('.toggle-options-switch').width();
	$('.options-switch').hide().css({ 'margin-left':-(optWidth-btnWidth)/2 });
	$(document).on('click', '.toggle-options-switch', function() {
		$(this).parent().parent().parent().siblings().find('.toggle-options-switch').removeClass('active').next().slideUp(); // Hide all menus expect the one clicked
		$(this).toggleClass('active').next().slideToggle(); // Toggle clicked menu
		$(document).click(function() { // Hide menu when clicked outside of it
			$('.options-switch').slideUp();
			$('.toggle-options-switch').removeClass('active')
		});
		return false;
	});
	
	var datatables = {}
	$("table.datatable").each(function(){
		var table = $(this);
		var table_id = table.attr("id");
		options = {
			bAutoWidth: true,
			bStateSave: true,
			sPaginationType: "full_numbers",
			aoColumnDefs: [],
			aoColumns: [], 
			aaSorting: [[0, "asc"]]
		}
		if (table.data("remote") !== undefined) {
			options.sAjaxSource = table.data('remote');
			options.bServerSide = true
			options.fnServerData = simpleDatatables
		}
		var col_index = 0;
		table.find("thead th").each(function(){
			var th = $(this);
			var col = {
				sName: th.data("member"),
				bSortable: th.attr("sort") != undefined,
				bSearchable: th.attr("filter") != undefined 
			}
			var col_def = {
				aTargets: [col_index]
			}
			if (th.attr("type") == "link") {
				col_def.fnRender = function(oObj) {
					if (th.attr("link") != undefined) {
						var url = th.attr("link").replace(/:id/i, oObj.aData["DT_RowId"].match(/\d+$/)[0]);
						return '<a href="' + url + '">' + oObj.aData[oObj.iDataColumn] + '</a>';    
					} else {
						return oObj.aData[oObj.iDataColumn];
					}
				}
			}
			options.aoColumns.push(col);
			options.aoColumnDefs.push(col_def);
			col_index++;
		});
		table.find("tbody").click(function(event) {
			var table = $(this).closest("table");
			var table_id = table.attr("id");
			table = datatables[table_id];
			if (table != null) {
				$(table.fnSettings().aoData).each(function(){
            		$(this.nTr).removeClass('row_selected');
        		});
        		$(event.target.parentNode).addClass('row_selected');
        	}			
        });
       	console.log(options);
		datatables[table_id] = table.dataTable(options);
		$("#" + table_id + "_wrapper select").uniform(); 
	});
});	
