FactoryBot.define do
  factory :subscription do
    association :user
    association :show
  end
end
