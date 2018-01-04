require 'rails_helper'

RSpec.describe Work, type: :model do

  describe 'associations' do
    it { is_expected.to belong_to(:neighborhood) }
  end
  
  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:address) }
    it { is_expected.to validate_presence_of(:start_date) }
    it { is_expected.to validate_presence_of(:end_date) }
    it { is_expected.to validate_presence_of(:status) }
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_presence_of(:budget) }
    it { is_expected.to validate_presence_of(:manager) }
    it { is_expected.to validate_presence_of(:execution_plan) }
  end

end