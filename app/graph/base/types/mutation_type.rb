# frozen_string_literal: true

module Base
  module Types
    class MutationType < Base::Types::BaseObject
      field :register, mutation: Authentication::Mutations::Register, description: 'Register a new user'
      field :login, mutation: User::Mutations::Login, description: 'Login a pre-existing user'
      field :update_user, mutation: User::Mutations::UpdateUser, description: 'Update a pre-existing user'
    end
  end
end
