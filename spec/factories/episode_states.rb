FactoryBot.define do
  factory :episode_state do
    association :episode
    association :user
    seen_at { nil }

    trait :unseen do
      seen_at { nil }
    end

    trait :seen do
      seen_at { Time.current }
    end
  end
end
