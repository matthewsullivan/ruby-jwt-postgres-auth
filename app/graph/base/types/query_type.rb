# frozen_string_literal: true

module Base::Types
  class QueryType < Base::Types::BaseObject
    field :user, User::Types::UserType, null: false, description: 'An example field added by the generator'
  end
end
