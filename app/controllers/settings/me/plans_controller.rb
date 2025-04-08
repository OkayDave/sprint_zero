module Settings
  module Me
    class PlansController < ApplicationController
      before_action :authenticate_user!
      PLANS = HashWithIndifferentAccess.new({
        "pro_monthly" => {
          "price_id" => "price_1RB8uk2hdGNtxWYlO7YhVEgNp",
          "name" => "Pro Monthly",
          "price" => 9
        },
        "pro_yearly" => {
          "price_id" => "price_1RBAQE2hdGNtxWYlMh890dxv",
          "name" => "Pro Yearly",
          "price" => 99
        }
      })

      def index
        current_user.payment_processor.sync_subscriptions(status: "all")

        @plans = PLANS
        @stripe_customer_portal_url = current_user.payment_processor.billing_portal.url
        @subscription = current_user.payment_processor.subscription
      end

      def create
        plan = PLANS[params[:plan_id]]

        if plan.nil?
          flash[:alert] = "Invalid plan"
          return redirect_to settings_me_plans_path
        end

        @checkout = current_user.payment_processor.checkout(
          mode: "subscription",
          locale: I18n.locale,
          line_items: [ {
            price: plan["price_id"],
            quantity: 1
          } ],
          success_url: settings_me_plans_url,
          cancel_url: settings_me_plans_url
        )

        redirect_to @checkout.url, allow_other_host: true, status: :see_other
      end
    end
  end
end
