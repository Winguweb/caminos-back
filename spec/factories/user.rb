FactoryBot.define do
  factory :user do
    username { Faker::Internet.user_name }
    email { Faker::Internet.free_email }
    password { Faker::Internet.password }
    entity { create(:organization) }

    trait :with_profile do
      after(:create) do |user, evaluator|
        create(:profile, user: user)
      end
    end

    trait :approved do
      active { true }
      approved { true }
      confirmed { true }
    end

    factory :user_with_profile, traits: [ :with_profile ]

    factory :responsible do
      with_profile
      approved
      roles [ :responsible ]
    end

    factory :admin do
      with_profile
      approved
      roles [ :admin ]
    end
  end
end
