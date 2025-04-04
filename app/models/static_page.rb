class StaticPage < ApplicationRecord
  include HasAIContent

  has_rich_text :content

  validates :title, presence: true
  validates :requires_sign_in, inclusion: { in: [ true, false ] }
end
