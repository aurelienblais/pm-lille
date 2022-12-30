# frozen_string_literal: true

class Absence < ApplicationRecord
  belongs_to :agent
  belongs_to :absence_type

  validates :date, presence: true

  scope :within_range, ->(range) { where(date: range) }

  def to_json(*_args)
    {
      agent_id:,
      date:,
      absence_type: absence_type.to_hash,
      recurring: false
    }.to_json
  end
end
