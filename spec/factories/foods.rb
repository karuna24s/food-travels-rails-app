FactoryGirl.define do
  factory :food do
    name { Faker::Lorem.sentence }
    category { Faker::Lorem.paragraphs }
  end
end
