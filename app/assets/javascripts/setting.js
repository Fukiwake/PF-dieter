$(function() {
  $(document).on('turbolinks:load', function() {

    var url = location.href;
    id = url.split("#")[1]
    if(id){
      $(`#tab-contents .tab[id != ${id}]`).hide();
    } else {
      $('#tab-contents .tab[id != "profile"]').hide();
    }

    $('#tab-menu a').on('click', function(event) {
      $("#tab-contents .tab").hide();
      $("#tab-menu .active").removeClass("active");
      $(this).addClass("active");
      $($(this).attr("href")).show();
      event.preventDefault();
    });

    $('[name="customer[all_notification]"]').change(function(){
      if( $(this).prop('checked') ){
        document.getElementById("customer_comment_notification").removeAttribute("disabled");
        document.getElementById("customer_favorite_notification").removeAttribute("disabled");
        document.getElementById("customer_chat_notification").removeAttribute("disabled");
        document.getElementById("customer_follow_notification").removeAttribute("disabled");
      } else {
        document.getElementById("customer_comment_notification").setAttribute("disabled", "disabled");
        document.getElementById("customer_favorite_notification").setAttribute("disabled", "disabled");
        document.getElementById("customer_chat_notification").setAttribute("disabled", "disabled");
        document.getElementById("customer_follow_notification").setAttribute("disabled", "disabled");
      }
    });
  });
});