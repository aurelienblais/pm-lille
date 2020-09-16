class Team < ApplicationRecord
  has_many :agents

  scope :order_by_name, -> { order(:name) }

  def to_s
    name
  end
end