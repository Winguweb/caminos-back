require 'rails_helper'

RSpec.describe NeighborhoodsController, type: :routing do
  let(:routes_params){ { protocol: 'https' } }

  describe 'Neighborhood NOT routable' do
    it { expect(post:   '/neighborhoods').not_to be_routable }
    it { expect(get:    '/neighborhoods/1/edit').not_to be_routable }
    it { expect(patch:  '/neighborhoods/1').not_to be_routable }
    it { expect(put:    '/neighborhoods/1').not_to be_routable }
    it { expect(delete: '/neighborhoods/1').not_to be_routable }
  end

  describe 'Neighborhood resources routable' do
    it { expect(get: '/neighborhoods').to route_to( routes_params.merge(controller: 'neighborhoods', action: 'index') ) }
    it { expect(get: '/neighborhoods/1').to route_to( routes_params.merge(controller: 'neighborhoods', action: 'show', id: '1') ) }
    it { expect(get: '/neighborhoods/1/about').to route_to( routes_params.merge(controller: 'neighborhoods', action: 'about', id: '1') ) }
  end
end
