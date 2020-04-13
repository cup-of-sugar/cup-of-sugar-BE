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

    field :get_all_user_lend_postings, [Types::ItemType], null: false, description: "Returns all lend postings associated with a user" do
      argument :user_id, ID, required: true
    end

    def get_all_user_lend_postings(user_id:)
      ids = Posting.where(poster_id: user_id).ids
      Item.where(posting_id: ids)
    end

    field :get_lend_posting_where_user_responder, [Types::ItemType], null: false, description: "Returns all lend postings where lender is responder" do
      argument :user_id, ID, required: true
    end

    def get_lend_posting_where_user_responder(user_id:)
      ids = Posting.where(responder_id: user_id).ids
      Item.where(posting_id: ids)
    end

    field :get_all_user_borrow_postings, [Types::ItemType], null: false, description: "Returns all borrow postings associated with a user" do
      argument :user_id, ID, required: true
    end

    def get_all_user_borrow_postings(user_id:)
      ids = Posting.where(poster_id: user_id).ids
      Item.where(posting_id: ids)
    end

    field :get_borrow_posting_where_user_responder, [Types::ItemType], null: false, description: "Returns all lend postings where borrow is responder" do
      argument :user_id, ID, required: true
    end

    def get_borrow_posting_where_user_responder(user_id:)
      ids = Posting.where(responder_id: user_id).ids
      Item.where(posting_id: ids)
    end
  end
end
