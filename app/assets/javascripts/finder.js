$(function() {
  $(document).on('turbolinks:load', function() {
    var url = location.href.split("model")[1];
    if (url) {
      if (url.includes("customer")) {
        $('#finder-tab-contents .tab[id != "customer"]').hide();
        $("#finder-tab-menu .btn-danger").addClass("btn-outline-secondary");
        $("#finder-tab-menu .btn-danger").removeClass("btn-danger");
        $('#finder-tab-menu a').eq(2).removeClass("btn-outline-secondary");
        $('#finder-tab-menu a').eq(2).addClass("btn-danger");
      } else if (url.includes("method")) {
        $('#finder-tab-contents .tab[id != "method"]').hide();
        $("#finder-tab-menu .btn-danger").addClass("btn-outline-secondary");
        $("#finder-tab-menu .btn-danger").removeClass("btn-danger");
        $('#finder-tab-menu a').eq(1).removeClass("btn-outline-secondary");
        $('#finder-tab-menu a').eq(1).addClass("btn-danger");
      }
    } else {
      $('#finder-tab-contents .tab[id != "diary"]').hide();
    }


    $('#finder-tab-menu a').on('click', function(event) {
      $("#finder-tab-contents .tab").hide();
      $("#finder-tab-menu .btn-danger").addClass("btn-outline-secondary");
      $("#finder-tab-menu .btn-danger").removeClass("btn-danger");
      $(this).removeClass("btn-outline-secondary");
      $(this).addClass("btn-danger");
      $($(this).attr("href")).show();
      event.preventDefault();
    });

    $(".formreset").on("click", function(){
      $(".form-inline input").val("");
      $(".form-inline input").attr("checked", false);
    });
  });
});