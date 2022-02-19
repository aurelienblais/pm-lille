# frozen_string_literal: true

FactoryBot.define do
  factory :room_message do
    room { create(:room) }
    sequence(:message) { |n| "Message #{n}" }

    trait :with_user do
      user { create(:user) }
    end

    trait :with_agent do
      room { create(:room, :with_agent) }
    end
  end
end
