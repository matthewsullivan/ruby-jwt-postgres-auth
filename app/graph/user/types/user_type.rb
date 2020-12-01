# frozen_string_literal: true

module User::Types
  class UserType < Base::Types::BaseObject
    global_id_field :id

    field :email, String, null: false
    field :first_name, String, null: false
    field :last_name, String, null: false
  end
end
