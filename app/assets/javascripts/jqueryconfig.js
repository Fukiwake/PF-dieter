$(function(){
  $(document).on('turbolinks:load', function() {
    $('#new-registration-form').validate({
      rules: {
        "customer[email]": {
          required: true,
          email: true,
        },
        "customer[password]": {
          required: true,
          minlength: 6,
        },
        "customer[password_confirmation]": {
          required: true,
          equalTo: '#customer_password',
        },
        "customer[age]": {
          number: true,
        },
      },
      messages: {
        "customer[email]": {
          required: 'メールアドレスを入力してください',
          email: 'メールアドレスの形式が正しくありません',
        },
        "customer[password]": {
          required: 'パスワードを入力してください',
          minlength: 'パスワードは6文字以上で入力してください',
        },
        "customer[password_confirmation]": {
          required: 'パスワード(確認用)を入力して下さい',
          equalTo: 'パスワードが一致しません',
        },
      },
    });

    $('#diary-form').validate({
      rules: {
        "diary[weight]": {
          required: true,
          number: true,
        },
        "diary[body_fat_percentage]": {
          number: true,
        },
        "diary[title]": {
          maxlength: 15,
        },
        "diary[body]": {
          maxlength: 200,
        },
        "activity-quantity": {
          digits: true,
        },
      },
      messages: {
        "diary[weight]": {
          required: '体重を入力してください',
          number: "数値で入力してください",
        },
        "diary[body_fat_percentage]": {
          number: "数値で入力してください",
        },
        "diary[title]": {
          maxlength: 'タイトルは15文字以内で入力してください',
        },
        "diary[body]": {
          maxlength: '本文は200文字以内で入力してください',
        },
        "activity-quantity": {
          digits: "数値で入力してください",
        },
      },
      errorPlacement: function(error, element){
        error.appendTo(element.data('error_placement'));
      }
    });

    $('#diet-method-form').validate({
      rules: {
        "diet_method[title]": {
          required: true,
          maxlength: 15,
        },
        "diet_method[way]": {
          required: true,
        },
      },
      messages: {
        "diet_method[title]": {
          maxlength: 'タイトルは15文字以内で入力してください',
          required: 'タイトルを入力してください',
        },
        "diet_method[way]": {
          required: 'やり方・効果を入力してください',
        },
      },
    });

    $('#new-profile-form').validate({
      rules: {
        "customer[name]": {
          required: true,
        },
        "customer[age]": {
          digits: true,
          required: true,
        },
        "customer[height]": {
          number: true,
          required: true,
        },
        "customer[target_weight]": {
          number: true,
          required: true,
        },
        "customer[target_body_fat_percentage]": {
          number: true,
        },
      },
      messages: {
        "customer[name]": {
          required: "名前を入力してください",
        },
        "customer[age]": {
          digits: "数値で入力してください",
          required: "年齢を入力してください",
        },
        "customer[height]": {
          number: "数値で入力してください",
          required: "身長を入力してください",
        },
        "customer[target_weight]": {
          number: "数値で入力してください",
          required: "目標体重を入力してください",
        },
        "customer[target_body_fat_percentage]": {
          number: "数値で入力してください",
        },
      },
      errorPlacement: function(error, element){
        error.appendTo(element.data('error_placement'));
      }
    });


  });
})