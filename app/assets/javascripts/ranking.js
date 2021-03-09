$(function() {
  $(document).on('turbolinks:load', function() {
    $('#ranking-tab-contents .tab[id != "day"]').hide();
  
    $('#ranking-tab-menu a').on('click', function(event) {
      $("#ranking-tab-contents .tab").hide();
      $("#ranking-tab-menu .active").removeClass("active");
      $(this).addClass("active");
      $(".range").text($(this).text());
      $($(this).attr("href")).show();
      event.preventDefault();
    });
  });
});