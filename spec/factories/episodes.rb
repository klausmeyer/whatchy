FactoryBot.define do
  factory :episode do
    association :season

    sequence(:number) { |n| n }
    sequence(:title)  { |n| "Episode #{n}" }
    first_aired { 1.month.ago }

    trait :aired do
      first_aired { Date.today - 3.months }
    end

    trait :upcoming do
      first_aired { Date.today + 3.months }
    end
  end
end
