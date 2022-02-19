# frozen_string_literal: true

FactoryBot.define do
  factory :room do
    sequence(:name) { |n| "Room #{n}" }

    trait(:with_agent) do
      agent { create(:agent) }
    end
  end
end
