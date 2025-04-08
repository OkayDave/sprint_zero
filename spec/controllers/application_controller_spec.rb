require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  controller do
    def index
      render plain: 'OK'
    end
  end

  describe '#stripe_enabled?' do
    before do
      routes.draw { get 'anonymous#index', to: 'anonymous#index' }
    end

    context 'when STRIPE_ENABLED is set to true' do
      before do
        allow(ENV).to receive(:fetch).with('STRIPE_ENABLED', 'false').and_return('true')
      end

      it 'returns true' do
        expect(controller.stripe_enabled?).to be true
      end

      it 'memoizes the result' do
        expect(ENV).to receive(:fetch).with('STRIPE_ENABLED', 'false').once.and_return('true')
        2.times { controller.stripe_enabled? }
      end
    end

    context 'when STRIPE_ENABLED is set to false' do
      before do
        allow(ENV).to receive(:fetch).with('STRIPE_ENABLED', 'false').and_return('false')
      end

      it 'returns false' do
        expect(controller.stripe_enabled?).to be false
      end
    end

    context 'when STRIPE_ENABLED is not set' do
      before do
        allow(ENV).to receive(:fetch).with('STRIPE_ENABLED', 'false').and_return('false')
      end

      it 'returns false' do
        expect(controller.stripe_enabled?).to be false
      end
    end
  end
end
