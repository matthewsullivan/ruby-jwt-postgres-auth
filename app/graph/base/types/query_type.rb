# frozen_string_literal: true

module Base::Types
  class QueryType < Base::Types::BaseObject
    field :fetchUser, resolver: User::Queries::FetchUser
  end
end
