$(function () {
  
  $('[data-toggle="tooltip"]').tooltip()
  
  $("#bell-button").on("click", function() {
    $(".header-notification").show();
    $("#bell-button").hide();
    $("#up-button").show();
  });

  $(document).on('click',function(e) {
    if(!$(e.target).closest('#bell-button, .header-notification').length) {
      $(".header-notification").hide();
      $("#bell-button").show();
      $("#up-button").hide();
    }
  });
})