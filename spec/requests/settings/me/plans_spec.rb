require 'rails_helper'

RSpec.describe "Settings::Me::Plans", type: :request do
  let(:user) { create(:user) }
  let(:plans) { Settings::Me::PlansController::PLANS }

  before do
    sign_in user
  end

  describe "GET /settings/me/plans" do
    context "when user has no subscription" do
      before do
        allow(user.payment_processor).to receive(:sync_subscriptions)
        allow(user.payment_processor).to receive(:subscription).and_return(nil)
        allow(user.payment_processor).to receive(:billing_portal).and_return(
          instance_double('Pay::BillingPortal', url: 'https://billing.stripe.com/portal')
        )
      end

      it "returns a successful response" do
        get settings_me_plans_path
        expect(response).to be_successful
      end

      it "syncs subscriptions" do
        expect(user.payment_processor).to receive(:sync_subscriptions).with(status: "all")
        get settings_me_plans_path
      end

      it "displays subscription status and plans" do
        get settings_me_plans_path
        expect(response.body).to include("You don't have an active subscription")
        expect(response.body).to include("Upgrade to PRO")

        plans.each do |_plan_id, plan|
          expect(response.body).to include("#{plan[:name]} - £#{plan[:price]}")
        end
      end
    end

    context "when user has an active subscription" do
      let(:subscription) { instance_double('Pay::Subscription', status: 'active') }

      before do
        allow(user.payment_processor).to receive(:sync_subscriptions)
        allow(user.payment_processor).to receive(:subscription).and_return(subscription)
        allow(user.payment_processor).to receive(:billing_portal).and_return(
          instance_double('Pay::BillingPortal', url: 'https://billing.stripe.com/portal')
        )
      end

      it "returns a successful response" do
        get settings_me_plans_path
        expect(response).to be_successful
      end

      it "displays subscription status and management options" do
        get settings_me_plans_path
        expect(response.body).to include("You have an active subscription")
        expect(response.body).to include("Manage Subscription")
        expect(response.body).to include("https://billing.stripe.com/portal")
      end
    end
  end

  describe "POST /settings/me/plans" do
    context "with a valid plan" do
      let(:plan_id) { "pro_monthly" }
      let(:checkout) { instance_double('Pay::Checkout', url: 'https://checkout.stripe.com/checkout') }

      before do
        allow(user.payment_processor).to receive(:checkout).and_return(checkout)
      end

      it "creates a checkout session" do
        expect(user.payment_processor).to receive(:checkout).with(
          mode: "subscription",
          locale: I18n.locale,
          line_items: [ { price: plans[plan_id]["price_id"], quantity: 1 } ],
          success_url: settings_me_plans_url,
          cancel_url: settings_me_plans_url
        ).and_return(checkout)

        post settings_me_plans_path, params: { plan_id: plan_id }
      end

      it "redirects to the checkout URL" do
        post settings_me_plans_path, params: { plan_id: plan_id }
        expect(response).to redirect_to('https://checkout.stripe.com/checkout')
      end
    end

    context "with an invalid plan" do
      it "sets a flash alert" do
        post settings_me_plans_path, params: { plan_id: "invalid_plan" }
        expect(flash[:alert]).to eq("Invalid plan")
      end

      it "redirects to the plans page" do
        post settings_me_plans_path, params: { plan_id: "invalid_plan" }
        expect(response).to redirect_to(settings_me_plans_path)
      end
    end
  end
end
