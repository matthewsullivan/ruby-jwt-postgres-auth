# frozen_string_literal: true

require 'test_helper'
require 'graphql'
module Mutations
  class UpdateUserTest < ActionDispatch::IntegrationTest
    def setup
      @token = login_as(users(:john))[:token]
    end

    def perform(args = {})
      query = <<-GRAPHQL
        mutation ($input: UpdateUserInput!) {
          updateUser (input: $input){
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

    test 'should not update without valid token' do
      parameters = {
        input: {
          arguments: {
            email: 'janedoe@localhost.com'
          }
        }
      }
      @token = ''
      result = perform(parameters)

      assert_equal('Must be logged in to access requested resource', result['errors'][0]['message'])
    end

    test 'should update user' do
      parameters = {
        input: {
          arguments: {
            firstName: 'Jonathan',
            lastName: 'D.',
            email: 'jonathandoe@localhost.com',
            password: '!a1B2c3D4e5F6g!'
          }
        }
      }
      result = perform(parameters)
      user = result['data']['updateUser']['user']

      assert_equal(user['email'], parameters[:input][:arguments][:email])
      assert_equal(user['firstName'], parameters[:input][:arguments][:firstName])
      assert_equal(user['lastName'], parameters[:input][:arguments][:lastName])
    end

    test 'should not update without first name' do
      parameters = {
        input: {
          arguments: {
            firstName: ''
          }
        }
      }
      result = perform(parameters)

      assert_equal("Invalid input: First name can't be blank", result['errors'][0]['message'])
    end

    test 'should not update without last name' do
      parameters = {
        input: {
          arguments: {
            lastName: ''
          }
        }
      }
      result = perform(parameters)

      assert_equal("Invalid input: Last name can't be blank", result['errors'][0]['message'])
    end

    test 'should not update without email' do
      parameters = {
        input: {
          arguments: {
            email: ''
          }
        }
      }
      result = perform(parameters)

      assert_equal("Invalid input: Email can't be blank", result['errors'][0]['message'])
    end

    test 'should not update with pre-existing email' do
      parameters = {
        input: {
          arguments: {
            email: 'janedoe@localhost.com'
          }
        }
      }
      result = perform(parameters)

      assert_equal('Invalid input: Email has already been taken', result['errors'][0]['message'])
    end
  end
end
