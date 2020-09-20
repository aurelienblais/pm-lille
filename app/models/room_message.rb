# frozen_string_literal: true

class RoomMessage < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :room, inverse_of: :room_messages

  scope :for_user, ->(user) { includes(room: { room_users: :user }).where(room: { room_users: { user: user } }) }
  scope :for_room, ->(room_id) { where(room_id: room_id) }
  scope :latest, ->(count) { order(created_at: :asc).last(count) }
  scope :without_system, -> () { where.not(user_id: nil) }

  def get_user
    return user if user

    OpenStruct.new({
                     complete_name: 'Système',
                     gravatar_url: ActionController::Base.helpers.asset_path('logo.jpg')
                   })
  end

  def as_json(options)
    super(options).merge(
      user_avatar_url: get_user.gravatar_url,
      user_name: get_user.complete_name,
      parsed_date: ApplicationController.helpers.display_datetime(created_at),
      room_name: room.name,
      room_path: Rails.application.routes.url_helpers.room_path(room)
    )
  end
end
