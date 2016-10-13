FactoryGirl.define do
  factory :destination do
    title { Faker::Lorem.sentence }
    content { Faker::Lorem.paragraphs }
    location { Faker::Lorem.sentence }
    recommendation { Faker::Lorem.sentence }
    food_id 1
    user_id 1
  end
end
