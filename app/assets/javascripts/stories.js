// highlight and fade background on named anchors
// requires jquery.color.js http://plugins.jquery.com/project/color
function highlight(elemId){
    var elem = $(elemId);
    //alert(elem.parent());
    elem.css("backgroundColor", "#ffffff"); // hack for Safari
    $(".shadow_selected").removeClass("shadow_selected");
    elem.addClass("shadow_selected");
    setTimeout(function(){$(elemId).animate({ backgroundColor: "#ffffff" }, 3000)},1000);
}
   
if (document.location.hash) {
    highlight(document.location.hash);
}

$(document).ready(function() {
   $("[rel=tooltip]").tooltip({container: 'body'});
});

function bookify(elem)
{
	elem.switchPage = function(href) {
		$(".page_inner").each(function(){$(this).slideOut();});
		$.get(href, function(data) {
			$('<div/>', {class: 'page_inner', style: 'left:1000px'})
				.appendTo(elem)
				.html(data)
				.slideIn();
			_replacePageLinks(elem);
		});

	};
	_replacePageLinks(elem);
}

function _replacePageLinks(elem)
{
	$(elem).find('a[href*="pages"]').each(function(i,e) {
		var href = e.href;
		var match = /([0-9]+)#?$/.exec(e.href);
		if(!match)
			return; 
		e.href = "#"+match[1];
		$(e).click(function (event) { 
			event.preventDefault();
			window.location.hash = this.hash;
			elem.switchPage(href); 
			return false; 
		});
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
		).removeClass("popped");
       	return $(this);
   	};
	
	$.fn.slideIn = function(){
		$(this).animate({left: "0px" }, {queue: false, duration: 500}).addClass("popped");
       	return $(this);
	};
})(jQuery);