module Types
  class QueryType < Types::BaseObject
    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    # TODO: remove me
    field :items, [Types::ItemType], null: false,
      description: "Returns a list of items"

    def get_all_items
      Item.all
    end
  end
end
