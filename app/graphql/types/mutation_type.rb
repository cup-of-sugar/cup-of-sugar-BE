module Types
  class MutationType < Types::BaseObject
    field :update_item_availability, mutation: Mutations::Items::UpdateItem
    field :create_posting, mutation: Mutations::Postings::CreatePosting
    field :create_user, mutation: Mutations::Users::CreateUser
    field :user_login, mutation: Mutations::Users::UserLogin
    field :sign_in_user, mutation: Mutations::Users::SignInUser
  end
end
