# frozen_string_literal: true

require 'test_helper'

module Mutations
  class RegisterTest < ActiveSupport::TestCase
    def setup
      @user = {
        first_name: 'Taylor',
        last_name: 'Doe',
        email: 'taylordoe@localhost.com',
        password: '(a1B2c3D4e5F6g)'
      }
    end

    def build_args(user)
      {
        first_name: user[:first_name],
        last_name: user[:last_name],
        auth_provider: {
          credentials: {
            email: user[:email],
            password: user[:password]
          }
        }
      }
    end

    def perform(args = {})
      User::Mutations::Register.new(object: nil, field: nil, context: {}).resolve(args)
    end

    test 'should register valid user' do
      args = build_args(@user)
      result = perform(args)

      assert(result.persisted?)
      assert_equal(result.first_name, @user[:first_name])
      assert_equal(result.last_name, @user[:last_name])
      assert_equal(result.email, @user[:email])
    end

    test 'should not register without first name' do
      exception = assert_raises ActiveRecord::RecordInvalid do
        @user[:first_name] = ''
        args = build_args(@user)
        perform(args)
      end
      assert_equal("Validation failed: First name can't be blank", exception.message)
    end

    test 'should not register without last name' do
      exception = assert_raises ActiveRecord::RecordInvalid do
        @user[:last_name] = ''
        args = build_args(@user)
        perform(args)
      end
      assert_equal("Validation failed: Last name can't be blank", exception.message)
    end

    test 'should not register without email' do
      exception = assert_raises ActiveRecord::RecordInvalid do
        @user[:email] = ''
        args = build_args(@user)
        perform(args)
      end
      assert_equal("Validation failed: Email can't be blank", exception.message)
    end

    test 'should not register without password' do
      exception = assert_raises ActiveRecord::RecordInvalid do
        @user[:password] = ''
        args = build_args(@user)
        perform(args)
      end
      assert_equal("Validation failed: Password can't be blank", exception.message)
    end

    test 'should not register with duplicate email' do
      exception = assert_raises ActiveRecord::RecordInvalid do
        @user[:email] = 'johndoe@localhost.com'
        args = build_args(@user)
        perform(args)
      end
      assert_equal('Validation failed: Email has already been taken', exception.message)
    end
  end
end
