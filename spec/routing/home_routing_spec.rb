require 'rails_helper'

RSpec.describe HomeController, type: :routing do
  describe 'routing' do
    it 'routes root to home#show' do
      expect(get: '/').to route_to('home#show')
    end

    it 'routes /home to home#show' do
      expect(get: '/home').to route_to('home#show')
    end
  end
end
