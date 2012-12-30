// highlight and fade background on named anchors
// requires jquery.color.js http://plugins.jquery.com/project/color
function highlight(elemId){
    var elem = $(elemId);
    //alert(elem.parent());
    elem.css("backgroundColor", "#ffffff"); // hack for Safari
    $(".shadow_selected").removeClass("shadow_selected");
    elem.siblings("div").addClass("shadow_selected");
    setTimeout(function(){$(elemId).animate({ backgroundColor: "#ffffff" }, 3000)},1000);
}
   
if (document.location.hash) {
    highlight(document.location.hash);
}
$(document).ready(function () {
  $('a[href*=#]').click(function(){
      var elemId = '#' + $(this).attr('href').split('#')[1];
      highlight(elemId);
  });
});