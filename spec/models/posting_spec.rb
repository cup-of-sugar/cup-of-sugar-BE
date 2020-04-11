require 'rails_helper'

RSpec.describe Posting, type: :model do
  describe 'validations' do
    it { validate_presence_of :posting_type }
  end

  describe 'relationships' do
    it { should belong_to :item }
  end

  describe 'types' do
    it 'can create a borrow posting' do
      user = User.create(first_name: 'Carole', last_name: 'Baskin', email: 'carole@tigers.com', password: 'password', zip: 80206)
      food = Category.create(name: 'Food')
      item = food.items.create(name: 'butter', quantity: 8, measurement: "oz", available: true, returnable: false, user_id: user.id)
      posting = Posting.create(item_id: item.id, posting_type: 0)

      expect(posting.posting_type).to eq('borrow')
    end

    it 'can create a lend posting' do
      user = User.create(first_name: 'Carole', last_name: 'Baskin', email: 'carole@tigers.com', password: 'password', zip: 80206)
      food = Category.create(name: 'Food')
      item = food.items.create(name: 'butter', quantity: 8, measurement: "oz", available: true, returnable: false, user_id: user.id)
      posting = Posting.create(item_id: item.id, posting_type: 1)

      expect(posting.posting_type).to eq('lend')
    end
  end
end
