require 'rails_helper'

RSpec.describe Neighborhood, type: :model do

  describe 'associations' do
    it { is_expected.to have_many(:meetings) }
    it { is_expected.to have_many(:users) }
    it { is_expected.to have_many(:works) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:description) }
  end

end
