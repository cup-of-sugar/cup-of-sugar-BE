require 'rails_helper'

RSpec.describe Types::QueryType do
  describe 'display items by name' do
    it 'can query an item by name associated with a category' do
      lawn = Category.create(name: 'Lawn Care')
      cats = Category.create(name: 'Cats', id: 15)
      cats.items.create(name: 'Ralph', quantity: 8, measurement: "oz", available: true)

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
      lawn.items.create(name: 'Mower', quantity: 12.5, time_duration: 'hours', available: true)

      result = CupOfSugarBeSchema.execute(query1).as_json

      category_items = result["data"]["getAllItemsByName"]

      expect(category_items.count).to eq(1)
      expect(category_items[0]["name"]).to eq("Mower")
      expect(category_items[0]["quantity"]).to eq(12.5)
      expect(category_items[0]["timeDuration"]).to eq('hours')
      expect(category_items[0]["available"]).to eq(true)
    end
<<<<<<< HEAD

    it "can fail gracefully if no item is found" do
      lawn = Category.create(name: 'Lawn Care')
      result = CupOfSugarBeSchema.execute(query1).as_json
      expect(result["data"]["getAllItemsByName"]).to eq([])
    end
=======
>>>>>>> 93d9815cd3c9b10cb36aa366cc60d095d7b80594
  end

  def query
    <<~GQL
    query {
      getAllItemsByName(name: "Cats",  items: "Ralph") {
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
      getAllItemsByName(name: "Lawn Care",  items: "Mower") {
        name
        quantity
        timeDuration
        available
      }
    }
    GQL
  end
end
