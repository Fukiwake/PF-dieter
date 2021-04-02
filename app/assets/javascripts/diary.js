$(function(){
  $(document).on('turbolinks:load', function() {


    $('.images-wrapper').not('.slick-initialized').slick({
      dots: true,
      arrows: true,
      autoplay: true,
      autoplaySpeed: 2000,
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

    function Loading(target){
      if($("#loading").length == 0){
        $(`#${target}`).html('<div class="text-center" id="loading"><img src="/assets/loading-71b831bc52ecef717245e2f57223d1be74a0185546166e78983a4f9c4230d2e8.gif"></div>');
      }
    }

    function removeLoading(){
      $("#loading").remove();
    }

    $(document).on("click", "#food-search-button", function () {
      Loading("food-search");
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
      Loading("food-search");
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
      $('#food-name').val("")
      $('#food-genre').val("")
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






    $(document).on("click", "#activity-search-button", function () {
      Loading("activity-search");
      $.ajax({
        url: "https://script.google.com/macros/s/AKfycbzxrQxMriO6NEwIbSbvlKbE5H5weUUeopEUnqBVUvGDoUILDhTNHhNGAaaUnIvACak7/exec?q=" + $('#activity-name').val(),
        dataType : 'json',
      }).done(function (data) {
        $('#activity-search').html("")
        var obj = JSON.parse(JSON.stringify(data));
        obj.forEach(function( activity ) {
          $('#activity-search').append(`<div class="d-flex justify-content-between">
                                      <div class="d-flex align-items-center">${activity.activity}</div>
                                      <div class="add-activity-button btn btn-danger" data-activity=${activity.activity} data-calorie=${activity.calorie}>追加</div>
                                    </div>`);
        });
        $('#activity-search').prepend('<div class="text-center text-danger font-weight-bold close-activity-search">閉じる</div>')
        $('#activity-search').append('<div class="text-center text-danger font-weight-bold close-activity-search">閉じる</div>')
      }).fail(function (data, XMLHttpRequest, textStatus, errorThrown) {
        console.log("XMLHttpRequest : " + XMLHttpRequest.status);
        console.log("textStatus     : " + textStatus);
        console.log("errorThrown    : " + errorThrown.message);
        alert('通信に失敗しました。');
      }).always(function(data) {
        removeLoading();
      });
    });

    $(document).on("change", "#activity-genre", function () {
      $('#activity-name').val("")
      Loading("activity-search");
      $.ajax({
        url: "https://script.google.com/macros/s/AKfycbzxrQxMriO6NEwIbSbvlKbE5H5weUUeopEUnqBVUvGDoUILDhTNHhNGAaaUnIvACak7/exec?q=" + $(this).val(),
        dataType : 'json',
      }).done(function (data) {
        $('#activity-search').html("")
        var obj = JSON.parse(JSON.stringify(data));
        obj.forEach(function( activity ) {
          $('#activity-search').append(`<div class="d-flex justify-content-between">
                                      <div class="d-flex align-items-center">${activity.activity}</div>
                                      <div class="add-activity-button btn btn-danger" data-activity=${activity.activity} data-calorie=${activity.calorie}>追加</div>
                                    </div>`);
        });
        $('#activity-search').prepend('<div class="text-center text-danger font-weight-bold close-activity-search">閉じる</div>')
        $('#activity-search').append('<div class="text-center text-danger font-weight-bold close-activity-search">閉じる</div>')
      }).fail(function (data, XMLHttpRequest, textStatus, errorThrown) {
        console.log("XMLHttpRequest : " + XMLHttpRequest.status);
        console.log("textStatus     : " + textStatus);
        console.log("errorThrown    : " + errorThrown.message);
        alert('通信に失敗しました。');
      }).always(function(data) {
        removeLoading();
      });
    });

    $("#activity-search").on("click", ".close-activity-search", function () {
      $('#activity-search').html("")
      $('#activity-name').val("")
      $('#activity-genre').val("")
    });

    function getTotalActivityCalorie(){
      var totalActivityCalorie = 0
      $(".activity-calorie").each(function () {
        var calorieInt = parseInt($(this).text());
        totalActivityCalorie += calorieInt
      });
      $("#diary_activity_calorie").val(totalActivityCalorie + $(".base-calorie").text())
      if ($("#diary_activity_calorie").val() === "NaN") {
        $("#diary_activity_calorie").val("分数は数値で入力してください")
      }
    }

    $("#activity-search").on("click", ".add-activity-button", function () {
      var activity = $(this).data('activity')
      var calorie = $(this).data('calorie')
      $('#activity-selected').append(`<div class="row mb-2">
                                    <div class="col-md-6">${activity}</div>
                                    <div class="selected-activity-info col-md-6">
                                      <input type="text" class="activity-quantity" value=30 size=1 name="activity-quantity data-error_placement="#activity_quantity_error">
                                      分
                                      <span class="activity-calorie" id="${calorie}">${Math.round(calorie * $('#diary_weight').val() * 30)}</span>
                                      Kcal
                                      <span class="remove-activity-button text-danger font-weight-bold">x</span>
                                    </div>
                                  </div>`);
      getTotalActivityCalorie();
    });

    $(document).on("click", ".remove-activity-button", function () {
      $(this).parent().parent().remove()
      getTotalCalorie();
    });

    $(document).on('change', '.activity-quantity', function () {
      var calorieSum = Math.round($(this).next().attr('id') * $(this).val() * $('#diary_weight').val());
      $(this).next().text(calorieSum)
      getTotalActivityCalorie();
    });

    $(document).on('change', '#diary_weight', function () {
      if ($(this).val().length) {
        $("#activity-field").addClass("d-flex")
        $("#activity-error").addClass("d-none")
      } else {
        $("#activity-field").removeClass("d-flex")
        $("#activity-error").removeClass("d-none")
      }
      if ($(this).data('gender') === "male") {
        $("#base-calorie").text(Math.round(13.397 * $(this).val() + 4.799 * $(this).data('height') - 5.677 * $(this).data('age') + 88.362))
      } else if ($(this).data('gender') === "female") {
        $("#base-calorie").text(Math.round(9.247 * $(this).val() + 3.098 * $(this).data('height') - 4.33 * $(this).data('age') + 447.593))
      }
      $('.activity-calorie[id != "base-calorie"]').each(function () {
        $(this).text(Math.round($(this).attr("id") * $('#diary_weight').val() * $(this).prev().val()))
      });
    });


    $(document).on("click", "#image-analysis-submit", function (e) {
      e.preventDefault();
      $('#close-form-button').trigger("click");
      Loading("food-search");
      var formData = new FormData();
      formData.append("food_image", $("#analysis-image")[0].files[0]);
      $.ajax({
        url: "/diaries/image_analysis",
        type: "POST",
        data: formData,
        processData: false,
        contentType: false,
        async: true,
        dataType: 'json'
      })
      .done(function(data) {
        data.forEach(function( food ) {
          $('#food-search').append(`<div class="d-flex justify-content-between">
                                      <div class="d-flex align-items-center">${food.food}</div>
                                      <div class="add-food-button btn btn-danger" data-food=${food.food} data-calorie=${food.calorie}>追加</div>
                                    </div>`);
        });
        $('#food-search').prepend('<div class="text-center text-danger font-weight-bold close-food-search">閉じる</div>')
        $('#food-search').append('<div class="text-center text-danger font-weight-bold close-food-search">閉じる</div>')
        removeLoading();
      })
      .fail(function() {
        alert("通信に失敗しました")
      });
    });
  });
});