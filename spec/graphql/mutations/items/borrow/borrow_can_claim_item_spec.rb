require 'rails_helper'

module Mutations
  module Items
    RSpec.describe UpdateItem, type: :request do
      describe 'borrower can claim an item' do
        it 'which can change availability to false with mutation request' do
          food = Category.create(name: 'Food', id: 15)
          poster = User.create(first_name: 'Carole', last_name: 'Baskin', email: 'carole@tigers.com', password: 'password', zip: 80206)
          responder = User.create(first_name: 'Joe', last_name: 'Exotic', email: 'joe4president@gmail.com', password: 'password', zip: 80204)

          posting = Posting.create(posting_type: 1, title: "Lending spare items from my garage", poster_id: poster.id)

          @food = food.items.create(name: 'Butter', quantity: 8, measurement: "oz", available: true, posting_id: posting.id)

          token = token_for_user(responder)
          post "/graphql", params: { query: query }, headers: { 'Authorization' => token }

          result = JSON.parse(response.body, symbolize_names: true)

          expect(result[:data][:item][:id]).to eq(@food.id.to_s)
          expect(result[:data][:item][:available]).to eq(false)
          expect(result[:data][:item][:name]).to eq(@food.name)

          @food.reload

          expect(@food.available).to eq(false)
          expect(@food.posting.responder_id).to eq(responder.id)
          expect(@food.posting.poster_id).to eq(poster.id)
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
