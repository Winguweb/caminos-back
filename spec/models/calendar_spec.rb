require 'rails_helper'

RSpec.describe Calendar, type: :model do

  describe 'associations' do
    it { is_expected.to belong_to(:meeting) }
    it { is_expected.to belong_to(:work) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:work) }
    it { is_expected.to validate_presence_of(:meeting) }
  
  end
end
