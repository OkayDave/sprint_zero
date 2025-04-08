FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { 'P@ssword123' }
    password_confirmation { 'P@ssword123' }
    confirmed_at { Time.current }
    role { 'standard' }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }

    trait :admin do
      role { 'admin' }
    end
  end
end
