# frozen_string_literal: true

class Absence < ApplicationRecord
  belongs_to :agent
  belongs_to :absence_type

  scope :within_range, ->(range) { where(date: range) }

  def to_json(*_args)
    {
      agent_id: agent_id,
      date: date,
      absence_type: absence_type.to_hash,
      recurring: false
    }.to_json
  end
end
