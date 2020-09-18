# frozen_string_literal: true

class Team < ApplicationRecord
  has_many :agents

  has_many :user_teams
  has_many :user, through: :user_teams

  scope :order_by_name, -> { order(:name) }

  def to_s
    name
  end
end
