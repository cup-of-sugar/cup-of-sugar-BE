module Types
  class PostingType < Types::BaseObject
    field :id, ID, null: false
    field :item, Types::ItemType, null: false 
  end
end
