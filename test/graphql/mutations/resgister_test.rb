require 'test_helper'

class Mutations::RegisterTest < ActiveSupport::TestCase
  def perform(args = {})
    Mutations::Register.new(object: nil, field: nil, context: {}).resolve(args)
  end

  user = {
    :first_name => 'Taylor',
    :last_name => 'Doe',
    :email => 'taylordoe@localhost.com',
    :password => '(a1B2c3D4e5F6g)'
  }

  test 'should register valid user' do
    result = perform(
      first_name: user[:first_name],
      last_name: user[:last_name],
      auth_provider: {
        credentials: {
          email: user[:email],
          password: user[:password]
        }
      }
    )

    assert result.persisted?
    assert_equal result.first_name, user[:first_name]
    assert_equal result.last_name, user[:last_name]
    assert_equal result.email, user[:email]
  end

  test 'should not register without first name' do
    exception = assert_raises ActiveRecord::RecordInvalid do
      result = perform(
        first_name: '',
        last_name: user[:last_name],
        auth_provider: {
          credentials: {
            email: user[:email],
            password: user[:password]
          }
        }
      )
    end

    assert_equal("Validation failed: First name can't be blank", exception.message)
  end

  test 'should not register without last name' do
    exception = assert_raises ActiveRecord::RecordInvalid do
      result = perform(
        first_name: user[:first_name],
        last_name: '',
        auth_provider: {
          credentials: {
            email: user[:email],
            password: user[:password]
          }
        }
      )
    end

    assert_equal("Validation failed: Last name can't be blank", exception.message)
  end

  test 'should not register without email' do
    exception = assert_raises ActiveRecord::RecordInvalid do
      result = perform(
        first_name: user[:first_name],
        last_name: user[:last_name],
        auth_provider: {
          credentials: {
            email: '',
            password: user[:password]
          }
        }
      )
    end

    assert_equal("Validation failed: Email can't be blank", exception.message)
  end

  test 'should not register without password' do
    exception = assert_raises ActiveRecord::RecordInvalid do
      result = perform(
        first_name: user[:first_name],
        last_name: user[:last_name],
        auth_provider: {
          credentials: {
            email: user[:email],
            password: ''
          }
        }
      )
    end

    assert_equal("Validation failed: Password can't be blank", exception.message)
  end

  test 'should not register with duplicate email' do
    exception = assert_raises ActiveRecord::RecordInvalid do
      result = perform(
        first_name: user[:first_name],
        last_name: user[:last_name],
        auth_provider: {
          credentials: {
            email: 'johndoe@localhost.com',
            password: user[:password]
          }
        }
      )
    end

    assert_equal('Validation failed: Email has already been taken', exception.message)
  end
end