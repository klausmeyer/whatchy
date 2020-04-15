FactoryBot.define do
  factory :show do
    sequence(:title)    { |n| "Factory Show #{n}" }
    sequence(:slug)     { |n| "factory-show-#{n}" }
    sequence(:image)    { |n| "/posters/factory-show-#{n}.png" }
    sequence(:overview) { 'Lorem ipsum dolor sit amet ...' }
    rating { 3.5 }
  end
end
