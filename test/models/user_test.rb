# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = {
      first_name: 'Taylor',
      last_name: 'Doe',
      email: 'taylordoe@localhost.com',
      password: '(a1B2c3D4e5F6g)'
    }
  end

  test 'should create valid user' do
    user = User.new(@user)

    assert(user.valid?)
  end

  test 'should not create without first and last name' do
    user = User.new(email: @user[:email])

    refute(user.valid?, 'user is not valid without a first and last name')
    assert_not_nil(user.errors[:first_name], 'no first name present')
    assert_not_nil(user.errors[:last_name], 'no last name present')
  end

  test 'should not create without email' do
    user = User.new(first_name: @user[:first_name], last_name: @user[:last_name])

    refute(user.valid?)
    assert_not_nil(user.errors[:email], 'no email present')
  end

  test 'should not create without unique email' do
    @user[:email] = 'johndoe@localhost.com'
    user = User.new(@user)

    refute(user.valid?)
    assert_not_nil(user.errors[:email], 'duplicate email present')
  end

  test 'should not create without valid email' do
    @user[:email] = 'johndoelocalhost'
    user = User.create(@user)

    refute(user.valid?)
    assert_equal(user.errors[:email][0], 'invalid format')
  end

  test 'should not create without password' do
    user = User.new(first_name: @user[:first_name])

    refute(user.valid?)
    assert_not_nil(user.errors[:password], 'no password present')
  end

  test 'should not create with short password' do
    @user[:password] = '(a1)'
    user = User.create(@user)

    refute(user.valid?)
    assert_equal(user.errors[:password][0], 'is too short (minimum is 6 characters)')
  end
end
