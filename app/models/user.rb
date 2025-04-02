class User < ApplicationRecord
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
end
