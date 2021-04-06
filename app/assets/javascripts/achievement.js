$(function() {
  $(document).on('turbolinks:load', function() {
    $('.achievement-button').on('click', function(event) {
      $('.achievement-button').parent().removeClass('bg-success')
      $(this).parent().addClass('bg-success')
      $('.achievement-area').removeClass('active')
      $(`#achievement-area-${$(this).attr('id')}`).addClass('active')
      event.preventDefault();
    });
  });
});