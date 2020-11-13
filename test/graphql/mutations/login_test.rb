require 'test_helper'

class Mutations::LoginTest < ActiveSupport::TestCase
  def perform(args = {})
    Mutations::Login.new(object: nil, field: nil, context: { session: {} }).resolve(args)
  end

  def create_user
    user = {
      :first_name => 'Taylor',
      :last_name => 'Doe',
      :email => 'taylordoe@localhost.com',
      :password => '(a1B2c3D4e5F6g)'
    }

    User.create!(user)
  end

  test 'success' do
    user = create_user

    result = perform(
      credentials: {
        email: user.email,
        password: user.password
      }
    )

    assert result[:token].present?
    assert_equal result[:user], user
  end

  test 'failure because no credentials' do
    assert_nil perform
  end

  test 'failure because wrong email' do
    create_user
    assert_nil perform(credentials: { email: 'taylor@localhost.com' })
  end

  test 'failure because wrong password' do
    user = create_user
    assert_nil perform(credentials: { email: user.email, password: 'a1B2c3D4e5F6g' })
  end
end