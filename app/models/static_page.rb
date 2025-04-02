class StaticPage < ApplicationRecord
  has_rich_text :content

  validates :title, presence: true
  validates :content, presence: true
  validates :requires_sign_in, inclusion: { in: [ true, false ] }
end
