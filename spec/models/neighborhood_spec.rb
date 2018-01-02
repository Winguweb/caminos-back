require 'rails_helper'

RSpec.describe Neighborhood, type: :model do

  describe 'associations' do
    it { is_expected.to have_many(:ambassadors) }
    it { is_expected.to have_many(:users) }
  end

end
