// highlight and fade background on named anchors
// requires jquery.color.js http://plugins.jquery.com/project/color
function highlight(elemId) 
{
    var elem = $(elemId);
    //alert(elem.parent());
    elem.css("backgroundColor", "#ffffff"); // hack for Safari
    $(".shadow_selected").removeClass("shadow_selected");
    elem.addClass("shadow_selected");
    setTimeout(function(){$(elemId).animate({ backgroundColor: "#ffffff" }, 3000)},1000);
}
   
if (document.location.hash) 
{
    highlight(document.location.hash);
}

$(document).ready(function() 
{
   $("[rel=tooltip]").tooltip({container: 'body'});
});

function bookify(elem)
{
	window.onhashchange = function ()
   	{
   		//dirty dirty hardcoded route
   		var pageRoute = window.location.href.replace(/\#([0-9]+)$/,"/pages/$1");
   		
   		if(pageRoute.indexOf("pages") != -1) //it is a page request
   		{
   			$(".page_inner").each(function(){$(this).slideOut();});
   			
			$('<div/>', {class: 'page_inner', style: 'left:1000px'})
				.appendTo(elem)
				.load(pageRoute, function() {
					_replacePageLinks(elem);
					$(this).slideIn();
				});
		} else {
			window.location = window.location.href;
		}
	};
	elem.switchPage = function(href) {
	};
	_replacePageLinks(elem);
	if(window.location.href.indexOf("pages") != -1 || window.location.href.indexOf("#") != -1) //it is a page request
   	{
		window.onhashchange();
	}
}

function _replacePageLinks(elem)
{
	$(elem).find('a[href*="pages"]').each(function(i,e) {
		var href = e.href;
		var match = /([0-9]+)#?$/.exec(e.href);
		if(!match)
			return; 
		e.href = "#"+match[1];
		// $(e).click(function (event) { 
		// 	event.preventDefault();
		// 	window.location.hash = this.hash;
		// 	elem.switchPage(href); 
		// 	return false; 
		//});
	});
}

(function($) {
	$.fn.slideOut = function(){
		$(this).animate({left:'-1000px'}, 
			{
				queue: false, 
				duration: 500,
				"complete": function() { $(this).remove(); }
			}
		);//.removeClass("popped");
       	return $(this);
   	};
	
	$.fn.slideIn = function(){
		$(this).animate({left: "0px" }, {queue: false, duration: 500}).addClass("popped");
       	return $(this);
	};
})(jQuery);