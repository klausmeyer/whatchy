FactoryBot.define do
  factory :episode do
    association :season

    first_aired { 1.month.ago }
  end
end
