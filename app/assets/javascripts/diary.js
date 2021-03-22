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
          loadingHtml: '読み込み中',
          contentSelector: '.scroll-list',
          nextSelector: 'li.next:last a'
        });
      }
    });
  });
});