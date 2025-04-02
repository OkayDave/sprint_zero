class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable

  ROLES = %w[admin standard].freeze

  validates :role, inclusion: { in: ROLES }, allow_nil: true

  def admin?
    role == "admin"
  end

  def standard?
    role == "standard"
  end
end
