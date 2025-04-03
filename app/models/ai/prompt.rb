module AI
  class Prompt < ApplicationRecord
    validates :title, presence: true
    validates :content, presence: true
    validates :response_format, length: { minimum: 0, allow_blank: true, allow_nil: false }
    validates :additional_options, presence: { allow_blank: true, allow_nil: false }

    attribute :additional_options, :json, default: {}
  end
end
