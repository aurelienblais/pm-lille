# frozen_string_literal: true

class AbsenceType < ApplicationRecord
  has_many :absences, dependent: :delete_all

  scope :order_by_name, -> { order(:name) }
  scope :with_leave_balance, -> { where('leave_balance > 0') }

  TEXTURES = ['', 'texture-chevron', 'texture-honey', 'texture-striped', 'texture-striped-reverse']

  def to_s
    name
  end
end
