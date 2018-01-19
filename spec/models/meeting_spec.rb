require 'rails_helper'

RSpec.describe Meeting, type: :model do

  describe 'associations' do
    it { is_expected.to belong_to(:neighborhood) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:date) }
    it { is_expected.to validate_presence_of(:lookup_coordinates) }
    it { is_expected.to validate_presence_of(:objectives) }
    it { is_expected.to validate_presence_of(:organizer) }
    it { is_expected.to validate_presence_of(:participants) }
  end

end
