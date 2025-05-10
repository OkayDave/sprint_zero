FactoryBot.define do
  factory :pay_customer, class: 'Pay::Customer' do
    association :owner, factory: :user
    processor { 'stripe' }
    processor_id { "cus_#{SecureRandom.hex(10)}" }
  end
end
