require 'rails_helper'

RSpec.describe Types::QueryType do
  describe 'display categories' do
    it 'can query all categories' do
      food = Category.create(name: 'Food')
      home = Category.create(name: 'Home Improvement')
      cleaning = Category.create(name: 'Cleaning')
      gardening = Category.create(name: 'Gardening')
      clothing = Category.create(name: 'Clothing')
      other = Category.create(name: 'Other')

      result = CupOfSugarBeSchema.execute(query).as_json

      categories = result["data"]["getAllCategories"]

      expect(categories.count).to eq(6)
      expect(categories.first.values[0]).to eq("Food")
      expect(categories.second.values[0]).to eq("Home Improvement")
      expect(categories.third.values[0]).to eq("Cleaning")
      expect(categories.fourth.values[0]).to eq("Gardening")
      expect(categories.fifth.values[0]).to eq("Clothing")
      expect(categories.last.values[0]).to eq("Other")
    end
  end

  def query
    <<~GQL
    {
      getAllCategories{
        name
      }
    }
    GQL
  end
end
