# frozen_string_literal: true

module Base::Types
  class BaseInputObject < GraphQL::Schema::InputObject
    argument_class Base::Types::BaseArgument
  end
end
