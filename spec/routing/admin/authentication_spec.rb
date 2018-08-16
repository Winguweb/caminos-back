require 'rails_helper'

RSpec.describe Admin::UserSessionsController, type: :routing do
  let(:routes_params){ { protocol: 'https' } }

  describe 'Authentication routable' do
    it { expect(get: '/admin/signin').to route_to( routes_params.merge(controller: 'admin/user_sessions', action: 'new') ) }
    it { expect(post: '/admin/signin').to route_to( routes_params.merge(controller: 'admin/user_sessions', action: 'create') ) }
    it { expect(post: '/admin/signout').to route_to( routes_params.merge(controller: 'admin/user_sessions', action: 'destroy') ) }
  end
end
