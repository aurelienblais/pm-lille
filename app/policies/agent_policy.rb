# frozen_string_literal: true

class AgentPolicy < ApplicationPolicy
  class Scope
    def initialize(user, scope)
      @user  = user
      @scope = scope
    end

    def resolve
      if user.superadmin? || user.admin?
        scope.all
      else
        scope.where(team_id: user.teams.map(&:id))
      end
    end

    private

    attr_reader :user, :scope
  end

  def index?
    true
  end

  def new?
    create?
  end

  def create?
    true
  end

  def show?
    user.superadmin? || user.admin? || user.teams.include?(record.team)
  end

  def edit?
    update?
  end

  def update?
    user.superadmin? || user.admin? || user.teams.include?(record.team)
  end

  def destroy?
    update?
  end
end
