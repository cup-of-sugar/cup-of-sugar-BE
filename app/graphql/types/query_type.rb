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

    field :get_all_items_by_name, [Types::ItemType], null: false, description: "Returns all items by name" do
      argument :item_name, String, required: true
    end

    def get_all_items_by_name(item_name:)
      posting_ids = Posting.where(posting_type: 1).ids
      Item.where(name: item_name).where(posting_id: posting_ids)
    end

    field :items_user_offered_to_lend, [Types::ItemType], null: false,
      description: "Returns all lend postings associated with a user"

    def items_user_offered_to_lend
      ids = Posting.where(poster_id: context[:current_user].id).ids
      Item.where(posting_id: ids)
    end

    field :items_user_has_lent, [Types::ItemType], null: false,
      description: "Returns all lend postings where lender has responded to borrow request"

    def items_user_has_lent
      ids = Posting.where(responder_id: context[:current_user].id).ids
      Item.where(posting_id: ids)
    end

    field :items_user_looking_to_borrow, [Types::ItemType], null: false,
      description: "Returns all borrow postings associated with a user"

    def items_user_looking_to_borrow
      ids = Posting.where(poster_id: context[:current_user].id).ids
      Item.where(posting_id: ids)
    end

    field :items_user_requested_to_borrow, [Types::ItemType], null: false,
      description: "Returns all borrow postings where lender has not responded to borrow posting"


    def items_user_requested_to_borrow
      ids = Posting.where(responder_id: nil).where(poster_id: context[:current_user].id).ids
      Item.where(posting_id: ids)
    end

    field :items_user_has_borrowed, [Types::ItemType], null: false,
      description: "Returns all borrow postings for a user where lender has responded to their borrow posting"

    def items_user_has_borrowed
      ids = Posting.where(responder_id: context[:current_user].id).ids
      Item.where(posting_id: ids)
    end

    field :get_all_open_borrow_requests, [Types::ItemType], null: false, description: "Returns all borrow postings which have not yet been responded to by a lender"

    def get_all_open_borrow_requests
      ids = Posting.where(responder_id: nil, posting_type: "borrow").ids
      Item.where(posting_id: ids)
    end

    field :user_outbox, [Types::MessageType], null: false

    def user_outbox
      messages = Message.where(sender_id: context[:current_user].id)
      recipient_ids = messages.pluck(:recipient_id)
      User.where(id: recipient_ids)
      messages
    end

    field :user_inbox, [Types::MessageType], null: false

    def user_inbox
      messages = Message.where(recipient_id: context[:current_user].id)
      sender_ids = messages.pluck(:sender_id)
      User.where(id: sender_ids)
      messages
    end
  end
end
