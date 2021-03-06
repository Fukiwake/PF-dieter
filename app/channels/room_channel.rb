class RoomChannel < ApplicationCable::Channel
  def subscribed
    stream_from "room_channel_#{params['room_id']}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def create(data)
    chat = Chat.new(
      message: data["message"],
      customer_id: data['customer_room']["customer_id"],
      room_id: data["customer_room"]["room_id"]
    )
    if chat.save
      ActionCable.server.broadcast "room_channel_#{params['room_id']}", message: data['message'], customer_id: data['customer_room']['customer_id']
    end
  end
end
