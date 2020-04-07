require 'rails_helper'

module Mutations
  module Items
    RSpec.describe UpdateItem, type: :request do
      describe 'update item availability' do
        it 'can change with mutation request' do
          food = Category.create(name: 'Food', id: 15)
          @food = food.items.create(name: 'Butter', quantity: 8, measurement: "oz", available: true)

          post "/graphql", params: { query: query }

          result = JSON.parse(response.body, symbolize_names: true)

          expect(result[:data][:item][:id]).to eq(@food.id.to_s)
          expect(result[:data][:item][:available]).to eq(false)
          expect(result[:data][:item][:name]).to eq(@food.name)

          result = JSON.parse(response.body)
        end
      end

      def query
        <<~GQL
        mutation {
          item: updateItemAvailability(
            input: {
              id: "#{@food.id}"
              available: false
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
