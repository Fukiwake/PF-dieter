FactoryBot.define do
  factory :achievement do
    title { Faker::Lorem.characters(number: 5) }
  end
end