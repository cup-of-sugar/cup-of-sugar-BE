class Item < ApplicationRecord
  validates_presence_of :name, :quantity

  belongs_to :category
  belongs_to :user
  # has_many :postings
  belongs_to :posting
end
