# frozen_string_literal: true

module Mutations
  class UpdateUser < BaseMutation
    argument :credentials, Types::AuthProviderCredentialsInput, required: false
    argument :first_name, String, required: false
    argument :last_name, String, required: false
    argument :email, String, required: false

    field :user, Types::UserType, null: true

    def resolve(credentials: credentials, first_name: first_name, last_name: last_name, email:email)
      return unless context[:current_user]
      current_user = context[:current_user]

      current_user.update(
        first_name: first_name,
        last_name: last_name,
        email: credentials[:email],
        password: credentials[:password]
      )

      { user: current_user }
    end
  end
end
