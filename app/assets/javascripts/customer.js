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

    $('#info-tab-menu input').on('click', function(event) {
      $("#info-tab-contents .tab").removeClass('active');
      $($(this).attr("value")).addClass('active');
      document.$(this).checked = true;
      event.preventDefault();
    });

    $('#slideDownSearchButton').click(function() {
      $('#slideDownSearchForm').slideToggle("fast");
    });

    $(window).on('scroll', function() {
      scrollHeight = $(document).height();
      scrollPosition = $(window).height() + $(window).scrollTop();
      if ( (scrollHeight - scrollPosition) / scrollHeight <= 0.05) {
        $('.customer-scroll-list').jscroll({
          loadingHtml: '<div class="text-center"><img src="/assets/loading-71b831bc52ecef717245e2f57223d1be74a0185546166e78983a4f9c4230d2e8.gif"></div>',
          contentSelector: '.customer-scroll-list',
          nextSelector: 'li.next:last a'
        });
      }
    });
  });
});