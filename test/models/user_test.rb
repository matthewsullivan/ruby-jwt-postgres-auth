require 'test_helper'

class UserTest < ActiveSupport::TestCase
  user = {
    :first_name => 'Taylor',
    :last_name => 'Doe',
    :email => 'taylordoe@localhost.com',
    :password => '(a1B2c3D4e5F6g)'
  }

  test 'creates valid user' do
    user = User.new(user)
    assert user.valid?
  end

  test 'invalid without first and last name' do
    user = User.new(email: user[:email])
    refute user.valid?, 'user is not valid without a first and last name'
    assert_not_nil user.errors[:first_name], 'no first name present'
    assert_not_nil user.errors[:last_name], 'no last name present'
  end

  test 'invalid without email' do
    user = User.new(first_name: user[:first_name], last_name: user[:last_name])
    refute user.valid?
    assert_not_nil user.errors[:email], 'no email present'
  end

  test 'invalid without unique email' do
    user[:email] = 'johndoe@localhost.com'

    user = User.new(user)
    refute user.valid?
    assert_not_nil user.errors[:email], 'duplicate email present'
  end

  test 'invalid without password' do
    user = User.new(first_name: user[:first_name])
    refute user.valid?
    assert_not_nil user.errors[:password], 'no password present'
  end
end
