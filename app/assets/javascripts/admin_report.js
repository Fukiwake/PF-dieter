$(function() {
  $(document).on('turbolinks:load', function() {
    $('#report-tab-contents .tab[id != "diary"]').hide();


    $('#report-tab-menu a').on('click', function(event) {
      $("#report-tab-contents .tab").hide();
      $("#report-tab-menu .btn-danger").addClass("btn-outline-secondary");
      $("#report-tab-menu .btn-danger").removeClass("btn-danger");
      $(this).removeClass("btn-outline-secondary");
      $(this).addClass("btn-danger");
      $($(this).attr("href")).show();
      event.preventDefault();
    });
  });
});