module Types
  class MutationType < Types::BaseObject
    field :create_user, mutation: Mutations::CreateUser, description: "Create a new user"
    field :sign_in_user, mutation: Mutations::SignInUser, description: "Sign in a pre-existing user"
    # TODO: remove me
    field :test_field, String, null: false,
      description: "An example field added by the generator"
    def test_field
      "Hello World"
    end
  end
end
