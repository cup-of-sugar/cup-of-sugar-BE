module Types
  class MutationType < Types::BaseObject
    field :update_item_availability, mutation: Mutations::Items::UpdateItem
    field :create_posting, mutation: Mutations::Postings::CreatePosting
    field :user_login, mutation: Mutations::Users::UserLogin
    field :send_message, mutation: Mutations::Messages::SendMessage
    field :delete_posting, mutation: Mutations::Postings::DeletePostingg
  end
end
