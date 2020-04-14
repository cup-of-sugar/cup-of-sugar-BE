require 'rails_helper'

RSpec.describe Message, type: :model do
  describe 'validations' do
    it { validate_presence_of :title }
    it { validate_presence_of :body }
    it { validate_presence_of :sender_id }
    it { validate_presence_of :recipient_id }
  end

end
