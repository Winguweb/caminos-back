require 'rails_helper'

RSpec.describe Admin::Ajax::DocumentsController, type: :routing do
  describe 'Ajax Neighborhood Documents nested resources routable' do
    let(:routes_params){ { protocol: 'https', neighborhood_id: '1' } }
    it { expect(post:   '/admin/ajax/neighborhoods/1/documents/upload').to route_to( routes_params.merge(controller: 'admin/ajax/documents', action: 'upload') ) }
    it { expect(delete: '/admin/ajax/neighborhoods/1/documents/1').to route_to( routes_params.merge(controller: 'admin/ajax/documents', action: 'destroy', id: '1') ) }
    it { expect(post:   '/admin/ajax/neighborhoods/1/documents_relations').to route_to( routes_params.merge(controller: 'admin/ajax/documents_relations', action: 'create') ) }
    it { expect(delete: '/admin/ajax/neighborhoods/1/documents_relations/1').to route_to( routes_params.merge(controller: 'admin/ajax/documents_relations', action: 'destroy', id: '1') ) }
  end

  describe 'Ajax Work Documents nested resources routable' do
    let(:routes_params){ { protocol: 'https', work_id: '1' } }
    it { expect(post:   '/admin/ajax/works/1/documents/upload').to route_to( routes_params.merge(controller: 'admin/ajax/documents', action: 'upload') ) }
    it { expect(delete: '/admin/ajax/works/1/documents/1').to route_to( routes_params.merge(controller: 'admin/ajax/documents', action: 'destroy', id: '1') ) }
    it { expect(post:   '/admin/ajax/works/1/documents_relations').to route_to( routes_params.merge(controller: 'admin/ajax/documents_relations', action: 'create') ) }
    it { expect(delete: '/admin/ajax/works/1/documents_relations/1').to route_to( routes_params.merge(controller: 'admin/ajax/documents_relations', action: 'destroy', id: '1') ) }
  end

  describe 'Ajax Meeting Documents nested resources routable' do
    let(:routes_params){ { protocol: 'https', meeting_id: '1' } }
    it { expect(post:   '/admin/ajax/meetings/1/documents/upload').to route_to( routes_params.merge(controller: 'admin/ajax/documents', action: 'upload') ) }
    it { expect(delete: '/admin/ajax/meetings/1/documents/1').to route_to( routes_params.merge(controller: 'admin/ajax/documents', action: 'destroy', id: '1') ) }
    it { expect(post:   '/admin/ajax/meetings/1/documents_relations').to route_to( routes_params.merge(controller: 'admin/ajax/documents_relations', action: 'create') ) }
    it { expect(delete: '/admin/ajax/meetings/1/documents_relations/1').to route_to( routes_params.merge(controller: 'admin/ajax/documents_relations', action: 'destroy', id: '1') ) }
  end
end
