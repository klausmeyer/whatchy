FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "user-#{n}@example.com" }
    password { '12345678' }

    trait :confirmed do
      confirmed_at { Time.now }
    end
  end
end
