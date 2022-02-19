# frozen_string_literal: true

FactoryBot.define do
  factory :rank do
    sequence(:name) { |n| "Rank #{n}" }
  end
end
