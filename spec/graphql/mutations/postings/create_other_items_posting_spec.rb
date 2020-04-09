require 'rails_helper'

module Mutations
  module Postings
    RSpec.describe CreatePosting, type: :request do
      describe 'create a posting' do
        it 'for item to borrow in any other category' do
          @gardening = Category.create(name: 'Gardening')

          expect(Posting.count).to eq(0)
          post "/graphql", params: { query: query }
          expect(Posting.count).to eq(1)

          result = JSON.parse(response.body, symbolize_names: true)
          posting = result[:data][:posting]

          expect(posting[:name]). to eq("trowel")
          expect(posting[:description]). to eq("What are even?")
          expect(posting[:quantity]). to eq(4.0)
          expect(posting[:timeDuration]). to eq("days")
        end
      end

      def query
        <<~GQL
          mutation {
            posting: createPosting(
              input: {
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
