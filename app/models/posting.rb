class Posting < ApplicationRecord
  validates_presence_of :posting_type

  belongs_to :item
  enum posting_type: ['borrow', 'lend']
end
