module Types
  class MutationType < Types::BaseObject
    field :update_item_availability, mutation: Mutations::Items::UpdateItem
    field :create_posting, mutation: Mutations::Postings::CreatePosting
  end
end
