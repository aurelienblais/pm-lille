# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "email#{n}@example.com" }
    sequence(:first_name) { |n| "FirstName #{n}" }
    sequence(:last_name) { |n| "LastName #{n}" }
    password { '123456' }
    role { :user }

    trait :disabled do
      role { :disabled }
    end

    trait :admin do
      role { :admin }
    end

    trait :superadmin do
      role { :superadmin }
    end

    trait :with_team do
      transient do
        team { create(:team) }
      end

      after(:create) do |user, evaluator|
        UserTeam.create(user: user, team: evaluator.team)
      end
    end
  end
end
