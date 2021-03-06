require 'rails_helper'

RSpec.describe Types::QueryType, type: :request do
  describe 'display postings' do
    it 'user can query all their borrow postings where they have responded to a lender' do
      lawn = Category.create(name: 'Lawn Care')
      user = User.create(first_name: 'Carole', last_name: 'Baskin', email: 'carole@tigers.com', password: 'password', zip: 80206)
      user1 = User.create(first_name: 'Joe', last_name: 'Exotic', email: 'joe4president@gmail.com', password: 'password', zip: 80206)


      posting = Posting.create(posting_type: 1, title: "Looking to borrow wheel barrow", poster_id: user1.id, responder_id: user.id)
      posting1 = Posting.create(posting_type: 1, title: "Looking to borrow weed wacker", poster_id: user1.id, responder_id: user.id)
      posting2 = Posting.create(posting_type: 1, title: "Looking to borrow sprinkler", poster_id: user1.id, responder_id: user.id)

      lawn.items.create(name: 'wheel barrow', quantity: 12.5, time_duration: 'hours', available: true, posting_id: posting.id)
      lawn.items.create(name: 'weed wacker', quantity: 2.0, time_duration: 'days', available: true, posting_id: posting1.id)
      lawn.items.create(name: 'sprinkler', quantity: 2.0, time_duration: 'days', available: true, posting_id: posting2.id)

      token = token_for_user(user)

      post "/graphql", params: { query: query }, headers: { 'Authorization' => token }
      result = JSON.parse(response.body)

      postings = result["data"]["itemsUserHasBorrowed"]

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
      itemsUserHasBorrowed {
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
