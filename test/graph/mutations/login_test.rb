# frozen_string_literal: true

require 'test_helper'

module Mutations
  class LoginTest < ActiveSupport::TestCase
    def create_user
      user = {
        first_name: 'Taylor',
        last_name: 'Doe',
        email: 'taylordoe@localhost.com',
        password: '(a1B2c3D4e5F6g)'
      }
      User.create!(user)
    end

    def perform(args = {})
      Authentication::Mutations::Login.new(object: nil, field: nil, context: {}).resolve(args)
    end

    test 'should login with valid credentails' do
      user = create_user
      result = perform(
        credentials: {
          email: user.email,
          password: user.password
        }
      )
      assert_equal(result[:user], user)
    end

    test 'should login and return token' do
      user = create_user
      result = perform(
        credentials: {
          email: user.email,
          password: user.password
        }
      )
      assert(result[:token].present?)
    end

    test 'should not login without credentials' do
      assert_nil(perform)
    end

    test 'should not login with wrong email' do
      create_user
      assert_nil(perform(credentials: { email: 'taylor@localhost.com' }))
    end

    test 'should not login with wrong password' do
      user = create_user
      assert_nil(perform(credentials: { email: user.email, password: 'a1B2c3D4e5F6g' }))
    end
  end
end
