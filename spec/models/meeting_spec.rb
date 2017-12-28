require 'rails_helper'

RSpec.describe Meeting, type: :model do
  describe 'associations' do
    it { is_expected.to have_and_belong_to_many (:works) }
  end
  
  describe 'validations' do
    it { is_expected.to validate_presence_of(:works) }
  end

end
