require 'rails_helper'

RSpec.describe AI::Prompt, type: :model do
  describe 'validations' do
    it 'is valid with a title and content' do
      prompt = build(:ai_prompt, title: 'Test Prompt', content: 'Test content')
      expect(prompt).to be_valid
    end

    it 'is invalid without a title' do
      prompt = build(:ai_prompt, title: nil)
      expect(prompt).not_to be_valid
      expect(prompt.errors[:title]).to include("can't be blank")
    end

    it 'is invalid without content' do
      prompt = build(:ai_prompt, content: nil)
      expect(prompt).not_to be_valid
      expect(prompt.errors[:content]).to include("can't be blank")
    end
  end
end
