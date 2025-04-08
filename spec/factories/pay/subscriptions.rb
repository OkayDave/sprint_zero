FactoryBot.define do
  factory :pay_subscription, class: 'Pay::Subscription' do
    association :customer, factory: :pay_customer
    processor { 'stripe' }
    processor_id { "sub_#{SecureRandom.hex(10)}" }
    status { 'active' }
    current_period_start { Time.current }
    current_period_end { 1.month.from_now }
    trial_ends_at { nil }
    ends_at { nil }
    pause_starts_at { nil }
    pause_resumes_at { nil }
  end
end
