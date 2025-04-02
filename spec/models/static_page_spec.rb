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

    it 'is invalid without content' do
      static_page = build(:static_page, content: nil)
      expect(static_page).not_to be_valid
      expect(static_page.errors[:content]).to include("can't be blank")
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
  end

  describe 'factory' do
    it 'has a valid factory' do
      expect(build(:static_page)).to be_valid
    end
  end
end
