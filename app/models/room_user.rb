# frozen_string_literal: true

class RoomUser < ApplicationRecord
  belongs_to :user
  belongs_to :room

  after_create :create_system_message

  private

  def create_system_message
    return if room.agent.present?

    message = RoomMessage.create!(room:, message: "Utilisateur #{user.complete_name} ajouté")
    RoomChannel.broadcast_to room, message
    RoomNotificationsChannel.broadcast_to user, message
  end
end
