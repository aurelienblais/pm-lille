# frozen_string_literal: true

class RoomUserPolicy < ApplicationPolicy
  def new?
    true
  end

  def create?
    user.superadmin? || record.room.users.include?(user)
  end
end
