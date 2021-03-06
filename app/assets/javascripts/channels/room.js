const roomChannel = App.cable.subscriptions.create("RoomChannel", {
  room: $('#customer_room').data('room_id'),
  connected: function() {},
  disconnected: function() {},
  received: function(data) {
    if (data['customer_id'] == $('#customer_room').data('customer_id')) {
      $('#new-message').append('<p class="chat-right">'+data['message']+'</p>');
    } else {
      $('#new-message').append('<p class="chat-left">'+data['message']+'</p>');
    }
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

