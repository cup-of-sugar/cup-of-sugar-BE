require 'rails_helper'

module Mutations
  module Postings
    RSpec.describe DeletePosting, type: :request do
      describe "Delete a posting" do
        it "deletes both the posting and assocated item if there is no responder id" do
          user = User.create(first_name: 'Carole', last_name: 'Baskin', email: 'carole@tigers.com', password: 'password', zip: 80206)
          @posting = Posting.create(posting_type: 0, title: "Seeking food supplies", poster_id: user.id)
          cleaning = Category.create(name: 'Cleaning')
          cleaning.items.create(name: 'mop', quantity: 1, time_duration: 'day', available: true, returnable: true, posting_id: @posting.id, description: "Spunky is in love with this.")

          postings = Posting.all
          items = Item.all

          expect(postings.count).to eq(1)
          expect(items.count).to eq(1)

          post "/graphql", params: { query: query }

          result = JSON.parse(response.body, symbolize_names: true)

          postings.reload
          items.reload

          expect(result[:data][:posting][:title]).to eq("successfully deleted")
          expect(postings.count).to eq(0)
          expect(items.count).to eq(0)
        end

        def query
          <<~GQL
          mutation {
            posting: deletePosting(
              input: {
                id: #{@posting.id}
              }
            )
            {
              title
            }
          }
          GQL
        end
      end

      describe "Delete a posting" do
        it "does not delete the posting nor assocated item if there is a responder id" do
          user = User.create(first_name: 'Carole', last_name: 'Baskin', email: 'carole@tigers.com', password: 'password', zip: 80206)
          user1 = User.create(first_name: 'Joe', last_name: 'Exotic', email: 'joe4president@gmail.com', password: 'password', zip: 80206)

          @posting1 = Posting.create(posting_type: 0, title: "Seeking food supplies", poster_id: user.id, responder_id: user1.id)

          postings = Posting.all

          expect(postings.count).to eq(1)

          post "/graphql", params: { query: query1 }

          result = JSON.parse(response.body, symbolize_names: true)

          postings.reload

          expect(result[:data][:posting][:title]).to eq(@posting1.title)
          expect(postings.count).to eq(1)
        end
      end

      def query1
        <<~GQL
        mutation {
          posting: deletePosting(
            input: {
              id: #{@posting1.id}
            }
          )
          {
            title
          }
        }
        GQL
      end
    end
  end
end
