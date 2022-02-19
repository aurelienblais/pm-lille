# frozen_string_literal: true

class Agent < ApplicationRecord
  belongs_to :team
  belongs_to :rank

  has_many :absences, dependent: :delete_all
  has_many :compensatory_rests, dependent: :delete_all

  before_save :generate_token

  scope :order_by_name, -> { order(:last_name).order(:first_name) }
  scope :belong_to_team, ->(team) { where(team_id: team) }
  scope :birthdays_in_next_days, lambda { |days|
                                   where("to_char(birthday, 'mmdd') in(?)", days.times.map do |i|
                                                                              (Date.current + i.days).strftime('%m%d')
                                                                            end).order("to_char(birthday, 'mmdd') ASC")
                                 }
  scope :present_in_range, lambda { |range|
    arrival_date_in_range(range).departure_date_in_range(range)
  }
  scope :arrival_date_in_range, lambda { |range|
    where('arrival_date < ?', range.first)
      .or(where(arrival_date: range))
      .or(where(arrival_date: nil))
  }
  scope :departure_date_in_range, lambda { |range|
    where('departure_date > ?', range.last)
      .or(where(departure_date: range))
      .or(where(departure_date: nil))
  }

  def complete_name
    "#{first_name} #{last_name}"
  end

  def age
    return unless birthday

    age = Time.zone.today.year - birthday.year
    age -= 1 if Time.zone.today < birthday + age.years
    age
  end

  def leave_balance_for_range(range)
    return leave_balance if range.first.year <= 2020 # App start year

    Absence
      .includes(:absence_type)
      .references(:absence_type)
      .within_range(range)
      .merge(AbsenceType.with_leave_balance)
      .where(agent: self)
      .reduce(0) { |sum, item| sum + item.absence_type.leave_balance.to_f }
  end

  private

  def generate_token
    return if token.present?

    self.token = Digest::SHA1.hexdigest([Time.zone.now, rand].join)
  end
end
