# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

50.times do |n|
  name = Faker::Lorem.characters(number: 10)
  Customer.create!(
  email: "test#{n}@test.com",
  password: "testpass",
  name: name,
  gender: rand(0..1),
  birthyear: rand(1960..2015),
  birthdate: "2021-02-03",
  height: rand(120..190),
  target_weight: rand(30..100),
  target_body_fat_percentage: rand(5..35),
  introduce: "よろしくおねがいします",
  profile_image_id: nil,
  )
end

50.times do |n|
  month = rand(1..12)
  date = rand(1..28)
  Diary.create!(
    title: "test",
    body: "test",
    weight: rand(60..90),
    body_fat_percentage: rand(15..30),
    post_date: "2021-#{month}-#{date}",
    customer_id: "50"
  )
end

DietStyle.create!(
  name: "筋トレメイン"
)

DietStyle.create!(
  name: "食事制限メイン"
)

DietStyle.create!(
  name: "長期継続"
)

DietStyle.create!(
  name: "短期集中"
)

CustomerDietStyle.create!(
  customer_id: "50",
  diet_style_id: "1"
)
CustomerDietStyle.create!(
  customer_id: "50",
  diet_style_id: "4"
)
