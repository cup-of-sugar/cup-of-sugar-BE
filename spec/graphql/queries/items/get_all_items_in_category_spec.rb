require 'rails_helper'

RSpec.describe Types::QueryType do
  describe 'display all items associated with a category' do
    it 'can query an items associated with a category by category name' do
      cats = Category.create(name: 'Cats')
      ralph = cats.items.create(name: 'Ralph', quantity: 8, time_duration: "months", available: true)
      vlad = cats.items.create(name: 'Vlad', quantity: 2, time_duration: "weeks", available: true)
      george = cats.items.create(name: 'George', quantity: 1, time_duration: "day", available: true)
      food = Category.create(name: 'Food')
      egg = food.items.create(name: 'Egg', quantity: 1, description: "Can I offer you a nice egg during this trying time?", measurement: "shelled embryo", available: true)
      cheese = food.items.create(name: 'Cheese', quantity: 4, measurement: "cups", available: true)

      result = CupOfSugarBeSchema.execute(query).as_json

      category_items = result["data"]["getAllItemsInCategory"]

      expect(category_items.count).to eq(3)
      expect(category_items[0]["name"]).to eq("Ralph")
      expect(category_items[0]["quantity"]).to eq(8.0)
      expect(category_items[0]["timeDuration"]).to eq("months")
      expect(category_items[0]["available"]).to eq(true)
    end

    it 'can query a different category and items' do
      lawn = Category.create(name: 'Lawn Care')
      lawn.items.create(name: 'Mower', quantity: 12.5, time_duration: 'hours', available: true)
      lawn.items.create(name: 'Sprinkler', quantity: 2.0, time_duration: 'days', available: true)

      result = CupOfSugarBeSchema.execute(query_2).as_json

      category_items = result["data"]["getAllItemsInCategory"]

      expect(category_items.count).to eq(2)
      expect(category_items[0]["name"]).to eq("Mower")
      expect(category_items[0]["quantity"]).to eq(12.5)
      expect(category_items[0]["timeDuration"]).to eq('hours')
      expect(category_items[0]["available"]).to eq(true)

      expect(category_items[1]["name"]).to eq("Sprinkler")
      expect(category_items[1]["quantity"]).to eq(2)
      expect(category_items[1]["timeDuration"]).to eq('days')
      expect(category_items[1]["available"]).to eq(true)
    end
    #
    # it "can fail gracefully if no item is found" do
    #   lawn = Category.create(name: 'Lawn Care')
    #   result = CupOfSugarBeSchema.execute(query1).as_json
    #   expect(result["data"]["getAllItemsByName"]).to eq([])
    # end
  end

  def query
    <<~GQL
    query {
      getAllItemsInCategory(name: "Cats") {
        name
        quantity
        timeDuration
        measurement
        description
        available
      }
    }
    GQL
  end

  def query_2
    <<~GQL
    query {
      getAllItemsInCategory(name: "Lawn Care") {
        name
        quantity
        timeDuration
        measurement
        description
        available
      }
    }
    GQL
  end
end
