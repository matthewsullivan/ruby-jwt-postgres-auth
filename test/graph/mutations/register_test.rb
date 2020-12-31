# frozen_string_literal: true

require 'test_helper'

module Mutations
  class RegisterTest < ActionDispatch::IntegrationTest
    def setup
      @user = {
        first_name: 'Taylor',
        last_name: 'Doe',
        email: 'taylordoe@localhost.com',
        password: '(a1B2c3D4e5F6g)'
      }
    end

    def build_parameters(user)
      {
        input: {
          firstName: user[:first_name],
          lastName: user[:last_name],
          authProvider: {
            credentials: {
              email: user[:email],
              password: user[:password]
            }
          }
        }
      }
    end

    def perform(args = {})
      query = <<-GRAPHQL
        mutation($input: RegisterInput!) {
          register(input: $input) {
            email
            firstName
            id
            lastName
          }
        }
      GRAPHQL
      post '/graph', params: { query: query, variables: args }
      JSON.parse(@response.body)
    end

    test 'should register valid user' do
      parameters = build_parameters(@user)
      result = perform(parameters)
      user = result['data']['register']

      assert_equal(user['email'], @user[:email])
      assert_equal(user['firstName'], @user[:first_name])
      assert_equal(user['lastName'], @user[:last_name])
    end

    test 'should not register without first name' do
      @user[:first_name] = ''
      parameters = build_parameters(@user)
      result = perform(parameters)

      assert_equal("Invalid input: First name can't be blank", result['errors'][0]['message'])
    end

    test 'should not register without last name' do
      @user[:last_name] = ''
      parameters = build_parameters(@user)
      result = perform(parameters)

      assert_equal("Invalid input: Last name can't be blank", result['errors'][0]['message'])
    end

    test 'should not register without email' do
      @user[:email] = ''
      parameters = build_parameters(@user)
      result = perform(parameters)

      assert_equal("Invalid input: Email invalid format, Email can't be blank", result['errors'][0]['message'])
    end

    test 'should not register without valid email' do
      @user[:email] = 'taylorlocalhost'
      parameters = build_parameters(@user)
      result = perform(parameters)

      assert_equal('Invalid input: Email invalid format', result['errors'][0]['message'])
    end

    test 'should not register without password' do
      @user[:password] = ''
      parameters = build_parameters(@user)
      result = perform(parameters)

      assert_equal("Invalid input: Password can't be blank, Password is too short (minimum is 6 characters)", result['errors'][0]['message'])
    end

    test 'should not register with short password' do
      @user[:password] = '(a1)'
      parameters = build_parameters(@user)
      result = perform(parameters)

      assert_equal("Invalid input: Password is too short (minimum is 6 characters)", result['errors'][0]['message'])
    end

    test 'should not register with duplicate email' do
      @user[:email] = 'johndoe@localhost.com'
      parameters = build_parameters(@user)
      result = perform(parameters)

      assert_equal('Invalid input: Email has already been taken', result['errors'][0]['message'])
    end
  end
end
