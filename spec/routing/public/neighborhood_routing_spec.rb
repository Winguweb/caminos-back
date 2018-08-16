require 'rails_helper'

RSpec.describe NeighborhoodsController, type: :routing do
  let(:routes_params){ { protocol: 'https' } }

  describe 'Neighborhood NOT routeable' do
    it { expect(get: '/neighborhoods').not_to be_routable }
    it { expect(post: '/neighborhoods').not_to be_routable }
    it { expect(get: '/neighborhoods/1/edit').not_to be_routable }
    it { expect(patch: '/neighborhoods/1').not_to be_routable }
    it { expect(put: '/neighborhoods/1').not_to be_routable }
    it { expect(delete: '/neighborhoods/1').not_to be_routable }
  end

  describe 'Neighborhood resources routeable' do
    it { expect(get: '/neighborhoods/1').to route_to( routes_params.merge(controller: 'neighborhoods', action: 'show', id: '1') ) }
    it { expect(get: '/neighborhoods/1/agreement').to route_to( routes_params.merge(controller: 'neighborhoods', action: 'agreement', id: '1') ) }
    it { expect(get: '/neighborhoods/1/about').to route_to( routes_params.merge(controller: 'neighborhoods', action: 'about', id: '1') ) }
    it { expect(get: '/neighborhoods/1/works/1').to route_to( routes_params.merge(controller: 'works', action: 'show', neighborhood_id: '1', id: '1') ) }
    it { expect(get: '/neighborhoods/1/meetings').to route_to( routes_params.merge(controller: 'meetings', action: 'index', neighborhood_id: '1') ) }
    it { expect(get: '/neighborhoods/1/meetings/1').to route_to( routes_params.merge(controller: 'meetings', action: 'show', neighborhood_id: '1', id: '1') ) }
  end
end
