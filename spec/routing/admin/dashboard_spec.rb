require 'rails_helper'

RSpec.describe Admin::DashboardsController, type: :routing do
  let(:routes_params){ { protocol: 'https' } }

  describe 'Authentication routable' do
    it { expect(get: '/admin/dashboard').to route_to( routes_params.merge(controller: 'admin/dashboards', action: 'show') ) }
  end
end
