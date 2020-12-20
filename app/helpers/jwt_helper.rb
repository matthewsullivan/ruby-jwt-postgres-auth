# frozen_string_literal: true

module JwtHelper
  class << self
    SECRET = ENV['RJPA_SECRET']

    def encode_token(payload)
      JWT.encode(payload, SECRET)
    end

    def logged_in_user(token)
      decoded_token = decoded_token(token)
      return unless decoded_token

      user_id = decoded_token[0]['user_id']
      User.find(user_id)
    end

    private

    def decoded_token(token)
      JWT.decode(token, SECRET, true, algorithm: ENV['JWT_ALGORITHM'])
    rescue StandardError => e
      puts e.message
      nil
    end
  end
end
