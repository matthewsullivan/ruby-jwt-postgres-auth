# frozen_string_literal: true

Rails.application.configure do
  config.cache_classes = false
  config.consider_all_requests_local = true
  config.eager_load = false

  if Rails.root.join('tmp', 'caching-dev.txt').exist?
    config.action_controller.enable_fragment_cache_logging = true
    config.action_controller.perform_caching = true
    config.cache_store = :memory_store
    config.public_file_server.headers = {
      "Cache-Control": "public, max-age=#{Integer(2.days, 10)}"
    }
  else
    config.action_controller.perform_caching = false
    config.cache_store = :null_store
  end

  config.action_mailer.perform_caching = false
  config.action_mailer.raise_delivery_errors = false
  config.active_record.migration_error = :page_load
  config.active_record.verbose_query_logs = true
  config.active_storage.service = :local
  config.active_support.deprecation = :log
  config.assets.debug = true
  config.assets.quiet = true
  config.file_watcher = ActiveSupport::EventedFileUpdateChecker
end
