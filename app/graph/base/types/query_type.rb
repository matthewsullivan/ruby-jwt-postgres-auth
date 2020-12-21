# frozen_string_literal: true

module Base::Types
  class QueryType < Base::Types::BaseObject
    field :user, User::Types::UserType, null: false, description: 'A registered user' do
      argument :id, String, required: true
    end

    def user(id:)
      _type, item_id = RubyJwtPostgresAuthSchema.object_from_id(id, nil)
      User.find(item_id)
    end
  end
end
