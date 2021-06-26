// Bootstrap Required Popover
$(function() {
  $('[data-toggle="popover"]').popover()
})

// Toggle Side Menu Open State
function openMenu() {
  $('body').toggleClass('open');
}

$(document).ready(function() {

  // Close Side Menu on Outside Click
  $('body').click(function(e) {
    if (e.target.id == "sideLink")
      return;
    if ($(e.target).closest('#sideLink').length)
      return;
    if (e.target.id == "sideMenu")
      return;
    if ($(e.target).closest('#sideMenu').length)
      return;
    $('body').removeClass('open');
  });

});
