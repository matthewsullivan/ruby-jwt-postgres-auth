# frozen_string_literal: true

module User
  module Mutations
    class UpdateUser < Base::Mutations::BaseMutation
      argument :arguments, User::Types::Input::UpdateUser, required: true
      field :user, User::Types::UserType, null: true

      def resolve(arguments:)
        current_user = context[:current_user]
        return unless current_user

        current_user.update!(arguments.to_hash)

        { user: current_user }
      end
    end
  end
end
