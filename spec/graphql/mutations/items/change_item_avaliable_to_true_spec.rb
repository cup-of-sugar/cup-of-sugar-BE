require 'rails_helper'

module Mutations
  module Items
    RSpec.describe UpdateItem, type: :request do
      describe 'update item availability to false' do
        it 'can change to false with mutation request' do
          food = Category.create(name: 'Food', id: 15)
          @food = food.items.create(name: 'Butter', quantity: 8, measurement: "oz", available: false)

          post "/graphql", params: { query: query }

          result = JSON.parse(response.body, symbolize_names: true)

          expect(result[:data][:item][:id]).to eq(@food.id.to_s)
          expect(result[:data][:item][:available]).to eq(true)
          expect(result[:data][:item][:name]).to eq(@food.name)

          result = JSON.parse(response.body)
          @food.reload

          expect(@food.available).to eq(true)
        end
      end

      def query
        <<~GQL
        mutation {
          item: updateItemAvailability(
            input: {
              id: "#{@food.id}"
              available: true
              name: "#{@food.name}"
            }
          )
          {
            id
            available
            name
          }
        }
        GQL
      end
    end
  end
end
