$(function() {
  
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

});