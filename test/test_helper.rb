# frozen_string_literal: true

ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'
require 'helpers/password_helper'

module ActiveSupport
  class TestCase
    # Add PasswordHelper to fixture set to make availble in users.yml
    include PasswordHelper
    ActiveRecord::FixtureSet.context_class.send :include, PasswordHelper

    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    def login_as(user)
      args = {
        credentials: {
          email: user.email,
          password: default_password
        }
      }
      Authentication::Mutations::Login.new(object: nil, field: nil, context: { session: {} }).resolve(args)
    end
  end
end
