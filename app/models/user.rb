class User < ApplicationRecord
  has_many :posting_users, foreign_key: :poster_id, class_name: 'Posting'
  has_many :responders, through: :posting_users

  has_many :responder_users, foreign_key: :responder_id, class_name: 'Posting'
  has_many :posters, through: :responder_users

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
