# frozen_string_literal: true

class RubyJwtPostgresAuthSchema < GraphQL::Schema
  mutation(Base::Types::MutationType)
  query(Base::Types::QueryType)

  # Opt in to the new runtime (default in future graphql-ruby versions)
  use GraphQL::Execution::Interpreter
  use GraphQL::Analysis::AST

  # Add built-in connections for pagination
  use GraphQL::Pagination::Connections
end
