module Types
  class ItemType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :quantity, Float, null: false
    field :available, Boolean, null: false
    field :description, String, null: true
    field :measurement, String, null: true
    field :time_duration, String, null: true
    field :returnable, Boolean, null: false
    field :category, Types::CategoryType, null: false
    field :returnable, Boolean, null: false
    field :posting_id, ID, null: false

    field :posting, Types::PostingType, null: true
  end
end
