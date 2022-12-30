# frozen_string_literal: true

max_threads_count = ENV.fetch('RAILS_MAX_THREADS', 5)
min_threads_count = ENV.fetch('RAILS_MIN_THREADS') { max_threads_count }
threads min_threads_count, max_threads_count

worker_timeout 3600 if ENV.fetch('RAILS_ENV', 'development') == 'development'
port ENV.fetch('PORT', 3000)
environment ENV.fetch('RAILS_ENV', 'development')
pidfile ENV.fetch('PIDFILE', 'tmp/pids/server.pid')

workers ENV.fetch("WEB_CONCURRENCY") { 2 }

preload_app!

if ENV.fetch('RAILS_ENV', 'development') == 'production'
  before_fork do 
      @sidekiq_pid ||= spawn('bundle exec sidekiq -t 25')
  end

  on_worker_boot do
    ActiveRecord::Base.establish_connection if defined?(ActiveRecord)
  end

  on_restart do
    Sidekiq.redis.shutdown { |conn| conn.close }
  end
end

plugin :tmp_restart
