class User < ApplicationRecord
  has_many :posting_users, foreign_key: :poster_id, class_name: 'Posting'
  has_many :responders, through: :posting_users

  has_many :responder_users, foreign_key: :responder_id, class_name: 'Posting'
  has_many :posters, through: :responder_users

  has_many :sending_users, foreign_key: :sender_id, class_name: 'Message'
  has_many :recipients, through: :sending_users

  has_many :recipient_users, foreign_key: :recipient_id, class_name: 'Message'
  has_many :senders, through: :recipient_users

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true

  has_secure_password

  def self.verify_login(params)
    user = User.find_by(email: params[:email])
    if user
      user.authenticate(params[:password])
    else
      false
    end
  end
end
