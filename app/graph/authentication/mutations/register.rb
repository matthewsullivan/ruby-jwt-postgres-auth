# frozen_string_literal: true

module Authentication::Mutations
  class Register < Base::Mutations::BaseMutation
    class AuthProviderSignupData < Base::Types::BaseInputObject
      argument :credentials, Authentication::Types::Input::AuthProviderCredentialsInput, required: false
    end

    argument :auth_provider, AuthProviderSignupData, required: false
    argument :first_name, String, required: true
    argument :last_name, String, required: true

    type User::Types::UserType

    def resolve(first_name: nil, last_name: nil, auth_provider: nil)
      User.create!(
        first_name: first_name,
        last_name: last_name,
        email: auth_provider&.[](:credentials)&.[](:email),
        password: auth_provider&.[](:credentials)&.[](:password)
      )
    end
  end
end
