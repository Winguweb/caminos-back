require 'rails_helper'

RSpec.describe AgreementsController, type: :routing do
  let(:routes_params){ { protocol: 'https' } }

  describe 'Agreement NOT routable' do
    it { expect(get:    '/acuerdo').not_to be_routable }
    it { expect(get:    '/acuerdo/1').not_to be_routable }
    it { expect(post:   '/acuerdo').not_to be_routable }
    it { expect(post:   '/acuerdo/1').not_to be_routable }
    it { expect(put:    '/acuerdo/1').not_to be_routable }
    it { expect(delete: '/acuerdo/1').not_to be_routable }
    it { expect(patch:  '/acuerdo/1').not_to be_routable }
  end

  describe 'Agreement nested NOT routable' do
    it { expect(post:   '/barrios/1/acuerdo').not_to be_routable }
    it { expect(get:    '/barrios/1/acuerdo/1').not_to be_routable }
    it { expect(get:    '/barrios/1/acuerdo/1/edit').not_to be_routable }
    it { expect(patch:  '/barrios/1/acuerdo/1').not_to be_routable }
    it { expect(put:    '/barrios/1/acuerdo/1').not_to be_routable }
    it { expect(delete: '/barrios/1/acuerdo/1').not_to be_routable }
  end

  describe 'Agreement nested routable' do
    it { expect(get: '/barrios/1/acuerdo').to route_to( routes_params.merge(controller: 'agreements', action: 'show', id: '1')) }
  end
end
