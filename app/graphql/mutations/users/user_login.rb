module Mutations
  module Users
    class UserLogin < ::Mutations::BaseMutation
      argument :email, String, required: true
      argument :password, String, required: true

      field :email, String, null: true
      field :id, ID, null: false

      def resolve(params)
        user = User.verify_login(params)
        if user == false
          { "email"=> nil }
        else
          user
        end
      end
    end
  end
end
