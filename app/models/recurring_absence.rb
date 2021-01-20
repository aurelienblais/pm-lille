# frozen_string_literal: true

class RecurringAbsence < ApplicationRecord
  belongs_to :agent
  belongs_to :absence_type
  scope :within_range, ->(range) { where(date: range) }

  def for_range(range)
    return nil if range.exclude?(start_date) && start_date > range.first

    stop_date = if end_date.nil?
                  range.last
                else
                  range.include?(end_date) || end_date < range.last ? end_date : range.last
                end
    start_date.step(stop_date, periodicity).flat_map do |date|
      {
        agent_id: agent_id,
        absence_type: absence_type.to_hash,
        date: date,
        recurring: true
      }.to_json
    end
  end
end
