# frozen_string_literal: true

class RoomMessagePolicy < ApplicationPolicy
  class Scope
    def initialize(user, scope)
      @user  = user
      @scope = scope
    end

    def resolve
      if user.superadmin?
        scope.all
      else
        scope.for_user(user)
      end
    end

    private

    attr_reader :user, :scope
  end

  def create?
    user.superadmin? || record.room.users.include?(user)
  end

  def destroy?
    user.superadmin? || user.admin?
  end
end
