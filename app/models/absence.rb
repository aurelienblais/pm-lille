class Absence < ApplicationRecord
  belongs_to :agent
  belongs_to :absence_type

  scope :within_range, -> (range) { where(date: range) }

  def to_json
    {
        agent_id: agent_id,
        date: date,
        absence_type: {
            id: absence_type_id,
            name: absence_type.name,
            color: absence_type.color
        }
    }.to_json
  end
end
