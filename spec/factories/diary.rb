FactoryBot.define do
  factory :diary do
    title { Faker::Lorem.characters(number: 5) }
    body { Faker::Lorem.characters(number: 100) }
    weight {rand(30..80)}
    body_fat_percentage {rand(10..25)}
    post_date {"2021-02-20"}
  end
end