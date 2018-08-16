require 'rails_helper'

RSpec.describe WorksController, type: :routing do
  let(:routes_params){ { protocol: 'https', neighborhood_id: '1' } }

  describe 'Work NOT routeable' do
    it { expect(get: '/works').not_to be_routable }
    it { expect(get: '/works/1').not_to be_routable }
    it { expect(post: '/works').not_to be_routable }
    it { expect(post: '/works/1').not_to be_routable }
    it { expect(put: '/works/1').not_to be_routable }
    it { expect(delete: '/works/1').not_to be_routable }
    it { expect(patch: '/works/1').not_to be_routable }
  end

  describe 'Work nested NOT routeable' do
    it { expect(get: 'neighborhoods/1/works').not_to be_routable }
    it { expect(post: 'neighborhoods/1/works').not_to be_routable }
    it { expect(get: 'neighborhoods/1/works/1/edit').not_to be_routable }
    it { expect(patch: 'neighborhoods/1/works/1').not_to be_routable }
    it { expect(put: 'neighborhoods/1/works/1').not_to be_routable }
    it { expect(delete: 'neighborhoods/1/works/1').not_to be_routable }
  end

  describe 'Work nested resources routeable' do
    it { expect(get: '/neighborhoods/1/works/1').to route_to( routes_params.merge(controller: 'works', action: 'show', id: '1') ) }
  end
end
