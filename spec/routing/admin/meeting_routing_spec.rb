require 'rails_helper'

RSpec.describe Admin::MeetingsController, type: :routing do
  let(:routes_params){ { protocol: 'https' } }

  describe 'Meeting REST routeable' do
    it { expect(get: '/admin/neighborhoods/1/meetings').to route_to( routes_params.merge(controller: 'admin/meetings', action: 'index', neighborhood_id: '1') ) }
    it { expect(get: '/admin/neighborhoods/1/meetings/new').to route_to( routes_params.merge(controller: 'admin/meetings', action: 'new', neighborhood_id: '1') ) }
    it { expect(post: '/admin/neighborhoods/1/meetings').to route_to( routes_params.merge(controller: 'admin/meetings', action: 'create', neighborhood_id: '1') ) }
    it { expect(get: '/admin/neighborhoods/1/meetings/1').to route_to( routes_params.merge(controller: 'admin/meetings', action: 'show', neighborhood_id: '1', id: '1') ) }
    it { expect(get: '/admin/neighborhoods/1/meetings/1/edit').to route_to( routes_params.merge(controller: 'admin/meetings', action: 'edit', neighborhood_id: '1', id: '1') ) }
    it { expect(patch: '/admin/neighborhoods/1/meetings/1').to route_to( routes_params.merge(controller: 'admin/meetings', action: 'update', neighborhood_id: '1', id: '1') ) }
    it { expect(put: '/admin/neighborhoods/1/meetings/1').to route_to( routes_params.merge(controller: 'admin/meetings', action: 'update', neighborhood_id: '1', id: '1') ) }
    it { expect(delete: '/admin/neighborhoods/1/meetings/1').to route_to( routes_params.merge(controller: 'admin/meetings', action: 'destroy', neighborhood_id: '1', id: '1') ) }
  end
end
