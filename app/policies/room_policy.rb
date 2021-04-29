# frozen_string_literal: true

class RoomPolicy < ApplicationPolicy
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

  def index?
    true
  end

  def show?
    user.superadmin? || record.users.include?(user)
  end

  def new?
    create?
  end

  def create?
    true
  end

  def purge?
    user.superadmin? || user.admin?
  end

  def destroy?
    purge?
  end
end
