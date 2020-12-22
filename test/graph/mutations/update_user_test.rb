# frozen_string_literal: true

require 'test_helper'
require 'graphql'
module Mutations
  class UpdateUserTest < ActiveSupport::TestCase
    def perform(args = {})
      result = login_as(users(:john))
      context = { current_user: result[:user] }
      User::Mutations::UpdateUser.new(object: nil, field: nil, context: context).resolve(args)
    end

    test 'should update user' do
      result = perform(
        {
          arguments: {
            first_name: 'Jonathan',
            last_name: 'D.',
            email: 'jonathandoe@localhost.com',
            password: '!a1B2c3D4e5F6g!'
          }
        }
      )
      user = result[:user]

      assert_equal(user.first_name, user[:first_name])
      assert_equal(user.last_name, user[:last_name])
      assert_equal(user.email, user[:email])
    end

    test 'should not update without first name' do
      result = perform(arguments: { first_name: '' })
      assert_equal("Invalid input: First name can't be blank", result.message)
    end

    test 'should not update without last name' do
      result = perform(arguments: { last_name: '' })
      assert_equal("Invalid input: Last name can't be blank", result.message)
    end

    test 'should not update without email' do
      result = perform(arguments: { email: '' })
      assert_equal("Invalid input: Email can't be blank", result.message)
    end

    test 'should not update with pre-existing email' do
      result = perform(arguments: { email: 'janedoe@localhost.com' })
      assert_equal('Invalid input: Email has already been taken', result.message)
    end
  end
end
