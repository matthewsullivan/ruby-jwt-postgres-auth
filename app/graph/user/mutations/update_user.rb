# frozen_string_literal: true

module User::Mutations
  class UpdateUser < Base::Mutations::BaseMutation
    argument :arguments, User::Types::Input::UpdateUser, required: true

    field :user, User::Types::UserType, null: true

    def resolve(arguments:)
      current_user = context[:current_user]
      raise StandardError unless current_user

      current_user.update!(arguments.to_hash.except!(:token))
      { user: current_user }
    rescue ActiveRecord::RecordInvalid => e
      GraphQL::ExecutionError.new("Invalid input: #{e.record.errors.full_messages.join(', ')}")
    rescue StandardError
      GraphQL::ExecutionError.new('Must be logged in to access requested resource')
    end
  end
end
