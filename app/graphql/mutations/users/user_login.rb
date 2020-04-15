module Mutations
  module Users
    class UserLogin < ::Mutations::BaseMutation
      null true

      argument :credentials, Types::AuthProviderCredentialsInput, required: false

      field :user, Types::UserType, null: true
      field :token, String, null: true

      def resolve(params)
        user = User.verify_login(params)
        return unless user

        token = AuthToken.token_for_user(user)

        { user: user, token: token }
      end
    end
  end
end
