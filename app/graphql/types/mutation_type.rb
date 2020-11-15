# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    field :login, mutation: Mutations::Login, description: 'Login a pre-existing user'
    field :register, mutation: Mutations::Register, description: 'Register a new user'
  end
end
