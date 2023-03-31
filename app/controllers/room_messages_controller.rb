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

    begin
      if item.room.agent.present? && item.user.present?
        AgentMailer.with(agent: item.room.agent, message: item).message_notification.deliver_now!
      else
        item.room.users.reject { |user| user == item.user }.each do |user|
          UserMailer.with(user:, message: item).message_notification.deliver_now!
        end
      end
    rescue
      warn 'Failed to send mail'
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
