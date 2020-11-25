# frozen_string_literal: true

ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    def login_as(user)
      args = {
        credentials: {
          email: user.email,
          password: user.password_digest
        }
      }
      Authentication::Mutations::Login.new(object: nil, field: nil, context: { session: {} }).resolve(args)
    end
  end
end
