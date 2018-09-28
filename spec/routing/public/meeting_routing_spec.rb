require 'rails_helper'

RSpec.describe MeetingsController, type: :routing do
  let(:routes_params){ { protocol: 'https', neighborhood_id: '1' } }

  describe 'Meeting NOT routable' do
    it { expect(get:    '/reuniones').not_to be_routable }
    it { expect(get:    '/reuniones/1').not_to be_routable }
    it { expect(post:   '/reuniones').not_to be_routable }
    it { expect(post:   '/reuniones/1').not_to be_routable }
    it { expect(put:    '/reuniones/1').not_to be_routable }
    it { expect(delete: '/reuniones/1').not_to be_routable }
    it { expect(patch:  '/reuniones/1').not_to be_routable }
  end

  describe 'Meeting nested NOT routable' do
    it { expect(post:   '/barrios/1/reuniones').not_to be_routable }
    it { expect(get:    '/barrios/1/reuniones/1/edit').not_to be_routable }
    it { expect(patch:  '/barrios/1/reuniones/1').not_to be_routable }
    it { expect(put:    '/barrios/1/reuniones/1').not_to be_routable }
    it { expect(delete: '/barrios/1/reuniones/1').not_to be_routable }
  end

  describe 'Meeting nested routable' do
    it { expect(get: '/barrios/1/reuniones').to route_to( routes_params.merge(controller: 'meetings', action: 'index') ) }
    it { expect(get: '/barrios/1/reuniones/1').to route_to( routes_params.merge(controller: 'meetings', action: 'show', id: '1') ) }
  end
end
