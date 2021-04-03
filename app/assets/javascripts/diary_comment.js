$(function() {
  $(document).on('turbolinks:load', function() {
    $(document).on("click", ".reply-button", function () {
      $(`#reply-form-${$(this).attr('id')}`).addClass("active")
    });

    $(document).on("click", ".close-reply-button", function () {
      $(`#reply-form-${$(this).data('comment_id')}`).removeClass("active")
    });

    $(document).on("click", ".show-reply-button", function () {
      $(`#reply-field-${$(this).data('comment_id')}`).toggleClass("active")
    });
  });
});