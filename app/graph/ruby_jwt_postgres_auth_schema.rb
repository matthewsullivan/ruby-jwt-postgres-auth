# frozen_string_literal: true

class RubyJwtPostgresAuthSchema < GraphQL::Schema
  mutation(Base::Types::MutationType)
  query(Base::Types::QueryType)

  use GraphQL::Analysis::AST
  use GraphQL::Execution::Interpreter
  use GraphQL::Pagination::Connections
end
