require 'rails_helper'

RSpec.describe Profile, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:user) }
  end

  describe 'instance method' do
    let(:profile){ create(:profile, first_name: 'John', last_name: 'Doe') }

    it('full_name') { expect(profile.full_name).to eq('John Doe') }
    it('initials') { expect(profile.initials).to eq('JD') }
  end
end
