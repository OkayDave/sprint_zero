module AI
  class GenerateFromPromptJob < ApplicationJob
    queue_as :default

    def perform(prompt_id, new_record)
      prompt = AI::Prompt.find(prompt_id)
      AI::ContentGenerator.new(prompt, new_record).call
    end
  end
end
