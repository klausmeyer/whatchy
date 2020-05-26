FactoryBot.define do
  factory :season do
    association :show
    sequence(:number) { |n| n }
  end
end
