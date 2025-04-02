FactoryBot.define do
  factory :static_page do
    title { Faker::Lorem.sentence }
    content { Faker::Lorem.paragraphs(number: 3).join("\n\n") }
    requires_sign_in { false }
  end
end
