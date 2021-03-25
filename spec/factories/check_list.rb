FactoryBot.define do
  factory :check_list do
    body { Faker::Lorem.characters(number: 5) }
  end
end