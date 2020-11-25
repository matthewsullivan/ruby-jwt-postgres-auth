# frozen_string_literal: true

require 'test_helper'

module Mutations
  class UpdateUserTest < ActiveSupport::TestCase
    setup do
      login_as(users[0])
    end

    def build_args
      {
        arguments: {
          first_name: 'Jonathan',
          last_name: 'D.',
          email: 'jonathandoe@localhost.com',
          password: '!a1B2c3D4e5F6g!'
        }
      }
    end

    def perform(args = {})
      User::Mutations::UpdateUser.new(object: nil, field: nil, context: {}).resolve(args)
    end

    test 'should update user' do
      args = build_args
      result = perform(args)

      assert result.persisted?
      assert_equal result.first_name, user[:first_name]
      assert_equal result.last_name, user[:last_name]
      assert_equal result.email, user[:email]
    end

    test 'should not register without first name' do
      exception = assert_raises ActiveRecord::RecordInvalid do
        perform(arguments: { first_name: '' })
      end

      assert_equal("Validation failed: First name can't be blank", exception.message)
    end
  end
end
