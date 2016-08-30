app_home = ENV['APP_HOME']

env = ENV['RAILS_ENV']
environment env

workers 1

threads 1, 3

bind 'tcp://0.0.0.0:8000'
preload_app!

pidfile "#{app_home}/tmp/pids/puma.pid"

stdout_redirect "#{app_home}/log/puma.stdout.log", "#{app_home}/log/puma.stderr.log", true

on_worker_boot do
  ActiveRecord::Base.establish_connection if defined?(ActiveRecord)
end
