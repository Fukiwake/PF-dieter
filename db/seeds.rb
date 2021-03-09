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

50.times do |n|
  DietMethod.create!(
    title: "test",
    way: "test",
    attention: "test",
    customer_id: "50"
  )
  
end

999.times do |n|
  LevelSetting.create!(
    level: n + 2,
    threshold: 10 + n * 10
  )
end

