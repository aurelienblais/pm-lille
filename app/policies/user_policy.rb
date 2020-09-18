# frozen_string_literal: true

class UserPolicy < ApplicationPolicy
  def index?
    user.superadmin? || user.admin?
  end

  def edit?
    update?
  end

  def update?
    user.superadmin? || user.admin?
  end
end
