# frozen_string_literal: true

class Room < ApplicationRecord
  has_many :room_messages, dependent: :destroy,
                           inverse_of: :room
  has_many :room_users, dependent: :destroy
  has_many :users, through: :room_users

  scope :order_by_name, -> { order(:name) }
  scope :order_by_last_message, -> { includes(:room_messages).order('room_messages.created_at desc') }
  scope :for_user, ->(user) { includes(room_users: :user).where(room_users: { user: user }) }

  after_create :create_system_message

  private

  def create_system_message
    message = RoomMessage.create!(room: self, message: "Salle de discussion #{name} créée")
    RoomChannel.broadcast_to self, message
  end
end
