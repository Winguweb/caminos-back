require 'rails_helper'

RSpec.describe NeighborhoodsController, type: :routing do
  let(:routes_params){ { protocol: 'https' } }

  describe 'Neighborhood NOT routable' do
    it { expect(post:   '/barrios').not_to be_routable }
    it { expect(get:    '/barrios/1/edit').not_to be_routable }
    it { expect(patch:  '/barrios/1').not_to be_routable }
    it { expect(put:    '/barrios/1').not_to be_routable }
    it { expect(delete: '/barrios/1').not_to be_routable }
  end

  describe 'Neighborhood resources routable' do
    it { expect(get: '/barrios').to route_to( routes_params.merge(controller: 'neighborhoods', action: 'index') ) }
    it { expect(get: '/barrios/1').to route_to( routes_params.merge(controller: 'neighborhoods', action: 'show', id: '1') ) }
    it { expect(get: '/barrios/1/acerca-del-barrio').to route_to( routes_params.merge(controller: 'neighborhoods', action: 'about', id: '1') ) }
  end
end
