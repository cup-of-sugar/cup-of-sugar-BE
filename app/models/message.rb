class Message < ApplicationRecord

  belongs_to :sender, class_name: 'User'
  belongs_to :recipient, class_name: 'User'

  validates_presence_of :title, :body, :sender_id, :recipient_id

end
