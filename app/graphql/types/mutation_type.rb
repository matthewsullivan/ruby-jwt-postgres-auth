# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    field :login, mutation: Mutations::Login, description: 'Login a pre-existing user'
    field :register, mutation: Mutations::Register, description: 'Register a new user'
    field :update_user, mutation: Mutations::UpdateUser, description: 'Update user profile'
  end
end
