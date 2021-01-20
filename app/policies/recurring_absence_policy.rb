# frozen_string_literal: true

class RecurringAbsencePolicy < ApplicationPolicy
  class Scope
    def initialize(user, scope)
      @user  = user
      @scope = scope
    end

    def resolve
      if user.superadmin? || (user.admin? && user.teams.empty?)
        scope.all
      else
        scope.eager_load(agent: :team).where(agents: { team_id: user.teams.map(&:id) })
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

  def edit?
    true
  end

  def update?
    edit?
  end

  def destroy?
    create?
  end
end
