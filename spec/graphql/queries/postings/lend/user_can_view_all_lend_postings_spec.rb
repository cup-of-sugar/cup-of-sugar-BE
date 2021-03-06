require 'rails_helper'

RSpec.describe Types::QueryType, type: :request do
  describe 'display postings' do
    it 'user can query all their lend postings' do

      lawn = Category.create(name: 'Lawn Care')
      user = User.create(first_name: 'Carole', last_name: 'Baskin', email: 'carole@tigers.com', password: 'password', zip: 80206)

      posting = Posting.create(posting_type: 1, title: "Lending spare items from my garage", poster_id: user.id)
      posting1 = Posting.create(posting_type: 1, title: "Lending spare items from my garage", poster_id: user.id)
      posting2 = Posting.create(posting_type: 1, title: "Lending spare items from my garage", poster_id: user.id)
      lawn.items.create(name: 'Mower', quantity: 12.5, time_duration: 'hours', available: true, posting_id: posting.id)
      lawn.items.create(name: 'Sprinkler', quantity: 2.0, time_duration: 'days', available: true, posting_id: posting1.id)
      lawn.items.create(name: 'Sprinkler', quantity: 2.0, time_duration: 'days', available: true, posting_id: posting2.id)
      token = token_for_user(user)

      post "/graphql", params: { query: query }, headers: { 'Authorization' => token }

      result = JSON.parse(response.body)
      postings = result["data"]["itemsUserOfferedToLend"]

      expect(postings.count).to eq(3)
      expect(postings[0]["posting"]["title"]).to eq(posting.title)
      expect(postings[0]).to have_key("name")
      expect(postings[0]).to have_key("quantity")
      expect(postings[0]).to have_key("available")
      expect(postings[0]).to have_key("description")
      expect(postings[0]).to have_key("measurement")
      expect(postings[0]).to have_key("timeDuration")
      expect(postings[1]["posting"]["title"]).to eq(posting1.title)
      expect(postings[2]["posting"]["title"]).to eq(posting2.title)
    end
  end

  def query
    <<~GQL
    query {
      itemsUserOfferedToLend {
        name
        quantity
        available
        description
        measurement
        timeDuration
        posting {
          id
          title
        }
      }
    }
    GQL
  end
end
