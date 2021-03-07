const roomChannel = App.cable.subscriptions.create("RoomChannel", {
  room: $('#customer_room').data('room_id'),
  connected: function() {},
  disconnected: function() {},
  received: function(data) {
    var now = new Date();
    var year = now.getFullYear();
    var month = now.getMonth()+1;
    var date = now.getDate();
    var hour = now.getHours();
    var min = ("0"+now.getMinutes()).slice(-2)
    var time = year + "年" + month + "月" + date + "日 " + hour + ":" + min
    var src = $("#chat-with").children('img').attr('src');
    if (data['customer_id'] == $('#customer_room').data('customer_id')) {
      $('#new-message').append(`<div class="text-right">
                                  <div class="chat-right text-left">
                                    <p>${data['message']}</p>
                                  </div>
                                  <div>${time}</div>
                                </div>`);
    } else {
      if(src.indexOf('/assets/no_image') === -1) {
        $('#new-message').append(`<div>
                                    <img class="attachment customer profile_image mr-1" src="${src}" width="70" height="70">
                                    <div class="chat-left">
                                      <p>${data['message']}</p>
                                    </div>
                                    <div>${time}</div>
                                  </div>`);
      } else {
        $('#new-message').append(`<div>
                                    <img class="attachment customer profile_image fallback mr-1" src="/assets/no_image-e1a743df0c155237d2677a50919e83279a8002ff93f24727582e52ffb2347dd1.png" width="70" height="70">
                                    <div class="chat-left">
                                      <p>${data['message']}</p>
                                    </div>
                                    <div>${time}</div>
                                  </div>`);
      }
    }
    var $scroll = $('#chat-area')
    $scroll.animate({
      scrollTop:　$scroll[0].scrollHeight
    }, 0);
  },
  create(message) {
  const customer_room = $('#customer_room').data()
  return this.perform('create', {
    message: message,
    customer_room: customer_room
  })
}
});

$(document).on('keypress', '#message-form', function(e) {
  if (e.keyCode === 13 && e.target.value !== "") {
    roomChannel.create(e.target.value);
    e.target.value = '';
  }
})

$(function(){
  let chats = document.getElementById('chats-scroll-inner');
  if (chats !== null) {
    chats.scrollIntoView(false);
  }
  
  $(".fa-angle-double-right").on('click', function(e) {
    message = document.getElementById("message-form").value;
    if (message !== "") {
      roomChannel.create(message);
      document.getElementById("message-form").value = '';
    }
})
});

