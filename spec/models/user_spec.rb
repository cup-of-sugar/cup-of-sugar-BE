require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'relationships' do
    it { should have_many :posting_users }
    it { should have_many(:responders).through(:posting_users) }

    it { should have_many :responder_users }
    it { should have_many(:posters).through(:responder_users) }

    it { should have_many :sending_users }
    it { should have_many(:recipients).through(:sending_users)}

    it { should have_many :recipient_users }
    it { should have_many(:senders).through(:recipient_users)}
  end
end
