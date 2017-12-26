require 'rails_helper'

RSpec.describe Neighborhood, type: :model do
  it { is_expected.to have_many(:works) }
end
