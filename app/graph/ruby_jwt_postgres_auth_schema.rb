# frozen_string_literal: true

class RubyJwtPostgresAuthSchema < GraphQL::Schema
  mutation(Base::Types::MutationType)
  query(Base::Types::QueryType)

  use GraphQL::Analysis::AST
  use GraphQL::Execution::Interpreter
  use GraphQL::Pagination::Connections

  def self.id_from_object(object, type_definition, _query_ctx)
    GraphQL::Schema::UniqueWithinType.encode(type_definition.name, object.id)
  end

  def self.object_from_id(id, _query_ctx)
    _type_name, _item_id = GraphQL::Schema::UniqueWithinType.decode(id)
  end
end
