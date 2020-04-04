module Types
  class ItemType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :quantity, Float, null: false
    field :status, Boolean, null: false
    field :description, String, null: true
    field :measurement, String, null: true
    field :category [Type::CategoryType], null: false
  end
end
