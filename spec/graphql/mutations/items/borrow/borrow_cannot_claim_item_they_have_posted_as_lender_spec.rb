require 'rails_helper'

module Mutations
  module Items
    RSpec.describe UpdateItem, type: :request do
      describe 'borrower cannot claim an item' do
        it 'if item was posted by user as a lender' do
          food = Category.create(name: 'Food', id: 15)
          poster = User.create(first_name: 'Carole', last_name: 'Baskin', email: 'carole@tigers.com', password: 'password', zip: 80206)

          posting = Posting.create(posting_type: 0, title: "Lending spare items from my garage", poster_id: poster.id)

          @food = food.items.create(name: 'Butter', quantity: 8, measurement: "oz", available: true, posting_id: posting.id)

          token = token_for_user(poster)
          post "/graphql", params: { query: query }, headers: { 'Authorization' => token }

          result = JSON.parse(response.body, symbolize_names: true)

          expect(result[:data][:item]).to be_nil
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
