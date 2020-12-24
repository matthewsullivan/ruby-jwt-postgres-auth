# frozen_string_literal: true

module Authentication::Mutations
  class Login < Base::Mutations::BaseMutation
    argument :credentials, Authentication::Types::Input::AuthProviderCredentialsInput, required: false
    field :token, String, null: true
    field :user, User::Types::UserType, null: true

    def resolve(credentials: nil)
      raise StandardError unless credentials

      login_user!(credentials)
    rescue ActiveRecord::RecordNotFound => e
      GraphQL::ExecutionError.new("Invalid input: #{e.message}")
    rescue StandardError
      GraphQL::ExecutionError.new('Invalid credentials')
    end

    private

    def login_user!(credentials)
      user = User.find_by(email: credentials[:email])
      raise StandardError unless user&.authenticate(credentials[:password])

      token = JwtHelper.encode_token({ user_id: user.id })
      { user: user, token: token }
    end
  end
end
