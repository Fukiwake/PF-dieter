$(function(){
  $(document).on('turbolinks:load', function() {
    $('#meil-login-btn').click(function() {
      $('.new-registration-form').slideToggle("fast");
    });

    $(".unfollow-button").mouseover(function() {
      $(this).removeClass("btn-danger")
      $(this).css({"background-color": "red", "color": "white"})
      $(this).text("フォロー解除")
    });

    $(".unfollow-button").mouseout(function() {
      $(this).addClass("btn-danger")
      $(this).css({"background-color": "", "color": ""})
      $(this).text("フォロー中")
    });

    $('#customer-tab-contents .tab[id != "diary"]').hide();

    $('#customer-tab-menu a').on('click', function(event) {
      $("#customer-tab-contents .tab").hide();
      $("#customer-tab-menu .btn-danger").addClass("btn-outline-secondary");
      $("#customer-tab-menu .btn-danger").removeClass("btn-danger");
      $(this).removeClass("btn-outline-secondary");
      $(this).addClass("btn-danger");
      $($(this).attr("href")).show();
      event.preventDefault();
    });

    $('#info-tab-contents .tab[id != "graph"]').hide();

    $('#info-tab-menu input').on('click', function(event) {
      $("#info-tab-contents .tab").hide();
      $($(this).attr("value")).show();
      document.$(this).checked = true;
      event.preventDefault();
    });
  });
});