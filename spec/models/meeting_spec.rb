require 'rails_helper'

RSpec.describe Meeting, type: :model do

  describe 'associations' do
    it { is_expected.to belong_to(:neighborhood) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:date) }
    it { is_expected.to validate_presence_of(:lookup_address) }
  end

end
