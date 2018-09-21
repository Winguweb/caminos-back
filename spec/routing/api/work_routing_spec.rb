require 'rails_helper'

RSpec.describe Api::WorksController, type: :routing do
  let(:routes_params){ { protocol: 'https', neighborhood_id: '1' } }

  describe 'Api Work nested resources routable' do
    it { expect(get: '/api/neighborhoods/1/works/status').to route_to( routes_params.merge(controller: 'api/works', action: 'index') ) }
    it { expect(get: '/api/neighborhoods/1/works/status/1').to route_to( routes_params.merge(controller: 'api/works', action: 'by_status', status: '1') ) }
  end
end
