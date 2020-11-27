# frozen_string_literal: true

module Authentication::Types::Input
  class AuthProviderCredentialsInput < Base::Types::BaseInputObject
    argument :email, String, required: true
    argument :password, String, required: true
  end
end
