# frozen_string_literal: true

FactoryBot.define do
  factory :absence_type do
    sequence(:name) { |n| "AbsenceType #{n}" }
    color { '#ff0000' }
    texture { AbsenceType::TEXTURES.sample }
  end
end
