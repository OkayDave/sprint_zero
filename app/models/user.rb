class User < ApplicationRecord
  pay_customer default_payment_processor: :stripe

  attribute :role, :string, default: "standard"

  # Include Devise modules
  devise :confirmable,
         :database_authenticatable,
         :recoverable,
         :registerable,
         :rememberable,
         :validatable

  ROLES = %w[admin standard].freeze

  validates :role, inclusion: { in: ROLES }, allow_nil: true

  def admin?
    role == "admin"
  end

  def standard?
    role == "standard"
  end

  def active_subscription?
    @active_subscription ||= payment_processor.subscription.present? && payment_processor.subscription.status == "active"
  end
end
