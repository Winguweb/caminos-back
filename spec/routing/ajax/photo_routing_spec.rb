require 'rails_helper'

RSpec.describe Admin::Ajax::PhotosController, type: :routing do
  describe 'Ajax Neighborhood Photos nested resources routable' do
    let(:routes_params){ { protocol: 'https', neighborhood_id: '1' } }
    it { expect(post:   '/admin/ajax/neighborhoods/1/photos/upload').to route_to( routes_params.merge(controller: 'admin/ajax/photos', action: 'upload') ) }
    it { expect(delete: '/admin/ajax/neighborhoods/1/photos/1').to route_to( routes_params.merge(controller: 'admin/ajax/photos', action: 'destroy', id: '1') ) }
  end

  describe 'Ajax Work Photos nested resources routable' do
    let(:routes_params){ { protocol: 'https', work_id: '1' } }
    it { expect(post:   '/admin/ajax/works/1/photos/upload').to route_to( routes_params.merge(controller: 'admin/ajax/photos', action: 'upload') ) }
    it { expect(delete: '/admin/ajax/works/1/photos/1').to route_to( routes_params.merge(controller: 'admin/ajax/photos', action: 'destroy', id: '1') ) }
  end
end
