# frozen_string_literal: true

module Types
  class UserType < Types::BaseObject
    field :id, ID, null: false
    field :first_name, String, null: false
    field :last_name, String, null: false
    field :email, String, null: false
  end
  class UpdateUserAttributes < Types::BaseInputObject
    description 'Arttributes for updating a user'
  
    argument :first_name, String, required: false
    argument :last_name, String, required: false
    argument :email, String, required: false
    argument :password, String, required: false
  end
end
