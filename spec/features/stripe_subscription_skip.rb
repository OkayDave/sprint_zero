require 'rails_helper'

RSpec.describe 'Stripe Subscription', type: :feature do
  # let!(:stripe_helper) { StripeMock.create_test_helper }
  # before { StripeMock.start }
  # after { StripeMock.stop }

  let(:stripe_helper) { true }
  let!(:user) { create(:user) }
  let!(:plans) { Settings::Me::PlansController::PLANS }

  before do
    sign_in user
  end

  describe 'viewing subscription plans' do
    context 'when user has no subscription' do
      before do
        allow(user.payment_processor).to receive(:sync_subscriptions)
        allow(user.payment_processor).to receive(:subscription).and_return(nil)
        allow(user.payment_processor).to receive(:billing_portal).and_return(
          instance_double('Pay::BillingPortal', url: 'https://billing.stripe.com/portal')
        )
      end

      skip 'displays available plans' do
        visit settings_me_plans_path

        expect(page).to have_content("You don't have an active subscription")
        expect(page).to have_content("Upgrade to PRO")

        plans.each do |plan_id, plan|
          expect(page).to have_button("#{plan[:name]} - £#{plan[:price]}")
        end
      end
    end

    context 'when user has an active subscription' do
      let(:subscription) { instance_double('Pay::Subscription', status: 'active') }

      before do
        allow(user.payment_processor).to receive(:sync_subscriptions)
        allow(user.payment_processor).to receive(:subscription).and_return(subscription)
        allow(user.payment_processor).to receive(:billing_portal).and_return(
          instance_double('Pay::BillingPortal', url: 'https://billing.stripe.com/portal')
        )
      end

      skip 'displays subscription management options' do
        visit settings_me_plans_path

        expect(page).to have_content("You have an active subscription")
        expect(page).to have_link("Manage Subscription", href: 'https://billing.stripe.com/portal')
      end
    end
  end

  describe 'subscribing to a plan' do
    let(:plan_id) { "pro_monthly" }
    let(:checkout) { instance_double('Pay::Checkout', url: 'https://checkout.stripe.com/checkout') }

    before do
      allow(user.payment_processor).to receive(:sync_subscriptions)
      allow(user.payment_processor).to receive(:subscription).and_return(nil)
      allow(user.payment_processor).to receive(:billing_portal).and_return(
        instance_double('Pay::BillingPortal', url: 'https://billing.stripe.com/portal')
      )
      allow(user.payment_processor).to receive(:checkout).and_return(checkout)
    end

    skip 'redirects to Stripe checkout when selecting a plan' do
      visit settings_me_plans_path

      expect(user.payment_processor).to receive(:checkout).with(
        mode: "subscription",
        locale: I18n.locale,
        line_items: [ { price: plans[plan_id]["price_id"], quantity: 1 } ],
        success_url: settings_me_plans_url,
        cancel_url: settings_me_plans_url
      ).and_return(checkout)

      click_button "#{plans[plan_id][:name]} - £#{plans[plan_id][:price]}"

      # In a real test, we would be redirected to Stripe, but in our test environment
      # we're just verifying that the checkout method was called with the right parameters
    end
  end
end
