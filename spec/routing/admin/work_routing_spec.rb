require 'rails_helper'

RSpec.describe Admin::WorksController, type: :routing do
  let(:routes_params){ { protocol: 'https', neighborhood_id: '1' } }

  describe 'Work REST routeable' do
    it { expect(get: '/admin/neighborhoods/1/works').to route_to( routes_params.merge(controller: 'admin/works', action: 'index') ) }
    it { expect(get: '/admin/neighborhoods/1/works/new').to route_to( routes_params.merge(controller: 'admin/works', action: 'new') ) }
    it { expect(post: '/admin/neighborhoods/1/works').to route_to( routes_params.merge(controller: 'admin/works', action: 'create') ) }
    it { expect(get: '/admin/neighborhoods/1/works/1').to route_to( routes_params.merge(controller: 'admin/works', action: 'show', id: '1') ) }
    it { expect(get: '/admin/neighborhoods/1/works/1/edit').to route_to( routes_params.merge(controller: 'admin/works', action: 'edit', id: '1') ) }
    it { expect(patch: '/admin/neighborhoods/1/works/1').to route_to( routes_params.merge(controller: 'admin/works', action: 'update', id: '1') ) }
    it { expect(put: '/admin/neighborhoods/1/works/1').to route_to( routes_params.merge(controller: 'admin/works', action: 'update', id: '1') ) }
    it { expect(delete: '/admin/neighborhoods/1/works/1').to route_to( routes_params.merge(controller: 'admin/works', action: 'destroy', id: '1') ) }
  end
end
