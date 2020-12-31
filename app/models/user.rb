# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password

  validates :email, format: {
    message: 'invalid format',
    with: URI::MailTo::EMAIL_REGEXP
  }, presence: true, uniqueness: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :password, length: { minimum: 6 }
end
