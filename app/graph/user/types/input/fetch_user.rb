# frozen_string_literal: true

module User::Types::Input
  class FetchUser < Base::Types::BaseInputObject
    description 'Input for fetching a user'

    argument :id, String, required: true
    argument :token, String, required: true
  end
end
