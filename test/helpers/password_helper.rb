# frozen_string_literal: true

require 'bcrypt'

module PasswordHelper
  def default_password_digest
    BCrypt::Password.create(default_password)
  end

  def default_password
    '(a1B2c3D4e5F6g)'
  end
end
