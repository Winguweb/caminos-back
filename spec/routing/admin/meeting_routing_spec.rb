require 'rails_helper'

RSpec.describe Admin::MeetingsController, type: :routing do
  let(:routes_params){ { protocol: 'https', neighborhood_id: '1' } }

  describe 'Meeting REST routeable' do
    it { expect(get: '/admin/neighborhoods/1/meetings').to route_to( routes_params.merge(controller: 'admin/meetings', action: 'index') ) }
    it { expect(get: '/admin/neighborhoods/1/meetings/new').to route_to( routes_params.merge(controller: 'admin/meetings', action: 'new') ) }
    it { expect(post: '/admin/neighborhoods/1/meetings').to route_to( routes_params.merge(controller: 'admin/meetings', action: 'create') ) }
    it { expect(get: '/admin/neighborhoods/1/meetings/1').to route_to( routes_params.merge(controller: 'admin/meetings', action: 'show', id: '1') ) }
    it { expect(get: '/admin/neighborhoods/1/meetings/1/edit').to route_to( routes_params.merge(controller: 'admin/meetings', action: 'edit', id: '1') ) }
    it { expect(patch: '/admin/neighborhoods/1/meetings/1').to route_to( routes_params.merge(controller: 'admin/meetings', action: 'update', id: '1') ) }
    it { expect(put: '/admin/neighborhoods/1/meetings/1').to route_to( routes_params.merge(controller: 'admin/meetings', action: 'update', id: '1') ) }
    it { expect(delete: '/admin/neighborhoods/1/meetings/1').to route_to( routes_params.merge(controller: 'admin/meetings', action: 'destroy', id: '1') ) }
  end
end
