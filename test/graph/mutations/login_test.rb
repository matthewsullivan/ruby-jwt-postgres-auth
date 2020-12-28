# frozen_string_literal: true

require 'test_helper'

module Mutations
  class LoginTest < ActionDispatch::IntegrationTest
    def create_user
      user = {
        first_name: 'Taylor',
        last_name: 'Doe',
        email: 'taylordoe@localhost.com',
        password: '(a1B2c3D4e5F6g)'
      }
      User.create!(user)
    end

    def fetch_user(result)
      user_id = result['data']['login']['user']['id']
      _type, item_id = RubyJwtPostgresAuthSchema.object_from_id(user_id, nil)
      User.find(item_id)
    end

    def perform(args = {})
      query = <<-GRAPHQL
        mutation ($input: LoginInput!) {
          login (input: $input){
            token
            user {
              email
              firstName
              id
              lastName
            }
          }
        }
      GRAPHQL
      post '/graph', params: { query: query, variables: args }
      JSON.parse(@response.body)
    end

    test 'should login with valid credentails' do
      new_user = create_user
      parameters = {
        input: {
          credentials: {
            email: new_user.email,
            password: new_user.password
          }
        }
      }
      result = perform(parameters)
      user = fetch_user(result)

      assert_equal(user, new_user)
    end

    test 'should login and return token' do
      new_user = create_user
      parameters = {
        input: {
          credentials: {
            email: new_user.email,
            password: new_user.password
          }
        }
      }
      result = perform(parameters)

      assert(result['data']['login']['token'].present?)
    end

    test 'should not login with wrong email' do
      new_user = create_user
      parameters = {
        input: {
          credentials: {
            email: 'taylor@localhost.com',
            password: new_user.password
          }
        }
      }
      result = perform(parameters)

      assert_equal('Invalid credentials', result['errors'][0]['message'])
    end

    test 'should not login with wrong password' do
      new_user = create_user
      parameters = {
        input: {
          credentials: {
            email: new_user.email,
            password: 'a1B2c3D4e5F6g'
          }
        }
      }
      result = perform(parameters)

      assert_equal('Invalid credentials', result['errors'][0]['message'])
    end
  end
end
