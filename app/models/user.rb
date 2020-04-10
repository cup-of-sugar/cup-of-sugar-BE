class User < ApplicationRecord
  has_many :items

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
