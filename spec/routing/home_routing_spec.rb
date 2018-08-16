require 'rails_helper'

RSpec.describe HomeController, type: :routing do
  let(:routes_params){ { protocol: 'https' } }

  describe 'home routeable' do
    it { expect(get: '/').to route_to( routes_params.merge(controller: 'home', action: 'show') ) }
  end
end
