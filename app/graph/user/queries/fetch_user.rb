# frozen_string_literal: true

module User::Queries
  class FetchUser < Base::Mutations::BaseMutation
    argument :arguments, User::Types::Input::FetchUser, required: true
    field :user, User::Types::UserType, null: true

    def resolve(arguments:)
      current_user = context[:current_user]
      raise StandardError unless current_user

      _type, item_id = RubyJwtPostgresAuthSchema.object_from_id(arguments[:id], nil)
      User.find(item_id)
      { user: current_user }
    rescue ActiveRecord::RecordNotFound => e
      GraphQL::ExecutionError.new("Invalid input: #{e.message}")
    rescue StandardError => e
      GraphQL::ExecutionError.new('Must be logged in to access requested resource')
    end
  end
end
