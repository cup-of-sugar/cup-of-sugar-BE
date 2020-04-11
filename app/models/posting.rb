class Posting < ApplicationRecord
  validates_presence_of :posting_type, :title

  belongs_to :poster, class_name: 'User'
  belongs_to :responder, class_name: 'User', optional: true

  has_many :items
  enum posting_type: ['borrow', 'lend']
end
