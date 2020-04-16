require 'rails_helper'

module Mutations
  module Items
    RSpec.describe UpdateItem, type: :request do
      describe 'borrow can return an item' do
        it 'which can change availability when responder_id and user_id match to true with mutation request' do
          cleaning = Category.create(name: 'Cleaning', id: 15)

          responder = User.create(first_name: 'Carole', last_name: 'Baskin', email: 'carole@tigers.com', password: 'password', zip: 80206)
          poster = User.create(first_name: 'Joe', last_name: 'Exotic', email: 'joe4president@gmail.com', password: 'password', zip: 80204)

          posting = Posting.create(posting_type: 0, title: "Lending spare items from my garage", poster_id: poster.id, responder_id: responder.id)

          @mop = cleaning.items.create(name: 'mop', quantity: 1, time_duration: 'day', available: false, returnable: true, posting_id: posting.id, description: "Spunky is in love with this.")

          token = token_for_user(poster)
          post "/graphql", params: { query: query }, headers: { 'Authorization' => token }

          result = JSON.parse(response.body, symbolize_names: true)

          @mop.reload

          expect(@mop.available).to eq(true)
        end
      end

      def query
        <<~GQL
        mutation {
          item: updateItemAvailability(
            input: {
              id: "#{@mop.id}"
              available: true
              name: "#{@mop.name}"
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
