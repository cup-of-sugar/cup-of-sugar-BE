module Types
  class PostingType < Types::BaseObject
    field :id, ID, null: false
    field :item, Types::ItemType, null: false
    field :posting_type, String, null: false
  end
end
