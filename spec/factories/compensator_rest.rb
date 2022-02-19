# frozen_string_literal: true

FactoryBot.define do
  factory :compensatory_rest do
    agent { create(:agent) }
    sequence(:reason) { |n| "Reason #{n}" }
    amount { rand(1..100) }
  end
end
