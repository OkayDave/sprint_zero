module HasAIContent
  extend ActiveSupport::Concern

  included do
    attribute :prompt_additions, :string, default: ""
    attribute :generate_content_on_create, :boolean, default: false
    attribute :prompt_id, :integer

    after_create ->(record) { record.generate_ai_content if record.generate_content_on_create }

    validates :prompt_id, presence: true, if: :generate_content_on_create
    validates :prompt_additions, presence: true, if: :generate_content_on_create
  end

  def generate_ai_content
    AI::GenerateFromPromptJob.perform_later(prompt_id, self)
  end
end
