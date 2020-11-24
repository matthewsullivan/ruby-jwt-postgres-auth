# frozen_string_literal: true

module Base::Types
  class BaseField < GraphQL::Schema::Field
    argument_class Base::Types::BaseArgument
  end
end
