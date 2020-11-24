# frozen_string_literal: true

module Base::Types
  module BaseInterface
    include GraphQL::Schema::Interface

    field_class Base::Types::BaseField
  end
end
