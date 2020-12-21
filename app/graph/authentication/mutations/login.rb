# frozen_string_literal: true

module Authentication::Mutations
  class Login < Base::Mutations::BaseMutation
    argument :credentials, Authentication::Types::Input::AuthProviderCredentialsInput, required: false
    field :token, String, null: true
    field :user, User::Types::UserType, null: true

    def resolve(credentials: nil)
      return unless credentials

      login_user(credentials)
    end

    private

    def login_user(credentials)
      user = User.find_by(email: credentials[:email])
      return unless user&.authenticate(credentials[:password])

      token = JwtHelper.encode_token({ user_id: user.id })
      { user: user, token: token }
    end
  end
end
