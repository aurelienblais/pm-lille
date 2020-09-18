# frozen_string_literal: true

class AbsenceTypePolicy < ApplicationPolicy
  def index?
    user.superadmin? || user.admin?
  end

  def new?
    create?
  end

  def create?
    user.superadmin? || user.admin?
  end

  def edit?
    update?
  end

  def update?
    user.superadmin? || user.admin?
  end

  def destroy?
    user.superadmin? || user.admin?
  end
end
