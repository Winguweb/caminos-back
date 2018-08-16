require 'rails_helper'

RSpec.describe AgreementsController, type: :routing do
  let(:routes_params){ { protocol: 'https' } }

  describe 'Agreement NOT routeable' do
    it { expect(get: '/agreements').not_to be_routable }
    it { expect(get: '/agreements/1').not_to be_routable }
    it { expect(post: '/agreements').not_to be_routable }
    it { expect(post: '/agreements/1').not_to be_routable }
    it { expect(put: '/agreements/1').not_to be_routable }
    it { expect(delete: '/agreements/1').not_to be_routable }
    it { expect(patch: '/agreements/1').not_to be_routable }
  end

  describe 'Agreement nested NOT routeable' do
    it { expect(get: '/neighborhoods/1/agreements').not_to be_routable }
    it { expect(post: '/neighborhoods/1/agreements').not_to be_routable }
    it { expect(get: '/neighborhoods/1/agreements/1').not_to be_routable }
    it { expect(get: '/neighborhoods/1/agreements/1/edit').not_to be_routable }
    it { expect(patch: '/neighborhoods/1/agreements/1').not_to be_routable }
    it { expect(put: '/neighborhoods/1/agreements/1').not_to be_routable }
    it { expect(delete: '/neighborhoods/1/agreements/1').not_to be_routable }
  end

  describe 'Agreement nested routeable' do
    it { expect(get: '/neighborhoods/1/agreement').to route_to( routes_params.merge(controller: 'neighborhoods', action: 'agreement', id: '1') ) }
  end

end
