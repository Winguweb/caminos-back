require 'rails_helper'

RSpec.describe WorksController, type: :routing do
  let(:routes_params){ { protocol: 'https', neighborhood_id: '1' } }

  describe 'Work NOT routable' do
    it { expect(get:    '/obras').not_to be_routable }
    it { expect(get:    '/obras/1').not_to be_routable }
    it { expect(post:   '/obras').not_to be_routable }
    it { expect(post:   '/obras/1').not_to be_routable }
    it { expect(put:    '/obras/1').not_to be_routable }
    it { expect(delete: '/obras/1').not_to be_routable }
    it { expect(patch:  '/obras/1').not_to be_routable }
  end

  describe 'Work nested NOT routable' do
    it { expect(get:    'barrios/1/obras').not_to be_routable }
    it { expect(post:   'barrios/1/obras').not_to be_routable }
    it { expect(get:    'barrios/1/obras/1/edit').not_to be_routable }
    it { expect(patch:  'barrios/1/obras/1').not_to be_routable }
    it { expect(put:    'barrios/1/obras/1').not_to be_routable }
    it { expect(delete: 'barrios/1/obras/1').not_to be_routable }
  end

  describe 'Work nested resources routable' do
    it { expect(get: '/barrios/1/obras/1').to route_to( routes_params.merge(controller: 'works', action: 'show', id: '1') ) }
  end
end
