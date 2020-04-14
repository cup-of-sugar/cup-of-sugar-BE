module Types
  class MessageType < Types::BaseObject
    field :id, ID, null: false
    field :title, String, null: false
    field :body, String, null: false
    field :recipient, Types::UserType, null: true
    field :sender, Types::UserType, null: true
  end
end
