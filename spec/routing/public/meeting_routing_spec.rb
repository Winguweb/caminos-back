require 'rails_helper'

RSpec.describe MeetingsController, type: :routing do
  let(:routes_params){ { protocol: 'https', neighborhood_id: '1' } }

  describe 'Meeting NOT routable' do
    it { expect(get:    '/meetings').not_to be_routable }
    it { expect(get:    '/meetings/1').not_to be_routable }
    it { expect(post:   '/meetings').not_to be_routable }
    it { expect(post:   '/meetings/1').not_to be_routable }
    it { expect(put:    '/meetings/1').not_to be_routable }
    it { expect(delete: '/meetings/1').not_to be_routable }
    it { expect(patch:  '/meetings/1').not_to be_routable }
  end

  describe 'Meeting nested NOT routable' do
    it { expect(post:   '/neighborhoods/1/meetings').not_to be_routable }
    it { expect(get:    '/neighborhoods/1/meetings/1/edit').not_to be_routable }
    it { expect(patch:  '/neighborhoods/1/meetings/1').not_to be_routable }
    it { expect(put:    '/neighborhoods/1/meetings/1').not_to be_routable }
    it { expect(delete: '/neighborhoods/1/meetings/1').not_to be_routable }
  end

  describe 'Meeting nested routable' do
    it { expect(get: '/neighborhoods/1/meetings').to route_to( routes_params.merge(controller: 'meetings', action: 'index') ) }
    it { expect(get: '/neighborhoods/1/meetings/1').to route_to( routes_params.merge(controller: 'meetings', action: 'show', id: '1') ) }
  end
end
