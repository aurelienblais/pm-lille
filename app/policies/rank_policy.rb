# frozen_string_literal: true

class RankPolicy < ApplicationPolicy
  class Scope
    def initialize(user, scope)
      @user  = user
      @scope = scope
    end

    def resolve
      if user.superadmin? || user.admin?
        scope.all
      else
        scope.none
      end
    end

    private

    attr_reader :user, :scope
  end

  def index?
    user.superadmin? || user.admin?
  end

  def new?
    create?
  end

  def create?
    user.superadmin? || user.admin?
  end

  def destroy?
    user.superadmin? || user.admin?
  end
end
