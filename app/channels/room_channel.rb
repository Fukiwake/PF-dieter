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
      customer_id: data['customer_room']["current_customer_id"],
      room_id: data["customer_room"]["room_id"]
    )
    if chat.save!
      customer = Customer.find(data['customer_room']["customer_id"])
      current_customer = Customer.find(data['customer_room']["current_customer_id"])
      if customer.chat_notification == true && customer.all_notification == true && customer.blocking?(current_customer) == false
        notification = current_customer.active_notifications.new(
          chat_id: chat.id,
          visited_id: customer.id,
          action: 'chat'
        )
        notification.save if notification.valid?
      end
      ActionCable.server.broadcast "room_channel_#{params['room_id']}", message: data['message'], customer_id: data['customer_room']['current_customer_id']
    end
  end
end
