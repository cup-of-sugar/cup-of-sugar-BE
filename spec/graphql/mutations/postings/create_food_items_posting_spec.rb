require 'rails_helper'

module Mutations
  module Postings
    RSpec.describe CreatePosting, type: :request do
      describe 'create a posting' do
        it 'for item to borrow in food category' do
        @food = Category.create(name: 'Food')
        @user = User.create(first_name: 'Carole', last_name: 'Baskin', email: 'carole@tigers.com', password: 'password', zip: 80206)

        expect(Posting.count).to eq(0)
        post "/graphql", params: { query: query }
        expect(Posting.count).to eq(1)

        result = JSON.parse(response.body, symbolize_names: true)
        posting = result[:data][:posting]

        expect(posting[:name]). to eq("Butter")
        expect(posting[:description]). to eq("It's butter.")
        expect(posting[:quantity]). to eq(8.0)
        expect(posting[:measurement]). to eq("oz")

        post = Posting.last
        post.reload

        expect(post.posting_type).to eq("borrow")
        end
      end

      def query
        <<~GQL
          mutation {
            posting: createPosting(
              input: {
                userId: #{@user.id}
                postingType: "borrow"
                title: "Passing a title"
                categoryName: "#{@food.name}"
                name: "Butter"
                description: "It's butter."
                quantity: "8.0"
                measurement: "oz"
              }
            ) {
              name
              description
              quantity
              measurement
            }
          }
        GQL
      end
    end
  end
end
