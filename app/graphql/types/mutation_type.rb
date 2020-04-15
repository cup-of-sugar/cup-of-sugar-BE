module Types
  class MutationType < Types::BaseObject
    field :update_item_availability, mutation: Mutations::Items::UpdateItem
    field :create_posting, mutation: Mutations::Postings::CreatePosting
    field :user_login, mutation: Mutations::Users::UserLogin
    field :delete_posting, mutation: Mutations::Postings::DeletePosting
  end
end
