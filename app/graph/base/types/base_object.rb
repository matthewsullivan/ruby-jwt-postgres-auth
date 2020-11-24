# frozen_string_literal: true

module Base
  module Types
    class BaseObject < GraphQL::Schema::Object
      field_class Base::Types::BaseField
    end
  end
end
