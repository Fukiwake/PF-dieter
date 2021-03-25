$(function(){
  $(document).on('turbolinks:load', function() {
    $('.images-wrapper').slick({
      dots: true,
      arrows: true,
    });

    $(".abort-button").mouseover(function() {
      $(this).removeClass("btn-danger")
      $(this).css({"background-color": "red", "color": "white"})
      $(this).text("やめる")
    });

    $(".abort-button").mouseout(function() {
      $(this).addClass("btn-danger")
      $(this).css({"background-color": "", "color": ""})
      $(this).text("実践中")
    });

    $(window).on('scroll', function() {
      scrollHeight = $(document).height();
      scrollPosition = $(window).height() + $(window).scrollTop();
      if ( (scrollHeight - scrollPosition) / scrollHeight <= 0.05) {
        $('.jscroll').jscroll({
          loadingHtml: '<div class="text-center"><img src="/assets/loading-71b831bc52ecef717245e2f57223d1be74a0185546166e78983a4f9c4230d2e8.gif"></div>',
          contentSelector: '.scroll-list',
          nextSelector: 'li.next:last a'
        });
      }
    });
  });
});