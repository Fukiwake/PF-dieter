class ChatsController < ApplicationController
  before_action :set_new_diary, only: [:show]

  def show
    @customer = Customer.find(params[:id])
    rooms_ids = current_customer.entries.pluck(:room_id)
    entries = Entry.find_by(customer_id: @customer.id, room_id: rooms_ids)
    if entries.nil?
      @room = Room.create
      Entry.create(customer_id: current_customer.id, room_id: @room.id)
      Entry.create(customer_id: @customer.id, room_id: @room.id)
    else
      @room = entries.room
    end
    @chats = @room.chats
    @chat = Chat.new(room_id: @room.id)
    @other_rooms = current_customer.rooms.where.not(id: @room.id)
    @other_rooms = @other_rooms.each do |other_room|
      if other_room.chats.blank?
        other_room.destroy
      end
    end
  end

end
