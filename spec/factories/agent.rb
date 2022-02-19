# frozen_string_literal: true

FactoryBot.define do
  factory :agent do
    sequence(:first_name) { |n| "First_name #{n}" }
    sequence(:last_name) { |n| "Last_name #{n}" }
    register_number { rand(0..10_000) }
    birthday { Time.zone.today + rand(-100..100) }
    arrival_date { Time.zone.today + rand(-100..-1) }
    departure_date { Time.zone.today + rand(1..100) }

    team { create(:team) }
    rank { create(:rank) }

    trait :with_email do
      sequence(:email) { |n| "email#{n}@example.com" }
    end
  end
end
