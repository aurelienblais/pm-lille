# frozen_string_literal: true

FactoryBot.define do
  factory :recurring_absence do
    agent { create(:agent) }
    absence_type { create(:absence_type) }
    start_date { Time.zone.today }
    end_date { Time.zone.today + rand(0..100) }
    periodicity { rand(1..7) }
  end
end
