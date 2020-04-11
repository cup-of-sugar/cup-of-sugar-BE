class Posting < ApplicationRecord
  validates_presence_of :posting_type, :title

  has_many :items
  enum posting_type: ['borrow', 'lend']
end
