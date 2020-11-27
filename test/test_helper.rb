# frozen_string_literal: true

ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'
require 'helpers/password_helper'

module ActiveSupport
  class TestCase
    include PasswordHelper
    # Add PasswordHelper to fixture set to make availble in users.yml
    ActiveRecord::FixtureSet.context_class.send :include, PasswordHelper

    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

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
