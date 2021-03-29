FactoryBot.define do
  factory :diet_method do
    title { Faker::Lorem.characters(number: 5) }
    way { Faker::Lorem.characters(number: 100) }
    attention { Faker::Lorem.characters(number: 100) }
  end
end
