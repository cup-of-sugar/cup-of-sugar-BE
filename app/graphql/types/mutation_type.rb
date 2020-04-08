module Types
  class MutationType < Types::BaseObject
    field :update_item_availability, mutation: Mutations::Items::UpdateItem
  end
end
