FactoryGirl.define do
  factory :comment do
    content { Faker::Lorem.paragraphs }
    destination_id 1
    user_id 1
  end
end
