# frozen_string_literal: true

module Base
  module Types
    module BaseInterface
      include GraphQL::Schema::Interface

      field_class Base::Types::BaseField
    end
  end
end
