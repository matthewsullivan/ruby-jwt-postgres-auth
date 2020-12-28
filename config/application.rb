# frozen_string_literal: true

require_relative 'boot'
require 'rails/all'

Bundler.require(*Rails.groups)
module RubyJwtPostgresAuth
  class Application < Rails::Application
    config.api_only = true
    config.load_defaults(6.0)

    config.before_configuration do
      env_file = File.join(Rails.root, 'config', 'local_env.yml')
      if File.exist?(env_file)
        YAML.safe_load(File.open(env_file)).each do |key, value|
          ENV[key.to_s] = value
        end
      end
    end
  end
end
