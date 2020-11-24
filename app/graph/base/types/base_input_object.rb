# frozen_string_literal: true

module Base
  module Types
    class BaseInputObject < GraphQL::Schema::InputObject
      argument_class Base::Types::BaseArgument
    end
  end
end
