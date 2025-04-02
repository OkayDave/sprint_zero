FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { 'password123' }
    confirmed_at { Time.current }

    trait :admin do
      role { 'admin' }
    end

    trait :standard do
      role { 'standard' }
    end
  end
end
