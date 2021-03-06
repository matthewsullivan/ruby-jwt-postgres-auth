# frozen_string_literal: true

module User::Mutations
  class Register < Base::Mutations::BaseMutation
    class AuthProviderSignupData < Base::Types::BaseInputObject
      argument :credentials, Authentication::Types::Input::AuthProviderCredentialsInput, required: false
    end

    argument :auth_provider, AuthProviderSignupData, required: false
    argument :last_name, String, required: true
    argument :first_name, String, required: true

    type User::Types::UserType

    def resolve(first_name: nil, last_name: nil, auth_provider: nil)
      User.create!(
        email: auth_provider&.[](:credentials)&.[](:email),
        first_name: first_name,
        last_name: last_name,
        password: auth_provider&.[](:credentials)&.[](:password)
      )
    rescue ActiveRecord::RecordInvalid => e
      GraphQL::ExecutionError.new("Invalid input: #{e.record.errors.full_messages.join(', ')}")
    end
  end
end
