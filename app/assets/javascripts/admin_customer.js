$(function() {
  $(document).on('turbolinks:load', function() {
    $('#admin_customer-tab-contents .tab[id != "diary"]').hide();

    $('#admin_customer-tab-menu a').on('click', function(event) {
      $("#admin_customer-tab-contents .tab").hide();
      $("#admin_customer-tab-menu .btn-danger").addClass("btn-outline-secondary");
      $("#admin_customer-tab-menu .btn-danger").removeClass("btn-danger");
      $(this).removeClass("btn-outline-secondary");
      $(this).addClass("btn-danger");
      $($(this).attr("href")).show();
      event.preventDefault();
    });

    $('#check-all').on("change", function(){
      if( $(this).prop('checked') ){
        $('input').prop("checked", true);
      } else {
        $('input').prop("checked", false);
      }
    });
  });
});