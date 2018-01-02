require 'rails_helper'

RSpec.describe Neighborhood, type: :model do

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:description) }
    
  end

  describe 'associations' do
    it { is_expected.to have_many(:ambassadors) }
    it { is_expected.to have_many(:users) }
  end

end
