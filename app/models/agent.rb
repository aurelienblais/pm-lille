class Agent < ApplicationRecord
  belongs_to :team
  belongs_to :rank
  has_many :absences

  scope :order_by_name, -> { order(:last_name).order(:first_name) }
  scope :belong_to_team, ->(team) { where(team_id: team) }

  def complete_name
    "#{first_name} #{last_name}"
  end

  def age
    age = Date.today.year - birthday.year
    age -= 1 if Date.today < birthday + age.years
    age
  end

  def leave_balance_for_range(range)
    return leave_balance if range.first.year < 2020 # App start year

    Absence
      .includes(:absence_type)
      .references(:absence_type)
      .within_range(range)
      .merge(AbsenceType.with_leave_balance)
      .where(agent: self)
      .reduce(0) { |sum, item| sum + item.absence_type.leave_balance }
  end
end
