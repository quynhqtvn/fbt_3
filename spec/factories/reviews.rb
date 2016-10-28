FactoryGirl.define do
  factory :review do
    title {Faker::Name.title}
    content {Faker::Lorem.paragraph}
    category_review
    user
  end
end
