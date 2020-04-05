require 'rails_helper'

RSpec.describe Types::QueryType do
  describe 'display items' do
    it 'can query all items' do
      cats = Category.create(name: 'Cats')
      lawn = Category.create(name: 'Lawn Care')
      cats.items.create(name: 'Ralph', quantity: 8, measurement: "oz", available: true)
      cats.items.create(name: 'Sean', quantity: 1, measurement: "oz", description: "this cat is the worst but I love him.", time_duration: "days", available: true)
      cats.items.create(name: 'Rhonda', quantity: 4, measurement: "lbs", time_duration: "months", available: true)
      lawn.items.create(name: 'Mower', quantity: 12.5, time_duration: 'hours', available: true)
      lawn.items.create(name: 'Fertilizer', quantity: 1, measurement: "oz", time_duration: 'days', available: true )

      result = CupOfSugarBeSchema.execute(query).as_json

      items = result["data"]["getAllItems"]
      
      expect(items[0]["name"]).to eq("Ralph")
      expect(items[0]["quantity"]).to eq(8.0)
      expect(items[0]["available"]).to eq(true)
      expect(items[0]["measurement"]).to eq("oz")
      expect(items[0]["category"]["name"]).to eq("Cats")
      expect(items[1]["description"]).to eq("this cat is the worst but I love him.")
      expect(items[1]["timeDuration"]).to eq("days")
    end
  end

  def query
    <<~GQL
    {
      getAllItems {
        name
        quantity
        available
        description
        measurement
        timeDuration
        category {
          name
        }
      }
    }
    GQL
  end
end
