
Pay.setup do |config|
  # For use in the receipt/refund/renewal mailers
  config.business_name = "SprintZero"
  config.application_name = "SprintZero"
  config.support_email = "SprintZero <support@example.com>"

  config.default_product_name = "default"
  config.default_plan_name = "default"

  config.automount_routes = true
  config.routes_path = "/pay" # Only when automount_routes is true

  config.enabled_processors = [ :stripe ]

  # To disable all emails, set the following configuration option to false:
  config.send_emails = true

  # This example for subscription_renewing only applies to Stripe, therefore we supply the second argument of price
  config.emails.subscription_renewing = ->(pay_subscription, price) {
    (price&.type == "recurring") && (price.recurring&.interval == "year")
  }
end
