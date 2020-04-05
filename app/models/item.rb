class Item < ApplicationRecord
  validates_presence_of :name, :quantity, :available

  belongs_to :category
end
