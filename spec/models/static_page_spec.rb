require 'rails_helper'

RSpec.describe StaticPage, type: :model do
  describe 'validations' do
    it 'is valid with valid attributes' do
      expect(build(:static_page)).to be_valid
    end

    it 'is invalid without a title' do
      static_page = build(:static_page, title: nil)
      expect(static_page).not_to be_valid
      expect(static_page.errors[:title]).to include("can't be blank")
    end

    it 'is invalid with nil requires_sign_in' do
      static_page = build(:static_page, requires_sign_in: nil)
      expect(static_page).not_to be_valid
      expect(static_page.errors[:requires_sign_in]).to include("is not included in the list")
    end

    it 'is valid with true or false for requires_sign_in' do
      expect(build(:static_page, requires_sign_in: true)).to be_valid
      expect(build(:static_page, requires_sign_in: false)).to be_valid
    end
  end

  describe 'associations' do
    it 'has rich text content' do
      static_page = create(:static_page)
      expect(static_page.content).to be_a(ActionText::RichText)
    end

    it 'can have rich text content assigned' do
      static_page = build(:static_page)
      static_page.content = ActionText::RichText.new(body: '<div>Test content</div>')
      expect(static_page.content.body.to_s).to include('Test content')
    end
  end

  describe 'HasAIContent concern' do
    it 'includes HasAIContent concern' do
      expect(described_class.ancestors).to include(HasAIContent)
    end

    it 'responds to HasAIContent methods' do
      static_page = build(:static_page)
      expect(static_page).to respond_to(:prompt_additions)
      expect(static_page).to respond_to(:prompt_additions=)
      expect(static_page).to respond_to(:generate_ai_content)
    end

    it 'has generate_content_on_create attribute with default value of false' do
      static_page = build(:static_page)
      expect(static_page.generate_content_on_create).to be false
    end

    it 'can set generate_content_on_create to true' do
      static_page = build(:static_page, generate_content_on_create: true)
      expect(static_page.generate_content_on_create).to be true
    end

    it 'enqueues AI::GenerateFromPromptJob when generate_ai_content is called' do
      static_page = build(:static_page)
      expect(AI::GenerateFromPromptJob).to receive(:perform_later).with(static_page.prompt_id, static_page)
      static_page.generate_ai_content
    end

    it 'automatically generates AI content after creation when generate_content_on_create is true' do
      static_page = build(:static_page, generate_content_on_create: true, prompt_id: create(:ai_prompt).id)
      expect(AI::GenerateFromPromptJob).to receive(:perform_later).with(static_page.prompt_id, static_page)
      static_page.save!
    end

    it 'does not generate AI content after creation when generate_content_on_create is false' do
      static_page = build(:static_page, generate_content_on_create: false)
      expect(AI::GenerateFromPromptJob).not_to receive(:perform_later)
      static_page.save!
    end

    it 'validates presence of prompt_id when generate_content_on_create is true' do
      static_page = build(:static_page, generate_content_on_create: true, prompt_id: nil)
      expect(static_page).not_to be_valid
      expect(static_page.errors[:prompt_id]).to include("can't be blank")
    end

    it 'does not validate presence of prompt_id when generate_content_on_create is false' do
      static_page = build(:static_page, generate_content_on_create: false, prompt_id: nil)
      expect(static_page).to be_valid
    end
  end

  describe 'factory' do
    it 'has a valid factory' do
      expect(build(:static_page)).to be_valid
    end

    it 'creates a static page with default values' do
      static_page = create(:static_page)

      expect(static_page.title).to be_present
      expect(static_page.requires_sign_in).to be_in([ true, false ])
    end
  end
end
