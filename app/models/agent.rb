class Agent < ApplicationRecord

  scope :order_by_name, -> { order(:last_name).order(:first_name) }

  def complete_name
    "#{first_name} #{last_name}"
  end
end