module Types
  class QueryType < Types::BaseObject

    field :get_all_items, [Types::ItemType], null: false,
      description: "Returns a list of items"

    def get_all_items
      Item.all
    end

    field :get_all_categories, [Types::CategoryType], null: false,
      description: "Returns all categories in the database"

    def get_all_categories
      Category.all
    end

    field :get_all_items_in_category, [Types::ItemType], null: false, description: "Returns all items associated with a specific category" do
      argument :name, String, required: true
    end

    def get_all_items_in_category(name:)
      Category.find_by(name: name).items
    end

    field :get_all_items_by_name, [Types::ItemType], null: false, description: "Returns all category items" do
      argument :item_name, String, required: true
    end

    def get_all_items_by_name(item_name:)
      posting_ids = Posting.where(posting_type: 1).ids
      Item.where(name: item_name).where(posting_id: posting_ids)
    end

    field :items_user_offered_to_lend, [Types::ItemType], null: false, description: "Returns all lend postings associated with a user" do
      argument :user_id, ID, required: true
    end

    def items_user_offered_to_lend(user_id:)
      ids = Posting.where(poster_id: user_id).ids
      Item.where(posting_id: ids)
    end

    field :items_user_has_lent, [Types::ItemType], null: false, description: "Returns all lend postings where lender has responded to borrow request" do
      argument :user_id, ID, required: true
    end

    def items_user_has_lent(user_id:)
      ids = Posting.where(responder_id: user_id).ids
      Item.where(posting_id: ids)
    end

    field :items_user_looking_to_borrow, [Types::ItemType], null: false, description: "Returns all borrow postings associated with a user" do
      argument :user_id, ID, required: true
    end

    def items_user_looking_to_borrow(user_id:)
      ids = Posting.where(poster_id: user_id).ids
      Item.where(posting_id: ids)
    end

    field :items_user_requested_to_borrow, [Types::ItemType], null: false, description: "Returns all borrow postings where lender has not responded to borrow posting" do
      argument :user_id, ID, required: true
    end

    def items_user_requested_to_borrow(user_id:)
      ids = Posting.where(responder_id: nil).where(poster_id: user_id).ids
      Item.where(posting_id: ids)
    end

    field :items_user_has_borrowed, [Types::ItemType], null: false, description: "Returns all borrow postings where lender has responded to borrower" do
      argument :user_id, ID, required: true
    end

    def items_user_has_borrowed(user_id:)
      ids = Posting.where(responder_id: user_id).ids
      Item.where(posting_id: ids)
    end

    field :user_outbox, [Types::MessageType], null: false do
      argument :user_id, ID, required: true
    end

    def user_outbox(user_id: )
      messages = Message.where(sender_id: user_id)
      recipient_ids = messages.pluck(:recipient_id)
      User.where(id: recipient_ids)
      messages
    end

    field :user_inbox, [Types::MessageType], null: false do
      argument :user_id, ID, required: true
    end

    def user_inbox(user_id: )
      messages = Message.where(recipient_id: user_id)
      sender_ids = messages.pluck(:sender_id)
      User.where(id: sender_ids)
      messages
    end
  end
end
