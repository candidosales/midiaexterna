rails_env = ENV['RAILS_ENV'] || 'development'

threads 4,4

bind  "unix:///home/ubuntu/midiaexterna/current/tmp/puma.sock"
pidfile "/home/ubuntu/midiaexterna/current/tmp/puma/pid"
state_path "/home/ubuntu/current/midiaexterna/tmp/puma/state"

activate_control_app


