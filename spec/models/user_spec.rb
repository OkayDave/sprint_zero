require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it 'validates role inclusion' do
      user = build(:user, role: 'invalid_role')
      expect(user).not_to be_valid
      expect(user.errors[:role]).to include('is not included in the list')
    end

    it 'allows nil role' do
      user = build(:user, role: nil)
      expect(user).to be_valid
    end
  end

  describe 'role methods' do
    it 'correctly identifies admin role' do
      admin = build(:user, role: 'admin')
      expect(admin.admin?).to be true
      expect(admin.standard?).to be false
    end

    it 'correctly identifies standard role' do
      standard = build(:user, role: 'standard')
      expect(standard.admin?).to be false
      expect(standard.standard?).to be true
    end
  end
end
