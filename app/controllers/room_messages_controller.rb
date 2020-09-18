class RoomMessagesController < ApplicationController
  expose :item, model: RoomMessage, build_params: :room_message_params

  def create
    item.user = current_user
    item.save!

    RoomChannel.broadcast_to item.room, item

    item.room.room_users.each do |room_user|
      RoomNotificationsChannel.broadcast_to room_user.user, item
    end

    render 'room_messages/create'
  end

  private

  def room_message_params
    params.require(:room_message).permit(
      :room_id,
      :message
    )
  end
end
