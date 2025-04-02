require 'rails_helper'

RSpec.describe UserPolicy do
  let(:admin) { create(:user, :admin) }
  let(:standard_user) { create(:user, :standard) }
  let(:other_user) { create(:user, :standard) }

  context 'being an admin' do
    subject { described_class.new(admin, User) }

    it { is_expected.to permit_action(:index) }
    it { is_expected.to permit_action(:show) }
    it { is_expected.to permit_action(:create) }
    it { is_expected.to permit_action(:update) }
    it { is_expected.to permit_action(:destroy) }
  end

  context 'being a standard user' do
    subject { described_class.new(standard_user, User) }

    it { is_expected.to forbid_action(:index) }
    it { is_expected.to forbid_action(:create) }
    it { is_expected.to forbid_action(:destroy) }

    context 'when accessing own record' do
      let(:record) { standard_user }
      subject { described_class.new(standard_user, record) }

      it { is_expected.to permit_action(:show) }
      it { is_expected.to permit_action(:update) }
    end

    context 'when accessing another user record' do
      let(:record) { other_user }
      subject { described_class.new(standard_user, record) }

      it { is_expected.to forbid_action(:show) }
      it { is_expected.to forbid_action(:update) }
    end
  end

  describe 'scope' do
    before do
      @user1 = create(:user, :standard)
      @user2 = create(:user, :standard)
      @admin = create(:user, :admin)
    end

    it 'shows all users to admin' do
      scope = Pundit.policy_scope!(@admin, User)
      expect(scope.count).to eq(3)
    end

    it 'shows only themselves to standard users' do
      scope = Pundit.policy_scope!(@user1, User)
      expect(scope.count).to eq(1)
      expect(scope.first).to eq(@user1)
    end
  end
end
