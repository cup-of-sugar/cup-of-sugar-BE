module AuthToken
  module_function

  PREFIX = 'user-id'.freeze

  def token_for_user(user)
    require "pry"; binding.pry
    crypt.encrypt_and_sign("#{PREFIX}#{user.id}")
  end

  def user_from_token(token)
    return if token.blank?

    user_id = crypt.decrypt_and_verify(token).gsub(PREFIX, '').to_i
    User.find_by id: user_id
  rescue ActiveSupport::MessageVerifier::InvalidSignature
    nil
  end

  def crypt
    ActiveSupport::MessageEncryptor.new(
      ENV['SECRET_KEY']
    )
  end
end
