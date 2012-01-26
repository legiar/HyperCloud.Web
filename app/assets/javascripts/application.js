//= require jquery
//= require jquery_ujs
//= require_tree .

$(function(){
	// Top scroll
	$().UItoTop();

	// Main navigation
	$('.nav-main-subnav').adminMenu();
	
	// jQuery dataTables
	$('.datatable').dataTable({
		'bAutoWidth': true,
		'bDeferRender': false,
		'bFilter': false,
		'bInfo': false,
		'bJQueryUI': false,
		'bLengthChange': false,		
		'bPaginate': true,
		'bProcessing': false,
		'bScrollInfinite': false,
		'bSort': true,
		//'bSortClasses': '',
		'bStateSave': false,
		'sPaginationType': 'full_numbers'
	});
	
	// jQuery Custom File Input
	$('.fileupload').customFileInput();
	
	// jQuery DateInput
	$('.datepicker').after('<span class="datepicker-icon">&nbsp;</span>').datepick({ pickerClass: 'jq-datepicker' });
	
	// IE7 doesn't support :disabled
	$('.ie7').find(':disabled').addClass('disabled');

	// Auto highlight mandatory inputs
	$('<span> *</span>').appendTo('.mandatory');
	
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
	
	// Content Header Options
	var optWidth = $('.options-switch').width();
	var btnWidth = $('.toggle-options-switch').width();
	$('.options-switch').hide().css({ 'margin-left':-(optWidth-btnWidth)/2 });
	$('.toggle-options-switch').click(
		function () {
			$(this).parent().parent().parent().siblings().find('.toggle-options-switch').removeClass('active').next().slideUp(); // Hide all menus expect the one clicked
			$(this).toggleClass('active').next().slideToggle(); // Toggle clicked menu
			$(document).click(function() { // Hide menu when clicked outside of it
				$('.options-switch').slideUp();
				$('.toggle-options-switch').removeClass('active')
			});
			return false;
		}
	);
	
	/*$('#sites').dataTable({
		'bProcessing': true,
		'bServerSide': true,
		'bLengthChange': false,
		'sAjaxSource': '/sites',
		'sAjaxDataProp': '',
		'aoColumns': [
      		{"mDataProp": "name"}
    	],
    	'fnServerParams': function(aoData) {
    		//aoData.push( { "name": "more_data", "value": "my_value" } );
    	},
		'fnServerData': function(sSource, aoData, fnCallback) {
			$.ajax({
                'dataType': 'json', 
                'type': 'GET', 
                'url': sSource, 
                'data': aoData, 
                'success': fnCallback
            });
		}		
	});*/
});	
