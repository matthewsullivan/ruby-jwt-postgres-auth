# frozen_string_literal: true

module Base::Types
  class MutationType < Base::Types::BaseObject
    field :login, mutation: Authentication::Mutations::Login, description: 'Login a pre-existing user'
    field :register, mutation: User::Mutations::Register, description: 'Register a new user'
    field :update_user, mutation: User::Mutations::UpdateUser, description: 'Update a pre-existing user'
  end
end
