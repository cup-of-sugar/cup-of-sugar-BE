require 'rails_helper'

RSpec.describe Types::QueryType, type: :request do
  describe 'user can see messages' do
    it 'they sent to other users' do
      @user = User.create(first_name: 'Carole', last_name: 'Baskin', email: 'carole@tigerss.com', password: 'password', zip: 80206)
      user1 = User.create(first_name: 'Joe', last_name: 'Exotic', email: 'joe4presidents@gmail.com', password: 'password', zip: 80206)

      message = Message.create(title: "Borrowing your drill", body: "Thanks so much for letting me borrow your drill. Can I pick it up on Saturday?", sender_id: @user.id, recipient_id: user1.id)
      message1 = Message.create(title: "Borrowing your mop", body: "Thanks so much for letting me borrow your mop. Can I pick it up on Saturday?", sender_id: @user.id, recipient_id: user1.id)
      message2 = Message.create(title: "Borrowing your mop", body: "Thanks so much for letting me borrow your mop. Can I pick it up on Saturday?", sender_id: user1.id, recipient_id: @user.id)

      post "/graphql", params: { query: query }

      result = JSON.parse(response.body, symbolize_names: true)

      message_result = result[:data][:userOutbox]
      expect(message_result[0][:title]).to eq(message.title)
      expect(message_result[0][:body]).to eq(message.body)
      expect(message_result[0][:recipient][:firstName]).to eq(user1.first_name)
      expect(message_result[0][:recipient][:email]).to eq(user1.email)

      expect(message_result[1][:title]).to eq(message1.title)
      expect(message_result[1][:body]).to eq(message1.body)
      expect(message_result[1][:recipient][:firstName]).to eq(user1.first_name)
      expect(message_result[1][:recipient][:email]).to eq(user1.email)

      expect(message_result.count).to eq(2)
    end
  end

  def query
    <<~GQL
      query {
        userOutbox(userId: #{@user.id}) {
          title
          body
          recipient {
            firstName
            email
          }
        }
      }
    GQL
  end
end
