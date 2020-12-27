# frozen_string_literal: true

class RoomMessagesController < ApplicationController
  skip_before_action :authenticate_user!

  expose :item, model: RoomMessage, build_params: :room_message_params

  def create
    authorize item
    item.user = current_user
    item.save!

    RoomChannel.broadcast_to item.room, item

    item.room.room_users.each do |room_user|
      RoomNotificationsChannel.broadcast_to room_user.user, item
    end

    render 'room_messages/create'
  end

  def destroy
    authorize item
    item.destroy!

    RoomChannel.broadcast_to item.room, item

    render 'room_messages/destroy'
  end

  private

  def room_message_params
    params.require(:room_message).permit(
      :room_id,
      :message
    )
  end
end
