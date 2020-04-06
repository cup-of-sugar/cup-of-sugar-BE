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

    field :get_all_category_items, [Types::ItemType], null: false, description: "Returns all category items" do
      argument :id, ID, required: true
    end

    def get_all_category_items(id:)
      Category.find(id).items
    end

  end
end
