require 'rails_helper'

RSpec.describe Types::QueryType do
  describe 'display category items' do
    it 'can query all items associated with a category' do
      cats = Category.create(name: 'Cats', id: 15)
      lawn = Category.create(name: 'Lawn Care')
      cats.items.create(name: 'Ralph', quantity: 8, measurement: "oz", available: true)
      cats.items.create(name: 'Sean', quantity: 1, measurement: "oz", description: "this cat is the worst but I love him.", time_duration: "days", available: true)
      cats.items.create(name: 'Rhonda', quantity: 4, measurement: "lbs", time_duration: "months", available: true)
      lawn.items.create(name: 'Mower', quantity: 12.5, time_duration: 'hours', available: true)

      result = CupOfSugarBeSchema.execute(query).as_json

      category_items = result["data"]["getAllCategoryItems"]

      expect(category_items.count).to eq(3)
      expect(category_items[0]["name"]).to eq("Ralph")
      expect(category_items[0]["quantity"]).to eq(8.0)
      expect(category_items[0]["timeDuration"]).to eq(nil)
      expect(category_items[0]["available"]).to eq(true)
    end
  end

  def query
    <<~GQL
    query {
      getAllCategoryItems(id: "15") {
        name
        quantity
        timeDuration
        available
      }
    }
    GQL
  end
end
