# frozen_string_literal: true

environment ENV.fetch('RAILS_ENV', 'development')
max_threads_count = ENV.fetch('RAILS_MAX_THREADS', 5)
min_threads_count = ENV.fetch('RAILS_MIN_THREADS') { max_threads_count }
pidfile ENV.fetch('PIDFILE', 'tmp/pids/server.pid')
plugin :tmp_restart
port ENV.fetch('PORT', 3000)
threads min_threads_count, max_threads_count
