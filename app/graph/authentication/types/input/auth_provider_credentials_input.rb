# frozen_string_literal: true

module Authentication
  module Types
    module Input
      class AuthProviderCredentialsInput < Base::Types::BaseInputObject
        # the name is usually inferred by class name but can be overwritten
        graphql_name 'AUTH_PROVIDER_CREDENTIALS'

        argument :email, String, required: true
        argument :password, String, required: true
      end
    end
  end
end
