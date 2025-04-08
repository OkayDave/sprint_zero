require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { is_expected.to validate_inclusion_of(:role).in_array(%w[admin standard]) }
    it { is_expected.to_not allow_value(nil).for(:role) }
  end

  describe 'role methods' do
    it 'correctly identifies admin role' do
      user = build(:user, role: 'admin')
      expect(user.admin?).to be true
    end

    it 'correctly identifies standard role' do
      user = build(:user, role: 'standard')
      expect(user.standard?).to be true
    end
  end

  describe 'payment processor integration' do
    let(:user) { create(:user) }

    it 'includes the pay_customer module' do
      expect(User.included_modules).to include(Pay::Attributes)
    end

    it 'has a default payment processor of stripe' do
      expect(user.payment_processor).to be_a(Pay::Customer)
    end

    describe '#active_subscription?' do
      context 'when user has no subscription' do
        before do
          allow(user.payment_processor).to receive(:subscription).and_return(nil)
        end

        it 'returns false' do
          expect(user.active_subscription?).to be false
        end
      end

      context 'when user has an inactive subscription' do
        before do
          subscription = instance_double('Pay::Subscription', status: 'canceled')
          allow(user.payment_processor).to receive(:subscription).and_return(subscription)
        end

        it 'returns false' do
          expect(user.active_subscription?).to be false
        end
      end

      context 'when user has an active subscription' do
        before do
          subscription = instance_double('Pay::Subscription', status: 'active')
          allow(user.payment_processor).to receive(:subscription).and_return(subscription)
        end

        it 'returns true' do
          expect(user.active_subscription?).to be true
        end
      end
    end
  end
end
