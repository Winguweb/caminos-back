require 'rails_helper'

RSpec.describe Admin::WorksController, type: :routing do
  let(:routes_params){ { protocol: 'https' } }

  describe 'Work REST routeable' do
    it { expect(get: '/admin/neighborhoods/1/works').to route_to( routes_params.merge(controller: 'admin/works', action: 'index', neighborhood_id: '1') ) }
    it { expect(get: '/admin/neighborhoods/1/works/new').to route_to( routes_params.merge(controller: 'admin/works', action: 'new', neighborhood_id: '1') ) }
    it { expect(post: '/admin/neighborhoods/1/works').to route_to( routes_params.merge(controller: 'admin/works', action: 'create', neighborhood_id: '1') ) }
    it { expect(get: '/admin/neighborhoods/1/works/1').to route_to( routes_params.merge(controller: 'admin/works', action: 'show', neighborhood_id: '1', id: '1') ) }
    it { expect(get: '/admin/neighborhoods/1/works/1/edit').to route_to( routes_params.merge(controller: 'admin/works', action: 'edit', neighborhood_id: '1', id: '1') ) }
    it { expect(patch: '/admin/neighborhoods/1/works/1').to route_to( routes_params.merge(controller: 'admin/works', action: 'update', neighborhood_id: '1', id: '1') ) }
    it { expect(put: '/admin/neighborhoods/1/works/1').to route_to( routes_params.merge(controller: 'admin/works', action: 'update', neighborhood_id: '1', id: '1') ) }
    it { expect(delete: '/admin/neighborhoods/1/works/1').to route_to( routes_params.merge(controller: 'admin/works', action: 'destroy', neighborhood_id: '1', id: '1') ) }
  end
end
