# frozen_string_literal: true

require 'test_helper'
require 'graphql'
module Mutations
  class FetchUserTest < ActionDispatch::IntegrationTest
    def setup
      @token = login_as(users(:john))[:token]
    end

    def perform(args = {})
      query = <<-GRAPHQL
        query ($input: FetchUserInput!) {
          fetchUser(input: $input) {
            user {
              email
              firstName
              lastName
            }
          }
        }
      GRAPHQL
      post '/graph', params: { query: query, variables: args }, headers: { 'HTTP_AUTHORIZATION' => "Bearer: #{@token}" }
      JSON.parse(@response.body)
    end

    test 'should fetch user' do
      user = users(:jane)
      encoded_id = RubyJwtPostgresAuthSchema.id_from_object(user, User, nil)
      parameters = {
        input: {
          arguments: {
            id: encoded_id
          }
        }
      }
      result = perform(parameters)
      fetched_user = result['data']['fetchUser']['user']

      assert_equal(user[:email], fetched_user['email'])
      assert_equal(user[:first_name], fetched_user['firstName'])
      assert_equal(user[:last_name], fetched_user['lastName'])
    end

    test 'should not fetch user without valid token' do
      parameters = {
        input: {
          arguments: {
            id: 'A1b2C3d4'
          }
        }
      }
      @token = ''
      result = perform(parameters)

      assert_equal('Must be logged in to access requested resource', result['errors'][0]['message'])
    end

    test 'should not fetch user without valid id' do
      parameters = {
        input: {
          arguments: {
            id: 'A1b2C3d4'
          }
        }
      }
      result = perform(parameters)

      assert_equal("Invalid input: Couldn't find User without an ID", result['errors'][0]['message'])
    end
  end
end
