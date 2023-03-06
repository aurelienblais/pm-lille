# frozen_string_literal: true

class AbsenceType < ApplicationRecord
  has_many :absences, dependent: :delete_all

  scope :order_by_name, -> { order(:name) }
  scope :with_leave_balance, -> { where('leave_balance > 0') }
  scope :only_display_statistic, -> { where(display_statistic: true) }
  scope :visible, -> { where(status: 'visible') }

  TEXTURES = ['', 'texture-chevron', 'texture-honey', 'texture-striped', 'texture-striped-reverse'].freeze
  STATUS = %w[visible hidden].freeze

  validates :texture, inclusion: { in: TEXTURES }
  validates :status, inclusion: { in: STATUS }

  def to_s
    name
  end

  STATUS.each do |r|
    define_method("#{r}?") do
      status == r
    end
  end

  def to_hash
    {
      id:,
      name:,
      color:,
      texture:
    }
  end
end
