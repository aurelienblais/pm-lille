# frozen_string_literal: true

FactoryBot.define do
  factory :absence do
    agent { create(:agent) }
    absence_type { create(:absence_type) }
    date { Time.zone.today + rand(-100..100) }
  end
end
