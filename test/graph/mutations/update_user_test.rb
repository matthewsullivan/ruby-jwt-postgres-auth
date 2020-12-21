# frozen_string_literal: true

require 'test_helper'
require 'graphql'
module Mutations
  class UpdateUserTest < ActiveSupport::TestCase
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
      result = login_as(users(:john))
      context = { current_user: result[:user] }
      User::Mutations::UpdateUser.new(object: nil, field: nil, context: context).resolve(args)
    end

    test 'should update user' do
      args = build_args
      result = perform(args)
      user = result[:user]

      assert_equal(user.first_name, user[:first_name])
      assert_equal(user.last_name, user[:last_name])
      assert_equal(user.email, user[:email])
    end

    test 'should not update without first name' do
      exception = assert_raises ActiveRecord::RecordInvalid do
        perform(arguments: { first_name: '' })
      end
      assert_equal("Validation failed: First name can't be blank", exception.message)
    end

    test 'should not update without last name' do
      exception = assert_raises ActiveRecord::RecordInvalid do
        perform(arguments: { last_name: '' })
      end
      assert_equal("Validation failed: Last name can't be blank", exception.message)
    end

    test 'should not update without email' do
      exception = assert_raises ActiveRecord::RecordInvalid do
        perform(arguments: { email: '' })
      end
      assert_equal("Validation failed: Email can't be blank", exception.message)
    end

    test 'should not update with pre-existing email' do
      exception = assert_raises ActiveRecord::RecordInvalid do
        perform(arguments: { email: 'janedoe@localhost.com' })
      end
      assert_equal('Validation failed: Email has already been taken', exception.message)
    end
  end
end
