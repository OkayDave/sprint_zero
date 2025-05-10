require 'rails_helper'

RSpec.describe Settings::Me::PlansController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/settings/me/plans').to route_to('settings/me/plans#index')
    end

    it 'routes to #create' do
      expect(post: '/settings/me/plans').to route_to('settings/me/plans#create')
    end
  end
end
