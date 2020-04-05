module Types
  class QueryType < Types::BaseObject
  
    field :get_all_items, [Types::ItemType], null: false,
      description: "Returns a list of items"

    def get_all_items
      Item.all
    end
  end
end
