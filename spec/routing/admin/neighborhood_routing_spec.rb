require 'rails_helper'

RSpec.describe Admin::NeighborhoodsController, type: :routing do
  let(:routes_params){ { protocol: 'https' } }

  describe 'Neighborhood REST routeable' do
    it { expect(get: '/admin/neighborhoods').to route_to( routes_params.merge(controller: 'admin/neighborhoods', action: 'index') ) }
    it { expect(get: '/admin/neighborhoods/new').to route_to( routes_params.merge(controller: 'admin/neighborhoods', action: 'new') ) }
    it { expect(post: '/admin/neighborhoods').to route_to( routes_params.merge(controller: 'admin/neighborhoods', action: 'create') ) }
    it { expect(get: '/admin/neighborhoods/1').to route_to( routes_params.merge(controller: 'admin/neighborhoods', action: 'show', id: '1') ) }
    it { expect(get: '/admin/neighborhoods/1/edit').to route_to( routes_params.merge(controller: 'admin/neighborhoods', action: 'edit', id: '1') ) }
    it { expect(patch: '/admin/neighborhoods/1').to route_to( routes_params.merge(controller: 'admin/neighborhoods', action: 'update', id: '1') ) }
    it { expect(put: '/admin/neighborhoods/1').to route_to( routes_params.merge(controller: 'admin/neighborhoods', action: 'update', id: '1') ) }
    it { expect(delete: '/admin/neighborhoods/1').to route_to( routes_params.merge(controller: 'admin/neighborhoods', action: 'destroy', id: '1') ) }
  end
end
