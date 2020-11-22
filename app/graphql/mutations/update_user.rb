# frozen_string_literal: true

module Mutations
  class UpdateUser < BaseMutation
    argument :arguments, Types::UpdateUserAttributes, required: true
    field :user, Types::UserType, null: true

    def resolve(arguments:)
      current_user = context[:current_user]
      return unless current_user
      current_user.update!(arguments.to_hash)

      { user: current_user }
    end
  end
end
