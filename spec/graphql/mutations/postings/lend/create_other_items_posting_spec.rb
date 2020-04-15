require 'rails_helper'

module Mutations
  module Postings
    RSpec.describe CreatePosting, type: :request do
      describe 'create a posting' do
        it 'for item to lend in any other category' do
          @gardening = Category.create(name: 'Gardening')
          user = User.create(first_name: 'Carole', last_name: 'Baskin', email: 'carole@tigers.com', password: 'password', zip: 80206)

          expect(Posting.count).to eq(0)
          token = token_for_user(user)
          post "/graphql", params: { query: query }, headers: { 'Authorization' => token }
          expect(Posting.count).to eq(1)

          result = JSON.parse(response.body, symbolize_names: true)

          posting = result[:data][:posting]

          expect(posting[:name]). to eq("trowel")
          expect(posting[:description]). to eq("What are even?")
          expect(posting[:quantity]). to eq(4.0)
          expect(posting[:timeDuration]). to eq("days")

          item = Item.last
          post = item.posting
          post.reload

          expect(post.posting_type).to eq("lend")
          expect(item.available).to eq(true)
          expect(item.returnable).to eq(true)
        end
      end

      def query
        <<~GQL
          mutation {
            posting: createPosting(
              input: {
                title: "Looking to lend"
                postingType: "lend"
                categoryName: "#{@gardening.name}"
                name: "trowel"
                description: "What are even?"
                quantity: "4.0"
                timeDuration: "days"
              }
            ) {
              name
              description
              quantity
              timeDuration
            }
          }
        GQL
      end
    end
  end
end
