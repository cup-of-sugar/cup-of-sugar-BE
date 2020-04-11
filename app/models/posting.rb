class Posting < ApplicationRecord
  belongs_to :item
  belongs_to :poster, class_name: 'User'
  belongs_to :responder, class_name: 'User', optional: true
end
