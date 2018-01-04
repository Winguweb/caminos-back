require 'rails_helper'

RSpec.describe Meeting, type: :model do

  describe 'validations' do
    it { is_expected.to validate_presence_of(:public_works) }
    it { is_expected.to validate_presence_of(:date) }
    it { is_expected.to validate_presence_of(:topics) }
    it { is_expected.to validate_presence_of(:conveners) }
    it { is_expected.to validate_presence_of(:objectives) }
    it { is_expected.to validate_presence_of(:participants) }
  end

  describe 'associations' do
    it { is_expected.to have_many(:public_works) }
    it { is_expected.to have_many(:works) }

  end

end
