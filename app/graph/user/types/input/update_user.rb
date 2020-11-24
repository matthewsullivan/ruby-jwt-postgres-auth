# frozen_string_literal: true

module User
  module Types
    module Input
      class UpdateUser < Base::Types::BaseInputObject
        description 'Input for updating a user'

        argument :first_name, String, required: false
        argument :last_name, String, required: false
        argument :email, String, required: false
        argument :password, String, required: false
      end
    end
  end
end
