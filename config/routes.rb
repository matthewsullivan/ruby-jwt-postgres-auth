# frozen_string_literal: true

Rails.application.routes.draw do
  mount GraphiQL::Rails::Engine, at: '/graphiql', graphql_path: '/graph' if Rails.env.development?

  post '/graph', to: 'graphql#execute'
end
