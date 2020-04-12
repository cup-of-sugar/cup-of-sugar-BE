require 'rails_helper'

RSpec.describe Posting, type: :model do
  describe 'validations' do
    it { validate_presence_of :posting_type }
  end

  describe 'relationships' do
    it { should have_many :items }
  end

  describe 'types' do
    it 'can create a borrow posting' do
      user = User.create(first_name: 'Carole', last_name: 'Baskin', email: 'carole@tigers.com', password: 'password', zip: 80206)
      food = Category.create(name: 'Food')
      item = food.items.create(name: 'butter', quantity: 8, measurement: "oz", available: true, returnable: false)
      posting = Posting.create(posting_type: 0, title: "looking for spare items", poster_id: user.id)

      expect(posting.posting_type).to eq('borrow')
    end

    it 'can create a lend posting' do
      user = User.create(first_name: 'Carole', last_name: 'Baskin', email: 'carole@tigers.com', password: 'password', zip: 80206)
      food = Category.create(name: 'Food')
      item = food.items.create(name: 'butter', quantity: 8, measurement: "oz", available: true, returnable: false)
      posting = Posting.create(posting_type: 1, title: "Lending spare items from my garage", poster_id: user.id)

      expect(posting.posting_type).to eq('lend')
    end
  end
end
