require 'rails_helper'

module Mutations
  module Items
    RSpec.describe UpdateItem, type: :request do
      describe 'update item availability to false' do
        it 'can change to false with mutation request' do
          food = Category.create(name: 'Food', id: 15)
          @user = User.create(first_name: 'Carole', last_name: 'Baskin', email: 'carole@tigers.com', password: 'password', zip: 80206)
          posting = Posting.create(posting_type: 1, title: "Lending spare items from my garage", poster_id: @user.id)

          @food = food.items.create(name: 'Butter', quantity: 8, measurement: "oz", available: false, posting_id: posting.id)

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
              userId: #{@user.id}
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
