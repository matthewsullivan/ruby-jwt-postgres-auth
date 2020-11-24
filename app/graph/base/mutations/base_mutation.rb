# frozen_string_literal: true

module Base::Mutations
  class BaseMutation < GraphQL::Schema::RelayClassicMutation
    argument_class Base::Types::BaseArgument
    field_class Base::Types::BaseField
    input_object_class Base::Types::BaseInputObject
    object_class Base::Types::BaseObject
  end
end
