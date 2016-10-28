FactoryGirl.define do
  factory :comment do
    content {Faker::Lorem.paragraph}
    user
    review
  end
end
