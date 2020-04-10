class User < ApplicationRecord
  has_many :items

  has_secure_password

  def self.verify_login(params)
    user = User.find_by(email: params[:email])
    user.authenticate(params[:password])
  end
end
