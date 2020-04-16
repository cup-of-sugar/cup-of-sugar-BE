require 'rails_helper'

module Mutations
  module Messages
    RSpec.describe SendMessage, type: :request do
      describe 'user can send message' do
        it 'to another user' do
          user = User.create(first_name: 'Carole', last_name: 'Baskin', email: 'carole@tigerss.com', password: 'password', zip: 80206)
          @user1 = User.create(first_name: 'Joe', last_name: 'Exotic', email: 'joe4presidents@gmail.com', password: 'password', zip: 80206)

          token = token_for_user(user)
          post "/graphql", params: { query: query }, headers: { 'Authorization' => token }

          result = JSON.parse(response.body, symbolize_names: true)

          message = Message.last
          
          expect(result[:data][:message][:id].to_i).to eq(message.id)
          expect(result[:data][:message][:title]).to eq(message.title)
          expect(result[:data][:message][:body]).to eq(message.body)
        end
      end

      def query
        <<~GQL
        mutation {
          message: sendMessage(
            input: {
              title: "Borrowing your drill"
              body: "Thanks so much for letting me borrow your drill. Can I pick it up on Saturday?"
              recipientEmail: "#{@user1.email}"
            }
          )
          {
            id
            title
            body
          }
         }
         GQL
      end
    end
  end
end
