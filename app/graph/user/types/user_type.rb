# frozen_string_literal: true

module User
  module Types
    class UserType < Base::Types::BaseObject
      field :id, ID, null: false
      field :first_name, String, null: false
      field :last_name, String, null: false
      field :email, String, null: false
    end
  end
end
