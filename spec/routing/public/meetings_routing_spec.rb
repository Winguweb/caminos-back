require 'rails_helper'

RSpec.describe MeetingsController, type: :routing do
  let(:routes_params){ { protocol: 'https' } }
  describe 'Meeting NOT routeable' do
    it { expect(get: '/meetings').not_to be_routable }
    it { expect(get: '/meetings/1').not_to be_routable }
    it { expect(post: '/meetings').not_to be_routable }
    it { expect(post: '/meetings/1').not_to be_routable }
    it { expect(put: '/meetings/1').not_to be_routable }
    it { expect(delete: '/meetings/1').not_to be_routable }
    it { expect(patch: '/meetings/1').not_to be_routable }

    # TODO: IT IS AVAILABLE FOR MOBILE, HOW CAN WE CHECK NEXT TEST TO BE ROUTABLE IN MOBILE???
    # it { expect(get: 'neighborhoods/1/meetings').not_to be_routable }
    it { expect(post: 'neighborhoods/1/meetings').not_to be_routable }
    it { expect(get: 'neighborhoods/1/meetings/1/edit').not_to be_routable }
    it { expect(patch: 'neighborhoods/1/meetings/1').not_to be_routable }
    it { expect(put: 'neighborhoods/1/meetings/1').not_to be_routable }
    it { expect(delete: 'neighborhoods/1/meetings/1').not_to be_routable }
  end
end
