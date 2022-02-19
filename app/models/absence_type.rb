# frozen_string_literal: true

class AbsenceType < ApplicationRecord
  has_many :absences, dependent: :delete_all

  scope :order_by_name, -> { order(:name) }
  scope :with_leave_balance, -> { where('leave_balance > 0') }
  scope :only_display_statistic, -> { where(display_statistic: true) }

  TEXTURES = ['', 'texture-chevron', 'texture-honey', 'texture-striped', 'texture-striped-reverse'].freeze

  validates :texture, inclusion: { in: TEXTURES }

  def to_s
    name
  end

  def to_hash
    {
      id: id,
      name: name,
      color: color,
      texture: texture
    }
  end
end
