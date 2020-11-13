module Types
  class MutationType < Types::BaseObject
    field :register, mutation: Mutations::Register, description: "Register a new user"
    field :login, mutation: Mutations::Login, description: "Login a pre-existing user"
  end
end
