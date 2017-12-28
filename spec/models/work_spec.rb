require 'rails_helper'

RSpec.describe Work, type: :model do

  describe 'associations' do
    it { is_expected.to belong_to(:neighborhood) }
  end
  
  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:address) }
  end

end
