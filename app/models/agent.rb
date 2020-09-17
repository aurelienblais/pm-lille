class Agent < ApplicationRecord
  belongs_to :team
  belongs_to :rank
  has_many :absences

  scope :order_by_name, -> { order(:last_name).order(:first_name) }

  def complete_name
    "#{first_name} #{last_name}"
  end

  def age
    age = Date.today.year - birthday.year
    age -= 1 if Date.today < birthday + age.years
    age
  end
end
