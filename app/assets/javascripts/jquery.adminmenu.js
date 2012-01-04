// jQuery Main Navigation Plugin

(function($){

	var actions = {
		init : function () {
					$('#nav-sub').css({height:'0'});
					$('.submenu').hide();
					$('#navigation').click(function(event){
						event.stopPropagation();
					});
					$(document).click(function() {
						if($('#nav-sub').height() === 270) {
							$(this).adminMenu('hide');
						}
					});
					$(this).adminMenu('menu');
				},
		menu : function() {
					$(this).click(function(){
						var status = $('#nav-sub').height();
						
						if(status === 0) {
							$(this).adminMenu('show');
							$(this).adminMenu('submenu');
						}else if(status === 270 && !($(this).hasClass('active'))) {
							$(this).adminMenu('xchc');
							$(this).adminMenu('submenu');
						}else{
							$(this).adminMenu('hide');
						}
						return false;
					});
				},
		show : function() {
					$('#nav-sub').animate({height:'300px'}).animate({height:'270px'},'300');
					$('#nav-main-navigation .small-notification').fadeOut('fast');
					$(this).addClass('active');
				},
		hide : function() {
					$("#nav-sub").animate({height:'300px'}).animate({height:'0'},'250', function(){
						$(this).find('.submenu').hide(); // Fix for IE7, not hiding form elements
						$('#nav-main-navigation .small-notification').fadeIn('fast');
						}
					);
					$('.nav-main-subnav').removeClass('active');
				},
		xchc : function() {
					$('.nav-main-subnav').removeClass('active');
					$(this).addClass('active');
				},
		submenu : function() {
					var submenu = $(this).attr('href');
					$(submenu).siblings('.submenu').hide();
					$(submenu).show(); 
				}
	};
	
	$.fn.adminMenu = function(action) {
		if(actions[action]) {
			return actions[ action ].apply( this, Array.prototype.slice.call( arguments, 1 ));
		}else if( typeof action === 'object' || ! action ) {
			return actions.init.apply( this, arguments );
		}else{
			$.error( 'Action ' +  action + ' does not exist on jQuery.adminMenu' );
		}
	};
	
})(jQuery);