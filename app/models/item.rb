class Item < ApplicationRecord
  validates_presence_of :name, :quantity, :returnable

  belongs_to :category
end
