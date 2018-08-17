FactoryBot.define do
  factory :organization do
    description { Faker::Lorem.sentence(50) }
    name { Faker::Name.name }
  end
end
