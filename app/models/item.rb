class Item < ApplicationRecord
  validates_presence_of :name, :quantity, :status

  belongs_to :category
end
