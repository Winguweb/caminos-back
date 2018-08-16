require 'rails_helper'

RSpec.describe Admin::AgreementsController, type: :routing do
  let(:routes_params){ { protocol: 'https', neighborhood_id: '1' } }

  describe 'Agreement NOT routable' do
    it { expect(get: '/admin/neighborhoods/1/agreement/1').not_to be_routable }
    it { expect(delete: '/admin/neighborhoods/1/agreement').not_to be_routable }
    it { expect(delete: '/admin/neighborhoods/1/agreement/1').not_to be_routable }
    it { expect(patch: '/admin/neighborhoods/1/agreement/1').not_to be_routable }
    it { expect(put: '/admin/neighborhoods/1/agreement/1').not_to be_routable }
  end

  describe 'Agreement REST routable' do
    it { expect(get: '/admin/neighborhoods/1/agreement').to route_to( routes_params.merge(controller: 'admin/agreements', action: 'show') ) }
    it { expect(get: '/admin/neighborhoods/1/agreement/new').to route_to( routes_params.merge(controller: 'admin/agreements', action: 'new') ) }
    it { expect(post: '/admin/neighborhoods/1/agreement').to route_to( routes_params.merge(controller: 'admin/agreements', action: 'create') ) }
    it { expect(get: '/admin/neighborhoods/1/agreement/edit').to route_to( routes_params.merge(controller: 'admin/agreements', action: 'edit') ) }
    it { expect(patch: '/admin/neighborhoods/1/agreement').to route_to( routes_params.merge(controller: 'admin/agreements', action: 'update') ) }
    it { expect(put: '/admin/neighborhoods/1/agreement').to route_to( routes_params.merge(controller: 'admin/agreements', action: 'update') ) }
  end
end
