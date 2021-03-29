$(function(){
  $(document).on('turbolinks:load', function() {
    $(document).ready(function() {
      $(".tag_form").tagit({
        tagLimit:10,         // タグの最大数
        singleField: true,   // タグの一意性
        availableTags: gon.available_tags, 　//タグの自動補完
      });
      let tag_count = 10 - $(".tagit-choice").length    // 登録済みのタグを数える
      $(".ui-widget-content.ui-autocomplete-input").attr(
        'placeholder','あと' + tag_count + '個入力できます');
    })

    // タグ入力で、placeholder を変更
    $(document).on("keyup", '.tagit', function() {
      let tag_count = 10 - $(".tagit-choice").length
      $(".ui-widget-content.ui-autocomplete-input").attr(
      'placeholder','あと' + tag_count + '個入力できます');
    });

    $(window).on('scroll', function() {
      scrollHeight = $(document).height();
      scrollPosition = $(window).height() + $(window).scrollTop();
      if ( (scrollHeight - scrollPosition) / scrollHeight <= 0.05) {
        $('.diet-method-scroll-list').jscroll({
          loadingHtml: '<div class="text-center"><img src="/assets/loading-71b831bc52ecef717245e2f57223d1be74a0185546166e78983a4f9c4230d2e8.gif"></div>',
          contentSelector: '.diet-method-scroll-list',
          nextSelector: 'li.next:last a'
        });
      }
    });
  });
});