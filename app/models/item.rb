class Item < ApplicationRecord
  validates_presence_of :name, :quantity, :available, :returnable

  belongs_to :category
end
