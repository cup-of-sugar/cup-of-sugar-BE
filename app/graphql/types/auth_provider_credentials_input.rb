module Types
  class AuthProviderCredentialsInput < BaseInputObject

    graphql_name 'AUTH_PROVIDER_CREDENTIALS'

    argument :first_name, String, required: false
    argument :last_name, String, required: false
    argument :email, String, required: true
    argument :password, String, required: true
  end
end
