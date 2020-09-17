class AbsenceType < ApplicationRecord
  has_many :absences

  scope :order_by_name, -> { order(:name) }

  def to_s
    name
  end
end
