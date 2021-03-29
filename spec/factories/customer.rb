FactoryBot.define do
  factory :customer do
    gimei = Gimei::Name.new
    name { gimei.first.katakana }
    email { Faker::Internet.email }
    gender { "male" }
    age { rand(10..60) }
    height { rand(130..200) }
    target_weight { rand(30..80) }
    target_body_fat_percentage { rand(10..25) }
    introduce { "よろしくおねがいします" }
    is_deleted { "false" }
    password { 'password' }
    password_confirmation { 'password' }
  end
end
