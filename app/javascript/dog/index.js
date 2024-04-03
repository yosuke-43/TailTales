$(document).on('turbo:load', function () {
  $(function () {
    $('.js-text_field').on('keyup', function () {
      var user_input = $.trim($(this).val());

      // 入力フィールドが空の場合はリストをクリアして処理を終了
      if (user_input === '') {
        $('.js-lists li').remove();
        return;
      }

      // 追加コード
      $.ajax({
        type: 'GET', // リクエストのタイプ
        url: '/dogs/lists', // リクエストを送信するURL
        data:  { breed: user_input }, // サーバーに送信するデータ
        dataType: 'json' // サーバーから返却される型
      })
      .done(function (data) {
        $('.js-lists li').remove();
        $(data).each(function(i, dog) {
          var listItem = $('<li class="dog-list">' + dog.breed + '</li>');
          $('.js-lists').append(listItem);

          // リストがクリックされたときのイベントリスナーを追加
          listItem.on('click', function() {
            $('.js-text_field').val(dog.breed); // リストのテキストを検索フォームにコピー
          });
        });
      });
    });
  });
});
