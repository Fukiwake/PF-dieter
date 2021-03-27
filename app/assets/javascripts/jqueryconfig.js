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
        },
        "diary[title]": {
          maxlength: 15,
        },
        "diary[body]": {
          maxlength: 200,
        },
      },
      messages: {
        "diary[weight]": {
          required: '体重を入力してください',
        },
        "diary[title]": {
          maxlength: 'タイトルは15文字以内で入力してください',
        },
        "diary[body]": {
          maxlength: '本文は200文字以内で入力してください',
        },
      },
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
  });
})