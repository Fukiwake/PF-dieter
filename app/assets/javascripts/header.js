$(function () {
  $(document).on('turbolinks:load', function() {

    $('[data-toggle="tooltip"]').tooltip({placement:'bottom'})

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

    if(location.pathname != "/" && location.pathname.split("/")[2]) {
      $('.navbar-nav a[href^="/' + location.pathname.split("/")[1] + "/" + location.pathname.split("/")[2] + '"]').addClass('text-danger');
    } else {
      $('.navbar-nav a[href="/' + location.pathname.split("/")[1] + '"]').addClass('text-danger');
    }

  });
});