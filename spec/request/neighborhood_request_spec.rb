require "rails_helper"

RSpec.describe NeighborhoodsController, type: :request do
  let(:neighborhood) { create(:neighborhood) }
  let(:neighborhood_id) { neighborhood.id }

  describe '#show' do
    before { get "/neighborhoods/#{neighborhood_id}" }

    context 'with valid neighborhood id' do
      it_behaves_like 'a successful request'
    end

    context 'with invalid neighborhood id' do
      let(:neighborhood_id) { SecureRandom.uuid }

      it_behaves_like 'a redirect', :root
    end
  end


end
