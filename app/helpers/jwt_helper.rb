# frozen_string_literal: true

module JwtHelper
  class << self
    SECRET = ENV['JWT_SECRET']

    def encode_token(payload)
      payload[:exp] = Time.now.to_i + ENV['JWT_EXPIRATION'].to_i
      JWT.encode(payload, SECRET)
    end

    def logged_in_user(token)
      decoded_token = decoded_token(token)
      return unless decoded_token

      user_id = decoded_token[0]['user_id']
      User.find(user_id)
    rescue ActiveRecord::RecordNotFound => e
      GraphQL::ExecutionError.new(e.message)
    end

    private

    def decoded_token(token)
      JWT.decode(token, SECRET, true, algorithm: ENV['JWT_ALGORITHM'])
    rescue JWT::ExpiredSignature, StandardError => e
      GraphQL::ExecutionError.new(e.message)
      nil
    end
  end
end
