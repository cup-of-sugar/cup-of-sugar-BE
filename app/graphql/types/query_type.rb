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

    field :get_all_items_by_name, [Types::ItemType], null: false, description: "Returns all category items" do
      argument :name, String, required: true
      argument :items, String, required: true
    end

    def get_all_items_by_name(name:, items:)
      Category.find_by(name: name).items.where(name: items)
    end

  end
end
