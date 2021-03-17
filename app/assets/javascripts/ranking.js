$(function() {
  $(document).on('turbolinks:load', function() {
    $('#ranking-tab-contents .tab[id != "day"]').hide();

    $('#ranking-tab-menu a').on('click', function(event) {
      $("#ranking-tab-contents .tab").hide();
      $("#ranking-tab-menu .btn-danger").addClass("btn-outline-secondary");
      $("#ranking-tab-menu .btn-danger").removeClass("btn-danger");
      $(this).removeClass("btn-outline-secondary");
      $(this).addClass("btn-danger");
      $($(this).attr("href")).show();
      event.preventDefault();
    });
  });
});