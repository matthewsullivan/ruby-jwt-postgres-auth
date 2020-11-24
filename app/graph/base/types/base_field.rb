# frozen_string_literal: true

module Base
  module Types
    class BaseField < GraphQL::Schema::Field
      argument_class Base::Types::BaseArgument
    end
  end
end
