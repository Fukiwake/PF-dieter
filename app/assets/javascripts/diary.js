$(function(){
  $(document).on('turbolinks:load', function() {


    $('.images-wrapper').not('.slick-initialized').slick({
      dots: true,
      arrows: true,
    });

    $(".abort-button").mouseover(function() {
      $(this).removeClass("btn-danger")
      $(this).css({"background-color": "red", "color": "white"})
      $(this).text("やめる")
    });

    $(".abort-button").mouseout(function() {
      $(this).addClass("btn-danger")
      $(this).css({"background-color": "", "color": ""})
      $(this).text("実践中")
    });

    $(window).on('scroll', function() {
      scrollHeight = $(document).height();
      scrollPosition = $(window).height() + $(window).scrollTop();
      if ( (scrollHeight - scrollPosition) / scrollHeight <= 0.05) {
        $('.diary-scroll-list').jscroll({
          loadingHtml: '<div class="text-center"><img src="/assets/loading-71b831bc52ecef717245e2f57223d1be74a0185546166e78983a4f9c4230d2e8.gif"></div>',
          contentSelector: '.diary-scroll-list',
          nextSelector: 'li.next:last a'
        });
      }
    });

    function Loading(){
      if($("#loading").length == 0){
        $("#food-search").html('<div class="text-center" id="loading"><img src="/assets/loading-71b831bc52ecef717245e2f57223d1be74a0185546166e78983a4f9c4230d2e8.gif"></div>');
      }
    }

    function removeLoading(){
      $("#loading").remove();
    }

    $(document).on("click", "#food-search-button", function () {
      Loading();
      $.ajax({
        url: "https://script.google.com/macros/s/AKfycby6haaQU_xO-3YuucykjFXps6PNiEj5DBnUNIfuGO6KjXkaHlQzI_5ULKXnjbwOA_00/exec?q=" + $('#food-name').val(),
        dataType : 'json',
      }).done(function (data) {
        $('#food-search').html("")
        var obj = JSON.parse(JSON.stringify(data));
        obj.forEach(function( food ) {
          $('#food-search').append(`<div class="d-flex justify-content-between">
                                      <div class="d-flex align-items-center">${food.food}</div>
                                      <div class="add-food-button btn btn-danger" data-food=${food.food} data-calorie=${food.calorie}>追加</div>
                                    </div>`);
        });
        $('#food-search').prepend('<div class="text-center text-danger font-weight-bold close-food-search">閉じる</div>')
        $('#food-search').append('<div class="text-center text-danger font-weight-bold close-food-search">閉じる</div>')
      }).fail(function (data, XMLHttpRequest, textStatus, errorThrown) {
        console.log("XMLHttpRequest : " + XMLHttpRequest.status);
        console.log("textStatus     : " + textStatus);
        console.log("errorThrown    : " + errorThrown.message);
        alert('通信に失敗しました。');
      }).always(function(data) {
        removeLoading();
      });
    });

    $(document).on("change", "#food-genre", function () {
      $('#food-name').val("")
      Loading();
      $.ajax({
        url: "https://script.google.com/macros/s/AKfycby6haaQU_xO-3YuucykjFXps6PNiEj5DBnUNIfuGO6KjXkaHlQzI_5ULKXnjbwOA_00/exec?q=" + $(this).val(),
        dataType : 'json',
      }).done(function (data) {
        $('#food-search').html("")
        var obj = JSON.parse(JSON.stringify(data));
        obj.forEach(function( food ) {
          $('#food-search').append(`<div class="d-flex justify-content-between">
                                      <div class="d-flex align-items-center">${food.food}</div>
                                      <div class="add-food-button btn btn-danger" data-food=${food.food} data-calorie=${food.calorie}>追加</div>
                                    </div>`);
        });
        $('#food-search').prepend('<div class="text-center text-danger font-weight-bold close-food-search">閉じる</div>')
        $('#food-search').append('<div class="text-center text-danger font-weight-bold close-food-search">閉じる</div>')
      }).fail(function (data, XMLHttpRequest, textStatus, errorThrown) {
        console.log("XMLHttpRequest : " + XMLHttpRequest.status);
        console.log("textStatus     : " + textStatus);
        console.log("errorThrown    : " + errorThrown.message);
        alert('通信に失敗しました。');
      }).always(function(data) {
        removeLoading();
      });
    });

    $("#food-search").on("click", ".close-food-search", function () {
      $('#food-search').html("")
    });

    function getTotalCalorie(){
      var totalCalorie = 0
      $(".calorie").each(function () {
        var calorieInt = parseInt($(this).text());
        totalCalorie += calorieInt
      });
      $("#diary_food_calorie").val(totalCalorie)
    }

    $("#food-search").on("click", ".add-food-button", function () {
      var food = $(this).data('food')
      var calorie = $(this).data('calorie')
      $('#food-selected').append(`<div class="row mb-2">
                                    <div class="col-md-6">${food}</div>
                                    <div class="selected-food-info col-md-6">
                                      <select class="food-quantity">
                                        <option value="1">1</option>
                                        <option value="2">2</option>
                                        <option value="3">3</option>
                                        <option value="4">4</option>
                                        <option value="5">5</option>
                                      </select>
                                      人前
                                      <span class="calorie" id="${calorie}">${calorie}</span>
                                      Kcal
                                      <span class="remove-food-button text-danger font-weight-bold">x</span>
                                    </div>
                                  </div>`);
      getTotalCalorie();
    });

    $(document).on("click", ".remove-food-button", function () {
      $(this).parent().parent().remove()
      getTotalCalorie();
    });

    $(document).on('change', '.food-quantity', function () {
      var calorieSum = parseInt($(this).next().attr('id')) * $(this).val()
      $(this).next().text(calorieSum)
      getTotalCalorie();
    });
  });
});