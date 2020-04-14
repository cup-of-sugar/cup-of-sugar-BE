require 'rails_helper'

module Mutations
  module Items
    RSpec.describe UpdateItem, type: :request do
      describe 'lender cannot lend an item' do
        it 'if borrower id of user trying to claim that item matches lender id' do
          food = Category.create(name: 'Food', id: 15)
          @poster = User.create(first_name: 'Carole', last_name: 'Baskin', email: 'carole@tigers.com', password: 'password', zip: 80206)

          posting = Posting.create(posting_type: 1, title: "Lending spare items from my garage", poster_id: @poster.id)

          @food = food.items.create(name: 'Butter', quantity: 8, measurement: "oz", available: true, posting_id: posting.id)

          post "/graphql", params: { query: query }

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
              userId: #{@poster.id}
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
