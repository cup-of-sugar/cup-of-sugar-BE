require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'relationships' do
    it { should have_many :posting_users }
    it { should have_many(:responders).through(:posting_users) }

    it { should have_many :responder_users }
    it { should have_many(:posters).through(:responder_users) }
  end
end
