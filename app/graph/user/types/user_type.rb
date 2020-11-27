# frozen_string_literal: true

module User::Types
  class UserType < Base::Types::BaseObject
    field :email, String, null: false
    field :first_name, String, null: false
    field :id, ID, null: false
    field :last_name, String, null: false
  end
end
