require 'rails_helper'

RSpec.describe Types::QueryType do
  describe 'display items by name' do
    it 'can query an item by name associated with a category' do
      lawn = Category.create(name: 'Lawn Care')
      cats = Category.create(name: 'Cats', id: 15)
      user = User.create(first_name: 'Carole', last_name: 'Baskin', email: 'carole@tigers.com', password: 'password', zip: 80206)
      posting = Posting.create(posting_type: 1, title: "Lending spare items from my garage")

      cats.items.create(name: 'Ralph', quantity: 8, measurement: "oz", available: true, user_id: user.id, posting_id: posting.id)

      result = CupOfSugarBeSchema.execute(query).as_json

      category_items = result["data"]["getAllItemsByName"]

      expect(category_items.count).to eq(1)
      expect(category_items[0]["name"]).to eq("Ralph")
      expect(category_items[0]["quantity"]).to eq(8.0)
      expect(category_items[0]["timeDuration"]).to eq(nil)
      expect(category_items[0]["available"]).to eq(true)
    end

    it 'can query a different category and item' do
      lawn = Category.create(name: 'Lawn Care')
      user = User.create(first_name: 'Carole', last_name: 'Baskin', email: 'carole@tigers.com', password: 'password', zip: 80206)
      posting = Posting.create(posting_type: 1, title: "Lending spare items from my garage")

      lawn.items.create(name: 'Mower', quantity: 12.5, time_duration: 'hours', available: true, user_id: user.id, posting_id: posting.id)

      result = CupOfSugarBeSchema.execute(query1).as_json

      category_items = result["data"]["getAllItemsByName"]

      expect(category_items.count).to eq(1)
      expect(category_items[0]["name"]).to eq("Mower")
      expect(category_items[0]["quantity"]).to eq(12.5)
      expect(category_items[0]["timeDuration"]).to eq('hours')
      expect(category_items[0]["available"]).to eq(true)
    end

    it "can fail gracefully if no item is found" do
      lawn = Category.create(name: 'Lawn Care')
      result = CupOfSugarBeSchema.execute(query1).as_json
      expect(result["data"]["getAllItemsByName"]).to eq([])
    end
  end

  def query
    <<~GQL
    query {
      getAllItemsByName(itemName: "Ralph") {
        name
        quantity
        timeDuration
        available
      }
    }
    GQL
  end

  def query1
    <<~GQL
    query {
      getAllItemsByName(itemName: "Mower") {
        name
        quantity
        timeDuration
        available
      }
    }
    GQL
  end
end
