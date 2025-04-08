require 'rails_helper'

RSpec.describe StaticPagePolicy do
  let(:admin) { create(:user, :admin) }
  let(:standard_user) { create(:user) }

  context 'being an admin' do
    subject { described_class.new(admin, StaticPage) }

    it { is_expected.to permit_action(:index) }
    it { is_expected.to permit_action(:show) }
  end

  context 'being a standard user' do
    subject { described_class.new(standard_user, StaticPage) }

    it { is_expected.to forbid_action(:index) }
    it { is_expected.to permit_action(:show) }
  end

  context 'being a guest user' do
    subject { described_class.new(nil, StaticPage) }

    it { is_expected.to forbid_action(:index) }
    it { is_expected.to permit_action(:show) }
  end
end
